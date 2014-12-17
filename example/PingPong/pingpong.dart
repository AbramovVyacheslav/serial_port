// Copyright (c) 2014, Nicolas François
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:serial_port/serial_port.dart';
import 'dart:async';


var arduino;

main(){
  var buffer = new StringBuffer();
  arduino = new SerialPort("/dev/tty.usbmodem1421");
  arduino.onRead.map(BYTES_TO_STRING).listen((word){
    buffer.write(word);
    if(buffer.toString().startsWith("pong")){
      print(buffer.toString());
      buffer.clear();
      sendPing();
    }
  });
  arduino.open().then((_) {
    print("Ctrl-c to close");
    new Timer(new Duration(seconds: 2), sendPing);

  });
}


void sendPing(){

  print("ping");
  arduino.writeString("ping");
}
