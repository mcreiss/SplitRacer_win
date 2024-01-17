function [tra_energy_ges,phimin1,deltamin1,phimin2,deltamin2,tmin] =  ...
    inversion_2L_fixed(north_ges, east_ges, dt_ges, Baz, fa_area, res_t, res_d)

% inversion for two layer joint splitting

% usage: 
% north_ges & east_ges: time series in struct
% dt_ges: sample distance
% Baz: back azimuth (in deg)
% fa_area: search interval for phi range
% res_t: resolution in search interval for delay time
% res_d: resolution in search interval for fast polarization

% Copyright 2016 M.Reiss and G.Rümpker
disp('warning - fixed lower layer')

tra_energy = zeros(res_t,res_d);  %new
tra_energy_ges = zeros(res_t,res_d); %new
tra_energy_org_ges = 0;

% tranformation of north east to radial-transversal

for i = 1:length(north_ges)
    [rad_s, tra_s] =  rad_tra (north_ges{i}, east_ges{i}, Baz(i));
    %to frequency domain and overwrite
    rad(:,i) = gft(rad_s);
    tra(:,i) = gft(tra_s);
    % calculate energy on transverse component
    tra_energy_org = sum(dot(tra(:,i),tra(:,i)));
    tra_energy_org_ges = tra_energy_org_ges+tra_energy_org;
end


% search for fast angle and delay time

%grid interval for degree domain (fast axis direction),First Layer
%parfor k1 = 1:res_d                         
    phideg1 = 75; %new

     %grid interval for time domain
    %for k2 = 1:res_t                      
        delta1 = 1.0; %new
        % grid interval for degree domain second layer
        parfor l1 = 1:res_d         % put parallelized computation in first loop         
            phideg2 = (l1*(180/(res_d-1))-(180/(res_d-1)))*1-fa_area;
            %grid interval for time domain second layer
            for l2 = 1:res_t
                delta2 = l2*(2/res_t) ;
                
                % inversion

                for i = 1:length(north_ges)
                    [~,invtra] = invopradtra_2L(rad(:,i),tra(:,i),...
                        dt_ges(i),delta1,phideg1,delta2,phideg2,Baz(i));

                    tra_energy(l2,l1) = sum(dot(invtra,invtra)); %new
                    tra_energy_ges(l2,l1) = tra_energy_ges(...
                        l2,l1)+tra_energy(l2,l1); %new
                   
                end

            end
        
        end
       
    %end

%end

% find minimum energy and corresponding splitting parameters
[tmin, minidx] = min(tra_energy_ges(:));
[l2_min, l1_min] = ind2sub(size(tra_energy_ges), minidx); %new

phimin1 = phideg1; %new
deltamin1 = delta1; %new
phimin2 = (l1_min*(180/(res_d-1))-(180/(res_d-1)))*1-fa_area;
deltamin2 = l2_min*(2/res_t);
tmin = tmin/tra_energy_org_ges;

end

