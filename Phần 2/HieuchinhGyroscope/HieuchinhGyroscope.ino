#include <Wire.h>


float gyro_offset_x = 0;
float gyro_offset_y = 0;
float gyro_offset_z = 0;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  Serial.println("Bat dau hieu chuan Gyro (De yen mach trong 5 giay)...");
  
  long sum_gx = 0, sum_gy = 0, sum_gz = 0;
  for (int i = 0; i < 500; i++) {
    Wire.beginTransmission(0x68);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 6, true);
    
    int16_t gx_raw = Wire.read() << 8 | Wire.read();
    int16_t gy_raw = Wire.read() << 8 | Wire.read();
    int16_t gz_raw = Wire.read() << 8 | Wire.read();
    
    sum_gx += gx_raw;
    sum_gy += gy_raw;
    sum_gz += gz_raw;
    
    delay(10);
  }
  gyro_offset_x = (sum_gx / 500.0) / 131.0;
  gyro_offset_y = (sum_gy / 500.0) / 131.0;
  gyro_offset_z = (sum_gz / 500.0) / 131.0;

  Serial.println("Hieu chuan xong");
  Serial.print("Offset X: "); Serial.println(gyro_offset_x);
  Serial.print("Offset Y: "); Serial.println(gyro_offset_y);
  Serial.print("Offset Z: "); Serial.println(gyro_offset_z);
  delay(2000);
}

void loop() {
  Wire.beginTransmission(0x68);
  Wire.write(0x43);
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, 6, true);

  int16_t gx_raw = Wire.read() << 8 | Wire.read();
  int16_t gy_raw = Wire.read() << 8 | Wire.read();
  int16_t gz_raw = Wire.read() << 8 | Wire.read();
  float gx = (gx_raw / 131.0) - gyro_offset_x;
  float gy = (gy_raw / 131.0) - gyro_offset_y;
  float gz = (gz_raw / 131.0) - gyro_offset_z;
  Serial.print(gx); Serial.print(",");
  Serial.print(gy); Serial.print(",");
  Serial.println(gz);

  delay(20);
}