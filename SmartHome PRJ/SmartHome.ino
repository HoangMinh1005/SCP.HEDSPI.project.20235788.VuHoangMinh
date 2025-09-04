#include <SoftwareSerial.h>
#include <Servo.h>

SoftwareSerial mybluetooth(3, 4);
const int trig = 6;
const int echo = 5;

const int ledIntruder = 11;  
const int ledTest = 12;      
const int ledWater = 9;      

const int waterSensor = 7;   
const int relayPin = 10;     

Servo myservo;
int servoPin = 8;

String data = "";
unsigned long thoigian;
int khoangcach;

bool intruderMode = false; 

void setup() {
  myservo.attach(servoPin);
  pinMode(ledIntruder, OUTPUT);
  pinMode(ledTest, OUTPUT);
  pinMode(ledWater, OUTPUT);
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(waterSensor, INPUT);
  pinMode(relayPin, OUTPUT);

  digitalWrite(relayPin, LOW); 

  Serial.begin(9600);
  mybluetooth.begin(9600);

  myservo.write(90); 
  Serial.println("System ready: Bluetooth + LED + Servo + Ultrasonic + Water Sensor");
}

void loop() {
  // Nhận chuỗi từ Bluetooth
  if (mybluetooth.available()) {
    data = mybluetooth.readString();  
    data.trim();  
    data.toUpperCase(); 
    Serial.print("Nhan duoc tu Bluetooth: ");
    Serial.println(data);
  }

  // Nhận chuỗi từ Serial Monitor
  if (Serial.available()) {
    data = Serial.readString();
    data.trim();
    data.toUpperCase();
    mybluetooth.println(data);
    Serial.print("Gui sang Bluetooth: ");
    Serial.println(data);
  }

  // Xử lý lệnh
  if (data == "ON1") {
    digitalWrite(ledTest, HIGH);
    Serial.println("LED TEST BAT");
  } 
  else if (data == "OFF1") {
    digitalWrite(ledTest, LOW);
    Serial.println("LED TEST TAT");
  }
  else if (data == "ON2") {
    myservo.write(0);
    Serial.println("CUA DA MO");
  } 
  else if (data == "OFF2") {
    myservo.write(90);
    Serial.println("CUA DA DONG");
  }
  else if (data == "ON3") {
    intruderMode = true; 
    Serial.println("CHONG DOT NHAP BAT");
  } 
  else if (data == "OFF3") {
    intruderMode = false; 
    digitalWrite(ledIntruder, LOW);
    Serial.println("CHONG DOT NHAP TAT");
  }

  // Nếu bật chống đột nhập thì đo khoảng cách
  if (intruderMode) {
    int kc = dokhoangcach();
    Serial.print("Khoang cach: ");
    Serial.print(kc);
    Serial.println(" cm");

    if (kc > 0 && kc < 20) { 
      digitalWrite(ledIntruder, HIGH);
      delay(200);
      digitalWrite(ledIntruder, LOW);
      delay(200);
      mybluetooth.println("INTRUDER DETECTED!");
    } else {
      digitalWrite(ledIntruder, LOW); 
    }
  }

  // Kiểm tra rò rỉ nước
  int waterState = digitalRead(waterSensor);
  if (waterState == HIGH) { 
    digitalWrite(relayPin, HIGH);  
    digitalWrite(ledWater, HIGH);  
    Serial.println("WATER LEAK DETECTED - Pump ON!");
    mybluetooth.println("WATER LEAK DETECTED!");
  } else { // khô
    digitalWrite(relayPin, LOW);  
    digitalWrite(ledWater, LOW);  
  }

  data = ""; // reset
}

int dokhoangcach() {
  digitalWrite(trig, LOW);
  delayMicroseconds(2);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);

  thoigian = pulseIn(echo, HIGH, 30000); 
  if (thoigian == 0) return -1; 
  khoangcach = thoigian / 2 / 29.412;
  return khoangcach;
}
