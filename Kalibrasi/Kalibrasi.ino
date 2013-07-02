int Red = A2;
int Green = A0;
int Blue = A4;
int resultRead, resultRed, resultGreen, resultBlue;

void setup(){
  Serial.begin(9600);
  Serial.println(" R  G  B  ");
  Serial.println("----------");
  
}
void loop(){
  
  resultRead = analogRead(Red);
  resultRed = map(resultRead,0,1023,0,255);
  Serial.print(resultRed);
  
  resultRead = analogRead(Green);
  resultGreen = map(resultRead,0,1023,0,255);
  Serial.print(" ");
  Serial.print(resultGreen);
  
  resultRead = analogRead(Blue);
  resultBlue = map(resultRead,0,1023,0,255);
  Serial.print(" ");
  Serial.println(resultBlue);
  delay(200);
}
