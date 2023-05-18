function [y1, x1] = newcoord(AP0,ML0,azim)

%% inputs
% input the AP and ML values for the insertion point and the angle at which
% the manipulator is rotated (by alpha) compared to the orthogonal axis
% lambda-bregma.

% alpha is the angle calc from the ML line (0-360) on bregma, with zero
% being on its R side and 180 being on its L side. 
% positive ML values are on the R hemishpere, positive AP values are in
% front of bregma.

%% outputs
% considering bregma at [0,0], x1 and y1 are the distance on the rotated
% axis the manipualtor has to travel to reach the input [ML, AP] coordinates



% convert azimuth to alpha. -135 azimuth would correspond to alpha = 225,
% 110 azimuth > alpha = 340, etc. 

if azim <= 90 && azim > 0
    alpha = (abs(azim - 90))*(pi/180);
elseif azim <= 0 && azim > -180
    alpha = (abs(azim) + 90)*(pi/180);
elseif azim >90 && azim <= 180
    alpha = (360-(azim-90))*(pi/180);
end

% find hypotenuse
hyp0 = sqrt((AP0^2+ML0^2));

% find angle opposite to AP0
a0 = abs(atan(AP0/ML0));

% find angle for the new triangle, opposite to AP1
if AP0*ML0 <0          % if the location is in 90-180 and its opposite quadrant
    if abs(AP0) <abs(ML0) % and if the angle of the hyp is >45 deg...
        a1 = a0 - (pi-alpha);
    elseif abs(AP0) >abs(ML0)
        a1 = a0 + (pi-alpha);
    end
elseif AP0*ML0 >=0
    if abs(AP0) <abs(ML0)
        a1 = a0 + (pi-alpha);
    elseif abs(AP0) >abs(ML0)
        a1 = a0 - (pi-alpha);
    end
end

% coordinates of the new axis at 
x1 = sign(ML0)*abs(cos(a1)*hyp0);
y1 = sign(AP0)*abs(sin(a1)*hyp0);


end
