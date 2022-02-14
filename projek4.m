if ~isempty(instrfind)
        fclose(instrfind);
        delete(instrfind);
end

arduino=serial('COM3', 'BAUD', 9600);
fopen(arduino);

error = 0;
error_1 = 0;
sum_error = 0;
Kp = 11;
Ki = 0.08;
Kd = 0;
Sp = 50 ;

while 1
 input = fscanf(arduino, '%s'); %membaca serial pada arduino
 DataInput = strsplit(input, ',');
 DataSp = DataInput{1:1};
 DataSuhu = DataInput{2:2};
 DataKipas = DataInput{3:3};
 setpoint = str2double(DataSp);
 suhu = str2double(DataSuhu);
 kipas = str2double(DataKipas);
 
  error_1 = error ;
  error = DataSuhu - Sp;
  sum_error = sum_error + error;
  P = Kp * error;
  I = Ki * sum_error ;
  D = (Kd / 100) * (error - error_1);
  power = P + I + D;

  if (power > 255)
    power = 255;
  elseif (power < 0)
    power = 0;
  end 
  
  if (DataSuhu <= 28)
    fwrite(arduino,'0');
    fprintf('Sp = %s\n', DataSp);
    fprintf('Suhu = %s\n', DataSuhu);
    fprintf('Fan : %s\n', DataKipas);
    fprintf('Suhu Ruangan Dingin \n\n');
  elseif (DataSuhu >= 29) 
    fwrite(arduino,'1');
    fprintf('Sp = %s\n', DataSp);
    fprintf('Suhu = %s\n', DataSuhu);
    fprintf('Fan : %s\n', DataKipas);
    fprintf('Suhu Ruangan Normal \n\n');
  elseif (DataSuhu >= 30)  
    fwrite(arduino,'2');
    fprintf('Sp = %s\n', DataSp);
    fprintf('Suhu = %s\n', DataSuhu);
    fprintf('Fan : %s\n', DataKipas);
    fprintf('Suhu Ruangan Panas \n\n');
  end

end
fclose(arduino);