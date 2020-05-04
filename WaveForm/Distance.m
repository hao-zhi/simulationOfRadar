% Calcualting the distance of two vehicles


function [d] = Distance(a,b)
	d = sqrt((a.x-b.x).^2 + (a.y-b.y).^2 + 100^2);
end