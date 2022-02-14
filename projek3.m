if ~isempty(instrfind)
        fclose(instrfind);
        delete(instrfind);
end

arduino=serial('COM3', 'BAUD', 9600);
fopen(arduino);

while 1
 input = fscanf(arduino, '%s'); %membaca serial pada arduino
 DataInput = strsplit(input,',');
 Data1 = DataInput{1:1};
 Data2 = DataInput{2:2};

 fprintf('Suhu : %s\n',Data1);
 fprintf('Fan : %s\n',Data2);

end
fclose(arduino);