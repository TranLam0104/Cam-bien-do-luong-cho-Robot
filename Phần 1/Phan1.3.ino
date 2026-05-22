#include <Wire.h>

int16_t offset_ax = 0;
int16_t offset_ay = 0;
int16_t offset_az = 0;
int16_t offset_gx = 0;
int16_t offset_gy = 0;
int16_t offset_gz = 0;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);
}

void loop() {
  Wire.beginTransmission(0x68);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(0x68, 14, true);

  int16_t ax = (Wire.read() << 8 | Wire.read()) - offset_ax;
  int16_t ay = (Wire.read() << 8 | Wire.read()) - offset_ay;
  int16_t az = (Wire.read() << 8 | Wire.read()) - offset_az;
  int16_t temp = Wire.read() << 8 | Wire.read();
  int16_t gx = (Wire.read() << 8 | Wire.read()) - offset_gx;
  int16_t gy = (Wire.read() << 8 | Wire.read()) - offset_gy;
  int16_t gz = (Wire.read() << 8 | Wire.read()) - offset_gz;

  Serial.print(ax); Serial.print(",");
  Serial.print(ay); Serial.print(",");
  Serial.print(az); Serial.print(",");
  Serial.print(gx); Serial.print(",");
  Serial.print(gy); Serial.print(",");
  Serial.println(gz);

  delay(20);
}