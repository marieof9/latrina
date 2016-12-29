#include <WiFi.h>

// WiFi network name and password:
const char * networkName = "<SSID>";
const char * networkPswd = "<PASSWORD>";

// Internet domain to request from:
const char * hostDomain = "latrina.com";
const int hostPort = 80;
const char * sensorName = "<LOCKANME>";

// Pin setup
const int DEBUG_PIN = 2;
const int BUTTON_PIN = 0;
const int LED_PIN = 5;
int debug = 0;

void setup() {
  // Setup Debug Switch
  pinMode(DEBUG_PIN, INPUT_PULLUP);
  pinMode(LED_PIN, OUTPUT);
  if (digitalRead(DEBUG_PIN) == LOW) {
    debug = 1;
    
    Serial.begin(115200);
    Serial.println("LatrinaSensor");
  }
  
  // Setup Button
  pinMode(BUTTON_PIN, INPUT_PULLUP);
}

void loop() {

  if (debug == 1) {
    Serial.println("LatrinaSensor");
  }

  connectToWiFi(networkName, networkPswd);
  

  if (digitalRead(BUTTON_PIN) == LOW) {
    sendState("LOCK");
  } else {
    sendState("UNLOCK");
  }

  esp_deep_sleep(600000000);
}

void connectToWiFi(const char * ssid, const char * pwd) {
  if (debug == 1) {
    Serial.println("Connecting to WiFi network: " + String(ssid));
  }

  WiFi.begin(ssid, pwd);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    if (debug == 1) {
      Serial.print(".");
    }
  }

  if (debug == 1) {
    Serial.println();
    Serial.println("WiFi connected!");
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
  }
}

void sendState(const char * methode) {
  if (debug == 1) {
    Serial.println("Connecting to: " + String(hostDomain));
  }

  // Use WiFiClient class to create TCP connections
  WiFiClient client;
  if (!client.connect(hostDomain, hostPort)) {
    if (debug == 1) {
      Serial.println("connection failed");
    }
    return;
  }

  // This will send the request to the server
  client.print((String)"" + String(methode) + " /" + String(sensorName) + " HTTP/1.1\r\n" +
               "Host: " + String(hostDomain) + "\r\n" +
               "Connection: close\r\n\r\n");
  unsigned long timeout = millis();
  while (client.available() == 0) {
    if (millis() - timeout > 5000) {
      if (debug == 1) {
        Serial.println(">>> Client Timeout !");
      }
      client.stop();
      return;
    }
  }

  // Read all the lines of the reply from server and print them to Serial
  while (client.available()) {
    String line = client.readStringUntil('\r');
    if (debug == 1) {
      Serial.print(line);
    }
  }

  if (debug == 1) {
    Serial.println();
    Serial.println("closing connection");
  }
  client.stop();
}
