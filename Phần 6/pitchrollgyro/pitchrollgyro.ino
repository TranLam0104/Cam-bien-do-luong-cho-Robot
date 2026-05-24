#include <Wire.h>

float gyro_offset_x = 0;
float gyro_offset_y = 0;
float gyro_offset_z = 0;

float roll_gyro = 0;
float pitch_gyro = 0;
float yaw_gyro = 0;

unsigned long prev_time;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  long sum_gx = 0, sum_gy = 0, sum_gz = 0;
  for (int i = 0; i < 500; i++) {
    Wire.beginTransmission(0x68);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 6, true);
    sum_gx += Wire.read() << 8 | Wire.read();
    sum_gy += Wire.read() << 8 | Wire.read();
    sum_gz += Wire.read() << 8 | Wire.read();
    delay(10);
  }
  gyro_offset_x = (sum_gx / 500.0) / 131.0;
  gyro_offset_y = (sum_gy / 500.0) / 131.0;
  gyro_offset_z = (sum_gz / 500.0) / 131.0;

  prev_time = millis();
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

  unsigned long curr_time = millis();
  float dt = (curr_time - prev_time) / 1000.0;
  prev_time = curr_time;

  roll_gyro += gx * dt;
  pitch_gyro += gy * dt;
  yaw_gyro += gz * dt;

  Serial.print(roll_gyro); Serial.print(",");
  Serial.print(pitch_gyro); Serial.print(",");
  Serial.println(yaw_gyro);

  delay(20);
}