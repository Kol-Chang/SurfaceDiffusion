% before running a test, gather necessary information about this test
% so that the result can be recovered easily

% time of excution
	FormatOut = 'yy_mm_dd_HH_MM_SS';
	Time_Begin = datestr(datetime('now'),FormatOut);

% make a directory tagged with time of excution
	

% system info
	if ismac
		PlatForm = 'Mac';
	elseif isunix
		PlatForm = 'unix';
	elseif ispc
		PlatForm = 'Windows';
	else
		PlatForm = 'unknown';
	end



% 


		
		

DATE = datetime('now')
tic;

diary on

D = 0.5;
Alpha = 2;

[x, y, z] = meshgrid(linspace(-pi-D,pi+D,64)/Alpha);

C1 = pi/(2*Alpha); 
C2 = 0.90 * C1/2;

F1 = sqrt(x.^2+y.^2) - (C1-C2*(cos(Alpha * z)+1));
F2 = max(z-pi/Alpha,-z-pi/Alpha);
F = max(F1, F2);

map = SD.SDF3(x,y,z,F)
map.reinitialization(F)

Dt = 0.5 * map.GD3.Dx ^ 4;

loops = 1000;
mov(loops) = struct('cdata',[],'colormap',[]);
%snap{1000} = [];

figure(gcf)

for ii = 1:loops-1
	disp(ii);
	A = map.LCF * Dt /2;
	B = map.GD3.Idt + A;
	C = map.GD3.Idt - A;

	F_old = map.F;
	S = C * F_old(:) + Dt * map.NCF(:);
	%F_new = bicg(B, S);
	F_new = bicgstab(B, S, [], 50);
	%F_new = pcg(B, S);
	%map.F = reshape(F_new, map.GD3.Size);
	map.reinitialization( reshape(F_new, map.GD3.Size) );

	clf;
	map.plotSurface(0,1,'g')
	title(num2str(ii*Dt))
	%map.plot
	drawnow
	mov(ii) = getframe(gcf)

	%snap{ii} = map.F;

	%if (mod(ii,10)==0)
	%	save('snap.mat','snap')
	%end

	datetime('now')

end

save('pinch64mac.mat','mov','DATE')

Elapse = toc;

save('time.mat','Elapse')

diary off
