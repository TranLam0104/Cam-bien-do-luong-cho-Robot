#include <Wire.h>
#include <math.h>

int16_t offset_ax = 573;
int16_t offset_ay = -82;
int16_t offset_az = -1065;
float gyro_offset_y = 0;

float pitch_gyro = 0;
unsigned long prev_time;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  long sum_gy = 0;
  for (int i = 0; i < 500; i++) {
    Wire.beginTransmission(0x68);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 6, true);
    Wire.read(); Wire.read(); 
    sum_gy += Wire.read() << 8 | Wire.read();
    Wire.read(); Wire.read(); 
    delay(10);
  }
  gyro_offset_y = (sum_gy / 500.0) / 131.0;
  prev_time = millis();
}

void loop() {
  Wire.beginTransmission(0x68);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, 14, true);

  int16_t ax_raw = (Wire.read() << 8 | Wire.read()) - offset_ax;
  int16_t ay_raw = (Wire.read() << 8 | Wire.read()) - offset_ay;
  int16_t az_raw = (Wire.read() << 8 | Wire.read()) - offset_az;

  Wire.read(); Wire.read(); S

  int16_t gx_raw = Wire.read() << 8 | Wire.read(); 
  int16_t gy_raw = Wire.read() << 8 | Wire.read(); 

  float ax = ax_raw / 16384.0;
  float ay = ay_raw / 16384.0;
  float az = az_raw / 16384.0;

  float gy = (gy_raw / 131.0) - gyro_offset_y;

  float pitch_acc = atan(ax / sqrt(ay * ay + az * az)) * 180.0 / PI;

  unsigned long curr_time = millis();
  float dt = (curr_time - prev_time) / 1000.0;
  prev_time = curr_time;

  pitch_gyro += gy * dt;

  Serial.print(pitch_acc);
  Serial.print(",");
  Serial.println(pitch_gyro);

  delay(20);
}