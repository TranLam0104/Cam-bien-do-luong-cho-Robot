#include <Wire.h>
#include <math.h>

int16_t offset_ax = -596;
int16_t offset_ay = 163;
int16_t offset_az = 1065;

void setup() {
  Serial.begin(115200);
  Wire.begin();

  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);

  // KHONG in header
  delay(100);
}

void loop() {
  Wire.beginTransmission(0x68);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, 6, true);

  int16_t ax_raw = (Wire.read() << 8 | Wire.read()) - offset_ax;
  int16_t ay_raw = (Wire.read() << 8 | Wire.read()) - offset_ay;
  int16_t az_raw = (Wire.read() << 8 | Wire.read()) - offset_az;

  float ax = ax_raw / 16384.0;
  float ay = ay_raw / 16384.0;
  float az = az_raw / 16384.0;

  float roll_acc  = -atan2(ay, az) * 180.0 / PI;
  float pitch_acc = -atan2(-ax, sqrt(ay*ay + az*az)) * 180.0 / PI;

  Serial.print(roll_acc,  3); Serial.print(",");
  Serial.println(pitch_acc, 3);

  delay(20);
}