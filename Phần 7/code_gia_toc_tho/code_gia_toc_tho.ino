#include <Wire.h>
int16_t offset_ax = -653; 
int16_t offset_ay = 464;
int16_t offset_az = -682;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  Wire.beginTransmission(0x68);
  Wire.write(0x6B);
  Wire.write(0x00);
  Wire.endTransmission(true);
  
  for(int i = 0; i < 500; i++){
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
    Serial.print(ax, 3); Serial.print(",");
    Serial.print(ay, 3); Serial.print(",");
    Serial.println(az, 3);
  }
  delay(50);
}

void loop() {

}