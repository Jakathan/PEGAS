%experimental vehicle creation model
clearvars vehicle
%from now we'll work with arrays of 'stage' structs
%first stage Shuttle: 3 SSMEs, 2 SRBs
stage_m0 = 2*590000+760000+109000;          %launch mass [kg]   STS: boosters, ET, loaded orbiter
stage_thrust = 2*12000000+3*1750000;        %thrust ASL [N]     STS: boosters + orbiter
stage_isp1 = 257.7;                         %ISP ASL [s]        STS: combined boosters + orbiter
stage_isp0 = 291.2;                         %ISP VAC [s]        STS: combined boosters + orbiter
stage_time = 127;                           %burn time [s]      STS: fixed
stage_area = 2*10.8 + 55.4 + 15.2;          %cross section [m2] STS: boosters, ET, orbiter
stage_drag = [ 0.0  0.08;
               250  0.08;
               343  1.20;
               999  0.50;
               9999 0.40; ];                %drag curve, pretty much random data
stage_dm = stage_thrust/(stage_isp1*g0);    %mass flow rate [kg/s]
stage = struct('m0', stage_m0,...
               'dm', stage_dm,...
               'i0', stage_isp0,...
               'i1', stage_isp1,...
               'mt', stage_time,...
               'ra', stage_area,...
               'dc', stage_drag);
vehicle(1) = stage;
%second stage: orbiter+ET (with some fuel burnt away)
stage_m0 = 760000 - 185763 + 109000;        %ET - fuel burnt in stage 1, orbiter
stage_thrust = 3*1750000;
stage_isp1 = 366;
stage_isp0 = 452;
stage_time = 501-127;                       %ET fuel mass / SSME mass flow
stage_area = 55.4 + 15.2;
stage_drag = [999 0.5; 9999 0.4; ];         %it will mostly run in VAC anyway
stage_dm = stage_thrust/(stage_isp1*g0);
stage = struct('m0', stage_m0,...
               'dm', stage_dm,...
               'i0', stage_isp0,...
               'i1', stage_isp1,...
               'mt', stage_time,...
               'ra', stage_area,...
               'dc', stage_drag);
vehicle(2) = stage;
clearvars stage_m0 stage_thrust stage_isp0 stage_isp1 stage_time stage_area stage_drag stage_dm stage