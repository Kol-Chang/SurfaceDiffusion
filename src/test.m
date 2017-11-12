% before running a test, gather necessary information about this test
% so that the result can be recovered easily

% time of excution
	Time_Now = datetime('now');
	FormatOut = 'yy_mm_dd_HH_MM_SS_';
	Time_Begin = datestr(Time_Now,FormatOut);

% system info
	if ismac
		PlatForm = 'Mac_';
	elseif isunix
		PlatForm = 'unix_';
	elseif ispc
		PlatForm = 'Windows_';
	else
		PlatForm = 'unknown_';
	end

% make a directory tagged with time of excution outsider src folder
	% path of this folder. we randomized the last 3 digits to avoid name clashes
	Result_Folder = fullfile('..','exc',[PlatForm Time_Begin num2str(floor(rand()*1000))]); 
	if ~exist(fullfile('..','exc')) % if ../exc does not exist
		mkdir(fullfile('..','exc')) % make this folder
	end
	while exist(Result_Folder) % if this folder name alread exists -- which will probably never happen
		Result_Folder = fullfile('..','exc',[PlatForm Time_Begin num2str(floor(rand()*1000))]); % rename it
	end
	mkdir(Result_Folder) % make a folder
	
% now copy the src code the Result_Folder
	Current_src = fullfile(Result_Folder,'src'); % folder to hold current src files
	mkdir(Current_src)
	copyfile(fullfile('..','src'),Current_src);

% now open a text file and write to it comments and testing info
	Test_info = fopen(fullfile(Result_Folder,'test_info'), 'w');
	fprintf(Test_info, 'test start time : \t');
	fprintf(Test_info, [datestr(Time_Now, 'yy/mm/dd HH:MM:SS'),'\n']);
	fprintf(Test_info, 'some comments \n');
	fprintf(Test_info, 'some comments \n');
	fprintf(Test_info, 'some comments \n');
	fprintf(Test_info, 'some comments \n');
	fclose(Test_info);

