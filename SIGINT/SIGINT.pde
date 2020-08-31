import android.os.Bundle;

import android.content.Context;

import android.app.Activity;

import android.content.Context;

import android.os.Vibrator;

import java.util.UUID; 

import java.nio.ByteBuffer;

import java.nio.ByteOrder;

import blepdroid.*;

import blepdroid.BlepdroidDevice;


public static final UUID BLUEFRUIT_LE_UUID_BASE = UUID.fromString("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");

public static final UUID BLUEFRUIT_LE_UUID_TX =   UUID.fromString("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");

public static final UUID BLUEFRUIT_LE_UUID_RX =   UUID.fromString("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");

public static final String BLUEFRUIT_LE_ADDRESS = "DD:D0:30:46:0E:AD";


public static final byte SCREEN_CONN =   0x00;

public static final byte SCREEN_INSTR =  0x01;

public static final byte SCREEN_MOV =    0x02;

public static final byte SCREEN_ROT =    0x03;

public static final byte SCREEN_BEEP =   0x04;

public static final byte SCREEN_GOTOXY = 0x05;

public static final byte SCREEN_ORIENT = 0x06;


public static final int BLE_BUFF_SIZE = 32;

public static final byte BLE_END_MSG =      0x0F;

public static final byte BLE_INSTR_MOV =    0x21;

public static final byte BLE_INSTR_ROT =    0x22;

public static final byte BLE_INSTR_BEEP =   0x23;

public static final byte BLE_INSTR_GOTOXY = 0x24;

public static final byte BLE_INSTR_ORIENT = 0x25;

public static final byte BLE_INSTR_SCAN =   0x31;

public static final byte BLE_INSTR_IDENT =  0x32;

public static final byte BLE_INSTR_PATR =   0x33;

public static final byte BLE_INSTR_CLEAR =  0x34;

public static final byte BLE_INSTR_STOP =   0x2F;


Activity act;

Vibrator vib;

Blepdroid blep;

BlepdroidDevice ble;


byte screen;

boolean is_conn;


TASMANTIS_Button conn_btn,

                 mov_btn,
                 
                 rot_btn,

                 beep_btn,
                 
                 gotoxy_btn,
                 
                 orient_btn,
                 
                 scan_btn,
                 
                 ident_btn,
                 
                 patr_btn,
                 
                 clear_btn,
                 
                 stop_btn,
                 
                 submit_btn,
                 
                 back_btn;
                 
TASMANTIS_Label mov_label,

                rot_label,
                
                beep_label,
                
                gotox_label,
                
                gotoy_label,
                
                orient_label;

TASMANTIS_TextField mov_txtfield,

                    rot_txtfield,
                    
                    beep_txtfield,
                    
                    gotox_txtfield,
                    
                    gotoy_txtfield,
                    
                    orient_txtfield;

TASMANTIS_NumberPad mov_numpad,

                    rot_numpad,
                    
                    beep_numpad,
                    
                    gotox_numpad,
                    
                    gotoy_numpad,
                    
                    orient_numpad;

TASMANTIS_ToggleSwitch mov_toggle,

                       rot_toggle;
                       
TASMANTIS_WidgetCollection instr_collect,

                           mov_collect,

                           rot_collect,
                           
                           beep_collect,
                           
                           gotoxy_collect,
                           
                           orient_collect;


void setup() { /* ----------
* This FUNCTION ...
* ---------- */
  
    size(1080, 1620);
  
    smooth();
  
  
    /* CONNECT SCREEN */
    
    conn_btn = new TASMANTIS_Button((0 + ((1080 - 300) / 2)),
                                    (0 + ((1620 - 100) / 2)),
                                    300, 100,
                                    "CONNECT");
    
    /* INSTRUCTION SCREEN */
        
    mov_btn = new TASMANTIS_Button((0 + 5),
                                   (0 + 5),
                                    300, 100,
                                    "MOVE");
    
    rot_btn = new TASMANTIS_Button(mov_btn.getX(),
                                   (mov_btn.getY() + mov_btn.getHeight() + 5),
                                   300, 100,
                                   "ROTATE");
                                   
    beep_btn = new TASMANTIS_Button(rot_btn.getX(),
                                    (rot_btn.getY() + rot_btn.getHeight() + 5),
                                    300, 100,
                                    "BEEP");
                                   
    gotoxy_btn = new TASMANTIS_Button(beep_btn.getX(),
                                      (beep_btn.getY() + beep_btn.getHeight() + 5),
                                      300, 100,
                                      "GOTO XY");
                                  
    orient_btn = new TASMANTIS_Button(gotoxy_btn.getX(),
                                      (gotoxy_btn.getY() + gotoxy_btn.getHeight() + 5),
                                      300, 100,
                                      "ORIENTATE");
                                        
    stop_btn = new TASMANTIS_Button(orient_btn.getX(),
                                   (orient_btn.getY() + orient_btn.getHeight() + 5),
                                   300, 100,
                                   "STOP");
                                                    
    scan_btn = new TASMANTIS_Button((mov_btn.getX() + mov_btn.getWidth() + 5),
                                    mov_btn.getY(),
                                    300, 100,
                                    "SCAN");
                                    
    ident_btn = new TASMANTIS_Button(scan_btn.getX(),
                                     (scan_btn.getY() + scan_btn.getHeight() + 5),
                                     300, 100,
                                     "IDENTIFY"); 

    patr_btn = new TASMANTIS_Button(ident_btn.getX(),
                                    (ident_btn.getY() + ident_btn.getHeight() + 5),
                                    300, 100,
                                    "PATROL");
                                    
    clear_btn = new TASMANTIS_Button(patr_btn.getX(),
                                     (patr_btn.getY() + patr_btn.getHeight() + 5),
                                     300, 100,
                                     "CLEAR");
                                    
    
    instr_collect = new TASMANTIS_WidgetCollection();
    
    instr_collect.add(mov_btn);
    
    instr_collect.add(rot_btn);
    
    instr_collect.add(beep_btn);
    
    instr_collect.add(gotoxy_btn);
    
    instr_collect.add(orient_btn);
    
    instr_collect.add(stop_btn);
    
    instr_collect.add(scan_btn);
    
    instr_collect.add(ident_btn);
    
    instr_collect.add(patr_btn);
    
    instr_collect.add(clear_btn);
    
    instr_collect.setHidden(true);
    
    
    /* MOVE SCREEN */
    
    mov_label = new TASMANTIS_Label(5, 5,
                                    200, 40,
                                    "Distance (cm)");
                                    
    mov_txtfield = new TASMANTIS_TextField(mov_label.getX(),
                                           (mov_label.getY() + mov_label.getHeight() + 5),
                                           200, 75,
                                           6,
                                           "");
    
    mov_numpad = new TASMANTIS_NumberPad(mov_txtfield.getX(),
                                         (mov_txtfield.getY() + mov_txtfield.getHeight() + 5));
    
    mov_toggle = new TASMANTIS_ToggleSwitch(mov_numpad.getX(),
                                            (mov_numpad.getY() + mov_numpad.getHeight() + 5),
                                            new String[] { "BWD", "FWD" });
                                            
    
    mov_collect = new TASMANTIS_WidgetCollection();
    
    mov_collect.add(mov_label);
    
    mov_collect.add(mov_txtfield);
    
    mov_collect.add(mov_numpad);
    
    mov_collect.add(mov_toggle);
    
    mov_collect.setHidden(true);
    
    
    /* ROTATE SCREEN */
    
    rot_label = new TASMANTIS_Label(5, 5,
                                    200, 40,
                                    "Degrees");
                                    
    rot_txtfield = new TASMANTIS_TextField(rot_label.getX(),
                                           (rot_label.getY() + rot_label.getHeight() + 5),
                                           200, 75,
                                           6,
                                           "");
    
    rot_numpad = new TASMANTIS_NumberPad(rot_txtfield.getX(),
                                         (rot_txtfield.getY() + rot_txtfield.getHeight() + 5));
    
    rot_toggle = new TASMANTIS_ToggleSwitch(rot_numpad.getX(),
                                            (rot_numpad.getY() + rot_numpad.getHeight() + 5),
                                            new String[] { "CW", "CCW" });

        
    rot_collect = new TASMANTIS_WidgetCollection();
    
    rot_collect.add(rot_label);
    
    rot_collect.add(rot_txtfield);
    
    rot_collect.add(rot_numpad);
    
    rot_collect.add(rot_toggle);
    
    rot_collect.setHidden(true);

    
    /* BEEP SCREEN */
    
    beep_label = new TASMANTIS_Label(5, 5,
                                     200, 40,
                                     "Beeps");
                                    
    beep_txtfield = new TASMANTIS_TextField(beep_label.getX(),
                                            (beep_label.getY() + beep_label.getHeight() + 5),
                                            200, 75,
                                            6,
                                            "");
    
    beep_numpad = new TASMANTIS_NumberPad(beep_txtfield.getX(),
                                          (beep_txtfield.getY() + beep_txtfield.getHeight() + 5));


    beep_collect = new TASMANTIS_WidgetCollection();
    
    beep_collect.add(beep_label);
    
    beep_collect.add(beep_txtfield);
    
    beep_collect.add(beep_numpad);
    
    beep_collect.setHidden(true);


    /* GOTOXY SCREEN */
    
    gotox_label = new TASMANTIS_Label(5, 5,
                                      200, 40,
                                      "X-Coordinate (cm)");
                                    
    gotox_txtfield = new TASMANTIS_TextField(gotox_label.getX(),
                                             (gotox_label.getY() + gotox_label.getHeight() + 5),
                                             200, 75,
                                             6,
                                             "");
    
    gotox_numpad = new TASMANTIS_NumberPad(gotox_txtfield.getX(),
                                           (gotox_txtfield.getY() + gotox_txtfield.getHeight() + 5));
                                           
    gotoy_label = new TASMANTIS_Label((gotox_numpad.getX() + gotox_numpad.getWidth() + 5),
                                      gotox_label.getY(),
                                      200, 40,
                                      "Y-Coordinate (cm)");
                                    
    gotoy_txtfield = new TASMANTIS_TextField(gotoy_label.getX(),
                                             (gotoy_label.getY() + gotoy_label.getHeight() + 5),
                                             200, 75,
                                             6,
                                             "");
    
    gotoy_numpad = new TASMANTIS_NumberPad(gotoy_txtfield.getX(),
                                           (gotoy_txtfield.getY() + gotoy_txtfield.getHeight() + 5));


    gotoxy_collect = new TASMANTIS_WidgetCollection();
    
    gotoxy_collect.add(gotox_label);
    
    gotoxy_collect.add(gotox_txtfield);
    
    gotoxy_collect.add(gotox_numpad);

    gotoxy_collect.add(gotoy_label);
    
    gotoxy_collect.add(gotoy_txtfield);
    
    gotoxy_collect.add(gotoy_numpad);
    
    gotoxy_collect.setHidden(true);


    /* ORIENT SCREEN */
    
    orient_label = new TASMANTIS_Label(5, 5,
                                       200, 40,
                                       "Orientation");
                                    
    orient_txtfield = new TASMANTIS_TextField(orient_label.getX(),
                                              (orient_label.getY() + orient_label.getHeight() + 5),
                                              200, 75,
                                              6,
                                              "");
    
    orient_numpad = new TASMANTIS_NumberPad(orient_txtfield.getX(),
                                            (orient_txtfield.getY() + orient_txtfield.getHeight() + 5));


    orient_collect = new TASMANTIS_WidgetCollection();
    
    orient_collect.add(orient_label);
    
    orient_collect.add(orient_txtfield);
    
    orient_collect.add(orient_numpad);
    
    orient_collect.setHidden(true);
    
    
    /* (MOVE + ROTATE + BEEP + GOTOXY + ORIENT) SCREENS */
    
    submit_btn = new TASMANTIS_Button((0 + (1080 - 200)),
                                      5,
                                      200, 75,
                                      "SUBMIT");
                                      
    submit_btn.setHidden(true);
    
    back_btn = new TASMANTIS_Button(submit_btn.getX(),
                                    (submit_btn.getY() + submit_btn.getHeight() + 5),
                                    200, 75,
                                    "BACK");
   
    back_btn.setHidden(true);
    
    
    act = this.getActivity();
    
    vib = (Vibrator)act.getSystemService(Context.VIBRATOR_SERVICE);
    
    blep = new Blepdroid(this);
    
    
    is_conn = false;
    
    screen = SCREEN_CONN;
}


void mousePressed() { /* ----------
* This FUNCTION ...
* ---------- */

    /* CONNECT SCREEN */
    
    if (conn_btn.isPressed(mouseX, mouseY)) {
    
        blep.scanDevices();
        
        
        vib.vibrate(100);
    }


    /* INSTRUCTION SCREEN */

    if (mov_btn.isPressed(mouseX, mouseY)) {
    
        screen = SCREEN_MOV;
        
        
        vib.vibrate(100);
    }
    
    if (rot_btn.isPressed(mouseX, mouseY)) {
      
        screen = SCREEN_ROT;
        
        
        vib.vibrate(100);
    }
    
    
    if (beep_btn.isPressed(mouseX, mouseY)) {
    
        screen = SCREEN_BEEP;
        
        
        vib.vibrate(100);
    }
    
    if (gotoxy_btn.isPressed(mouseX, mouseY)) {
      
        screen = SCREEN_GOTOXY;
        
        
        vib.vibrate(100);
    }
    
    
    if (orient_btn.isPressed(mouseX, mouseY)) {
    
        screen = SCREEN_ORIENT;
        
        
        vib.vibrate(100);
    }
    

    if (stop_btn.isPressed(mouseX, mouseY)) {

        sendStop();
        
      
        vib.vibrate(100);
    }
    
    
    if (scan_btn.isPressed(mouseX, mouseY)) {
     
        sendScan();
        
        
        vib.vibrate(100);
    }


    if (ident_btn.isPressed(mouseX, mouseY)) {
     
        sendIdentify();
        
        
        vib.vibrate(100);
    }


    if (patr_btn.isPressed(mouseX, mouseY)) {
     
        sendPatrol();
        
        
        vib.vibrate(100);
    }
    
    
    if (clear_btn.isPressed(mouseX, mouseY)) {
     
        sendClear();
        
        
        vib.vibrate(100);
    }


    /* MOVE SCREEN */
    
    if (mov_numpad.isPressed(mouseX, mouseY)) {
     
        mov_txtfield.input(mov_numpad.getPressed());
        
        
        vib.vibrate(100);
    }
    
    if (mov_toggle.isPressed(mouseX, mouseY)) {
      
        vib.vibrate(100);
    }
    
        
    /* ROTATE SCREEN */
    
    if (rot_numpad.isPressed(mouseX, mouseY)) {
     
        rot_txtfield.input(rot_numpad.getPressed());
        
        
        vib.vibrate(100);
    }
    
    if (rot_toggle.isPressed(mouseX, mouseY)) {
      
        vib.vibrate(100);
    }


    /* BEEP SCREEN */
    
    if (beep_numpad.isPressed(mouseX, mouseY)) {
     
        beep_txtfield.input(beep_numpad.getPressed());
        
        
        vib.vibrate(100);
    }


    /* GOTOXY SCREEN */
    
    if (gotox_numpad.isPressed(mouseX, mouseY)) {
     
        gotox_txtfield.input(gotox_numpad.getPressed());
        
        
        vib.vibrate(100);
    }

    if (gotoy_numpad.isPressed(mouseX, mouseY)) {
     
        gotoy_txtfield.input(gotoy_numpad.getPressed());
        
        
        vib.vibrate(100);
    }


    /* ORIENT SCREEN */
    
    if (orient_numpad.isPressed(mouseX, mouseY)) {
     
        orient_txtfield.input(orient_numpad.getPressed());
        
        
        vib.vibrate(100);
    }
    
    
    /* (MOVE + ROTATE + BEEP + GOTOXY + ORIENT) SCREENS */
    
    if (submit_btn.isPressed(mouseX, mouseY)) {
      
        switch (screen) {
          
          case(SCREEN_MOV):
            
            sendMove(mov_txtfield.entry(),
                     mov_toggle.getChoice().equals("FWD"));
            
            break;
            
            
          case(SCREEN_ROT):

            sendRotate(rot_txtfield.entry(),
                       rot_toggle.getChoice().equals("CCW"));
            
            break;
            
            
          case(SCREEN_BEEP):

            sendBeep(beep_txtfield.entry());
            
            break;
            
            
          case(SCREEN_GOTOXY):

            sendGotoXY(gotox_txtfield.entry(),
                       gotoy_txtfield.entry());
            
            break;
            
            
          case(SCREEN_ORIENT):

            sendOrientate(orient_txtfield.entry());
            
            break;
        }
        
        screen = SCREEN_INSTR;
        
        
        vib.vibrate(100);
    }
    
    
    if (back_btn.isPressed(mouseX, mouseY)) {
      
        screen = SCREEN_INSTR;
        
        
        vib.vibrate(100);
    }  
}


void draw() { /* ----------
* This FUNCTION ...
* ---------- */
  
    background(20);
    
    
    switch (screen) {
    
      case (SCREEN_CONN):
      
        conn_btn.setHidden(false);
        
        
        instr_collect.setHidden(true);
        
        mov_collect.setHidden(true);
        
        rot_collect.setHidden(true);
        
        beep_collect.setHidden(true);
        
        gotoxy_collect.setHidden(true);
        
        orient_collect.setHidden(true);
        
        
        submit_btn.setHidden(true);
        
        back_btn.setHidden(true);
        
        
        break;
        
        
      case (SCREEN_INSTR):
        
        conn_btn.setHidden(true);
        
        
        instr_collect.setHidden(false);
        
        mov_collect.setHidden(true);
        
        rot_collect.setHidden(true);
        
        beep_collect.setHidden(true);
        
        gotoxy_collect.setHidden(true);
        
        orient_collect.setHidden(true);
        
        submit_btn.setHidden(true);
        
        back_btn.setHidden(true);
        
        
        break;
        
        
      case (SCREEN_MOV):
      
        conn_btn.setHidden(true);
        
        
        instr_collect.setHidden(true);
        
        mov_collect.setHidden(false);
        
        rot_collect.setHidden(true);
        
        beep_collect.setHidden(true);
        
        gotoxy_collect.setHidden(true);
        
        orient_collect.setHidden(true);
        
        
        submit_btn.setHidden(false);
        
        back_btn.setHidden(false);
        
        
        break;
        
        
      case (SCREEN_ROT):
      
        conn_btn.setHidden(true);
        
        
        instr_collect.setHidden(true);
        
        mov_collect.setHidden(true);
        
        rot_collect.setHidden(false);
        
        beep_collect.setHidden(true);
        
        gotoxy_collect.setHidden(true);
        
        orient_collect.setHidden(true);
        
        
        submit_btn.setHidden(false);
        
        back_btn.setHidden(false);
        
        
        break;
        
        
      case (SCREEN_BEEP):
      
        conn_btn.setHidden(true);
        
        
        instr_collect.setHidden(true);
        
        mov_collect.setHidden(true);
        
        rot_collect.setHidden(true);
        
        beep_collect.setHidden(false);
        
        gotoxy_collect.setHidden(true);
        
        orient_collect.setHidden(true);
        
        
        submit_btn.setHidden(false);
        
        back_btn.setHidden(false);
        
        
        break;
        
        
      case (SCREEN_GOTOXY):
      
        conn_btn.setHidden(true);
        
        
        instr_collect.setHidden(true);
        
        mov_collect.setHidden(true);
        
        rot_collect.setHidden(true);
        
        beep_collect.setHidden(true);
        
        gotoxy_collect.setHidden(false);
        
        orient_collect.setHidden(true);
        
        
        submit_btn.setHidden(false);
        
        back_btn.setHidden(false);
        
        
        break;
        
        
      case (SCREEN_ORIENT):
      
        conn_btn.setHidden(true);
        
        
        instr_collect.setHidden(true);
        
        mov_collect.setHidden(true);
        
        rot_collect.setHidden(true);
        
        beep_collect.setHidden(true);
        
        gotoxy_collect.setHidden(true);
        
        orient_collect.setHidden(false);
        
        
        submit_btn.setHidden(false);
        
        back_btn.setHidden(false);
        
        
        break;
    }


    conn_btn.draw();
        
        
    instr_collect.draw();
        
    mov_collect.draw();
        
    rot_collect.draw();
    
    beep_collect.draw();
    
    gotoxy_collect.draw();
    
    orient_collect.draw();
    
        
    submit_btn.draw();
        
    back_btn.draw();
}


public static byte[] toByteArray(float val) { /* ----------
* This FUNCTION ...
* ---------- */
  
    byte[] bytes;
    
    
    bytes = new byte[4];
    
    bytes = ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putFloat(val).array();
    
    
    return bytes;
}


public void sendMove(float dist, boolean is_fwd) { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 7;
    
    byte buff[];


    buff = new byte[BLE_BUFF_SIZE];
 
       
    buff[0] = BLE_INSTR_MOV;
     
    for (int i = 0; i < 4; i++)
    
      buff[1 + i] = toByteArray(dist)[i];

    buff[5] = byte(is_fwd);
        
    buff[6] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendRotate(float deg, boolean is_ccw) { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 7;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_ROT;

    for (int i = 0; i < 4; i++)
    
      buff[1 + i] = toByteArray(deg)[i];
      
    buff[5] = byte(is_ccw);
        
    buff[6] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendBeep(float beeps) { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 6;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_BEEP;

    for (int i = 0; i < 4; i++)
    
      buff[1 + i] = toByteArray(beeps)[i];
        
    buff[5] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendGotoXY(float x_coord, float y_coord) { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 10;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_GOTOXY;

    for (int i = 0; i < 4; i++)
    
      buff[1 + i] = toByteArray(x_coord)[i];

    for (int i = 0; i < 4; i++)
    
      buff[5 + i] = toByteArray(y_coord)[i];
        
    buff[9] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendOrientate(float angle) { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 6;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_ORIENT;

    for (int i = 0; i < 4; i++)
    
      buff[1 + i] = toByteArray(angle)[i];

    buff[5] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendScan() { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 2;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_SCAN;

    buff[1] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendIdentify() { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 2;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_IDENT;

    buff[1] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendPatrol() { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 2;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_PATR;

    buff[1] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}


public void sendClear() { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 2;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_CLEAR;

    buff[1] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}

public void sendStop() { /*
* This FUNCTION ...
* ---------- */
  
    final int BLE_BUFF_SIZE = 2;
    
    byte buff[];
    

    buff = new byte[BLE_BUFF_SIZE];
          
          
    buff[0] = BLE_INSTR_STOP;
        
    buff[1] = BLE_END_MSG;


    blep.writeCharacteristic(ble, BLUEFRUIT_LE_UUID_TX, buff);
}



/* BLUETOOTH CALLBACKS */

void onDeviceDiscovered(BlepdroidDevice device) { /*
* This CALLBACK ...
* ---------- */
  
  if (device.address.equals(BLUEFRUIT_LE_ADDRESS)) {
    
       if (!is_conn) {
         
           if (blep.connectDevice(device)) {
        
               is_conn = true;
           
               ble = device;
               
               
               screen = SCREEN_INSTR;
           
               println("CONNECTED!");
               
           } else {
         
               println("CONNECTION FAILED!");
           }
       }
    }
}


void onServicesDiscovered(BlepdroidDevice device, int status) { /*
* This CALLBACK ...
* ---------- */
  
    HashMap<String, ArrayList<String>> servicesAndCharas = blep.findAllServicesCharacteristics(device);
  
  
    for (String service : servicesAndCharas.keySet()) {
    
        print(service + " has ");
    
        println(servicesAndCharas.get(service));
    }
  
  
    blep.setCharacteristicToListen(device, BLUEFRUIT_LE_UUID_RX);
}


void onBluetoothRSSI(BlepdroidDevice device, int rssi)  { /*
* This CALLBACK ...
* ---------- */
  
    println(" onBluetoothRSSI " + device.address + " " + Integer.toString(rssi));
}


void onBluetoothConnection( BlepdroidDevice device, int state) { /*
* This CALLBACK ...
* ---------- */
  
    blep.discoverServices(device);
}


void onCharacteristicChanged(BlepdroidDevice device, String characteristic, byte[] data) { /*
* This CALLBACK ...
* ---------- */

    String dataString = new String(data);
  
    println(" onCharacteristicChanged " + characteristic + " " + dataString  );
}


void onDescriptorWrite(BlepdroidDevice device, String characteristic, String data) { /*
* This CALLBACK ...
* ---------- */
  
    println(" onDescriptorWrite " + data);
}


void onDescriptorRead(BlepdroidDevice device, String characteristic, String data) { /*
* This CALLBACK ...
* ---------- */
  
    println(" onDescriptorRead " + data);
}


void onCharacteristicRead(BlepdroidDevice device, String characteristic, byte[] data) { /*
* This CALLBACK ...
* ---------- */
  
    println(" onCharacteristicRead " + data);
}


void onCharacteristicWrite(BlepdroidDevice device, String characteristic, byte[] data) { /*
* This CALLBACK ...
* ---------- */
  
    println(" onCharacteristicWrite " + data);
}
