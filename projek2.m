if ~isempty(instrfind)
        fclose(instrfind);
        delete(instrfind);
end

clear
pil='e'
arduino=serial('COM3', 'BAUD', 9600);
fopen(arduino);
while 1
 input = fscanf(arduino, '%s'); %membaca serial pada arduino
 DataInput = strsplit(input,',');
 Data1 = DataInput{1:1};
 Data2 = DataInput{2:2};
 Data3 = DataInput{3:3};
 Data4 = DataInput{4:4};
 Data5 = DataInput{5:5};
 if(pil=='a')
 fprintf('Data1 : %s\n',Data1);
 elseif(pil=='b')
 fprintf('Data2 : %s\n',Data2);
 elseif(pil=='c')
 fprintf('Data3 : %s\n',Data3);
 elseif(pil=='d')
 fprintf('Data4 : %s\n',Data4);
 elseif(pil=='e')
 fprintf('Data5 : %s\n',Data5);
 end
end
fclose(arduino);
