if ~isempty(instrfind)
        fclose(instrfind);
        delete(instrfind);
end

arduino=serial('COM3','BAUD', 9600);
fopen(arduino);
while 1
 voltage = fscanf(arduino, '%s');
 fprintf('tegangan dari Potensio = %s',voltage);
 voltage = str2double(voltage);
 if(voltage<3.0)
 fwrite(arduino, '0');
 fprintf('\n');
 elseif(voltage>=3.0)
 fwrite(arduino, '1');
 fprintf('\n');
 end
end
fclose(arduino);