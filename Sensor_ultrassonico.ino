  // ** É necessário importar a biblioteca - caminho: Sketch - Includde Library - ADD.library ZIP - Selecionar o arquivo ZIP **
  // Selecionar o Arduino Uno
  #include "Ultrasonic.h" // importa a biblioteca

  const int PINO_TRIGGER = 12; //define as portas dos pinos - Produz a onda ultrassônica
  const int PINO_ECHO = 13; // - Captura a volta da onda ultrassônica

  HC_SR04 sensor(PINO_TRIGGER, PINO_ECHO); //função do sensor

  void setup(){
    Serial.begin(9600); // Inicia a comunicação serial a 9600 bauds (medida de velocidade de sinalização)
  }
    // Serial.print("Distância: "); // saída = "Distância: "
  void loop(){
    Serial.print("TamanhoMáximo:"); // Define a label como Tamanho Máximo
    Serial.print(40); //Define a label "Tamanho Máximo" como 40 cm
    Serial.print(" "); // Pula uma label
    Serial.print("distancia:"); //Define o nome do sensor.distance como distancia
    Serial.print(sensor.distance()); // saída da medida (em cm)
    Serial.print(" ");
    Serial.print("TamanhoMínimo:"); //Define o nome da label como Tamanho Mínimo
    Serial.println(5); // Define a label "Tamanho Mínimo" como 5 cm

    //Serial.println(" cm"); // saída " cm"
    delay(1000); // tempo em milisegundos (1 segundo)
  }