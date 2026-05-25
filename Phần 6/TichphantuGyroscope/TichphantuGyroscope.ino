#include <Wire.h>
#include <math.h>

int16_t offset_ax = -596;
int16_t offset_ay = 163;
int16_t offset_az = 1065;

float gyro_offset_x = 0, gyro_offset_y = 0;

float roll_gyro  = 0;
float pitch_gyro = 0;

unsigned long prev_time;

void setup() {
  Serial.begin(115200);
  Wire.begin();

  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  long sum_gx = 0, sum_gy = 0;
  for (int i = 0; i < 500; i++) {
    Wire.beginTransmission(0x68);
    Wire.write(0x43);
    Wire.endTransmission(false);
    Wire.requestFrom(0x68, 4, true);
    sum_gx += (int16_t)(Wire.read() << 8 | Wire.read());
    sum_gy += (int16_t)(Wire.read() << 8 | Wire.read());
    delay(5);
  }
  gyro_offset_x = (sum_gx / 500.0) / 131.0;
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

  Wire.read(); Wire.read();

  float gx = ((int16_t)(Wire.read() << 8 | Wire.read()) / 131.0) - gyro_offset_x;
  float gy = ((int16_t)(Wire.read() << 8 | Wire.read()) / 131.0) - gyro_offset_y;

  float ax = ax_raw / 16384.0;
  float ay = ay_raw / 16384.0;
  float az = az_raw / 16384.0;

  unsigned long curr_time = millis();
  float dt = (curr_time - prev_time) / 1000.0;
  prev_time = curr_time;

  roll_gyro  += gx * dt;
  pitch_gyro += gy * dt;

  float roll_acc  = -atan2(ay, az) * 180.0 / PI;
  float pitch_acc = -atan2(-ax, sqrt(ay*ay + az*az)) * 180.0 / PI;

  Serial.print(roll_gyro,  3); Serial.print(",");
  Serial.print(pitch_gyro, 3); Serial.print(",");
  Serial.print(roll_acc,   3); Serial.print(",");
  Serial.println(pitch_acc, 3);

  delay(20);
}