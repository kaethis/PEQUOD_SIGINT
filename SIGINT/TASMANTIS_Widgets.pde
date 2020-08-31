abstract class TASMANTIS_Widget { /*
* This ABSTRACT CLASS ...
* ---------- */

    protected final int STROKE_WEIGHT = 3;
    
    protected final int PADDING = 5;
        
    protected final color COLOR_PRIMARY = color(0, 0, 0);
    
    protected final color COLOR_SECONDARY = color(255, 255, 255);
    
    
    protected int x, y;
    
    protected int width,
    
                  height;
    
    protected boolean is_press,
    
                      is_hidden;
    
    
    public int getX() { return x; }
    
    public int getY() { return y; }
    
    public int getWidth() { return width; }
    
    public int getHeight() { return height; }
    
    public boolean isHidden() { return is_hidden; }
    
    public void setHidden(boolean is_hidden) { this.is_hidden = is_hidden; }
    
    public abstract boolean isPressed(float mx, float my);
    
    public abstract void draw();
}


class TASMANTIS_Button extends TASMANTIS_Widget { /*
* This CLASS ...
* ---------- */
  
    private final int TEXT_HEIGHT = 30;

    private final PFont TEXT_FONT = createFont("Courier", TEXT_HEIGHT);


    private String text;


    TASMANTIS_Button(int x, int y, int width, int height, String text) { /*
    * This CONSTRUCTOR ...
    * ---------- */
      
        this.x = x;
      
        this.y = y;
      
        this.width = width;
      
        this.height = height;
                
        this.text = text;
        
        
        is_press = false;
        
        is_hidden = false;
    }
    
    
    public boolean isPressed(float mx, float my) { /*
    * This FUNCTION ...
    * ---------- */
      
        is_press = (((mx >= x) && (mx <= (x + width)) &&
                     (my >= y) && (my <= (y + height))) &&
                    !is_hidden);
        
      
        return (is_press && !is_hidden);
    }
    
    
    public void draw() { /*
    * This FUNCTION ...
    * ---------- */
        
        if (!is_hidden) {
          
            fill(is_press ? COLOR_SECONDARY
                          : COLOR_PRIMARY);
        
            rect(x, y, width, height);
        
        
            stroke(COLOR_SECONDARY);
        
            strokeWeight(STROKE_WEIGHT);
        
            line(x, y, (x + width), y);
        
            line((x + width), y, (x + width), (y + height));
        
            line((x + width), (y + height), x, (y + height));
        
            line(x, (y + height), x, y);
        
           
            textFont(TEXT_FONT);
        
            fill(is_press ? COLOR_PRIMARY
                          : COLOR_SECONDARY);
                      
            text(text,
                 (x + ((width - textWidth(text)) / 2)),
                 ((y + ((TEXT_HEIGHT - PADDING) / 2)) + (height / 2)));
        }
    }
}


class TASMANTIS_NumberPad extends TASMANTIS_Widget { /* 
* This CLASS ... 
* ---------- */

    private final int BTN_WIDTH = 100;
    
    private final int BTN_HEIGHT = 100;
    
    private final int WIDTH = ((BTN_WIDTH * 3) + (PADDING * 2));
    
    private final int HEIGHT = ((BTN_HEIGHT * 4) + (PADDING * 3));
    
    private final String BTN_TEXTS[] = { "0", "1", "2",
                                         "3", "4", "5",
                                         "6", "7", "8",
                                         "9", ".", "<" };
    
    
    private char pressed;
    
    private TASMANTIS_Button btns[];
    
    
    TASMANTIS_NumberPad(int x, int y) { /*
    * This CONSTRUCTOR ...
    * ---------- */
      
        int btn_i;
        
        
        this.x = x;
      
        this.y = y;

        
        btns = new TASMANTIS_Button[12];
    
    
        btn_i = 1;
        
        for (int i = 0; i < 3; i++) {
         
            for (int j = 0; j < 3; j++) {
            
               btns[btn_i] = new TASMANTIS_Button(((x + (BTN_WIDTH * j)) + (PADDING * j)),
                                                  ((y + (BTN_WIDTH * i)) + (PADDING * i)),
                                                  BTN_WIDTH, BTN_HEIGHT,
                                                  BTN_TEXTS[btn_i]);
                                          
               btn_i++;
            }
        }
        
        btns[10] = new TASMANTIS_Button(((x + (BTN_WIDTH * 0)) + (PADDING * 0)),
                                        ((y + (BTN_WIDTH * 3)) + (PADDING * 3)),
                                        BTN_WIDTH, BTN_HEIGHT,
                                        BTN_TEXTS[10]);
                                          
        btns[0] = new TASMANTIS_Button(((x + (BTN_WIDTH * 1)) + (PADDING * 1)),
                                       ((y + (BTN_WIDTH * 3)) + (PADDING * 3)),
                                       BTN_WIDTH, BTN_HEIGHT,
                                       BTN_TEXTS[0]);
                               
        btns[11] = new TASMANTIS_Button(((x + (BTN_WIDTH * 2)) + (PADDING * 2)),
                                        ((y + (BTN_WIDTH * 3)) + (PADDING * 3)),
                                        BTN_WIDTH, BTN_HEIGHT,
                                        BTN_TEXTS[11]);
                          
                                
        is_hidden = false;
    }
    
    
    /* OVERRIDE */
    public int getWidth() { return WIDTH; }
    
    
    /* OVERRIDE */
    public int getHeight() { return HEIGHT; }
    
    
    public boolean isPressed(float mx, float my) { /*
    * This FUNCTION ...
    * ---------- */
    
        boolean is_press;
        
        
        is_press = false;
        
        if (!is_hidden) {
          
            for (int i = 0; i < 12; i++)
         
                if (btns[i].isPressed(mx, my)) {
              
                    pressed = btns[i].text.charAt(0);
                
                    is_press = true;
                }
        }
        
        
        return (is_press && !is_hidden);
    }
    
    
    /* OVERRIDE */
    public void setHidden(boolean is_hidden) { /*
    * This FUNCTION ...
    * ---------- */
    
        for (int i = 0; i < 12; i++) btns[i].setHidden(is_hidden);
      
        this.is_hidden = is_hidden;
    }
    
    
    public void draw() { /* 
    * This FUNCTION ...
    * ---------- */

        if (!is_hidden)
        
            for (int i = 0; i < 12; i++)
            
                btns[i].draw();
    }
    
    
    public char getPressed() { return pressed; }
}


class TASMANTIS_Label extends TASMANTIS_Widget { /*
* This CLASS ...
* ---------- */

    private final int TEXT_HEIGHT = 20;

    private final PFont TEXT_FONT = createFont("Courier", TEXT_HEIGHT);


    private String text;
    
    
    TASMANTIS_Label(int x, int y, int width, int height, String text) { /*
    * This CONSTRUCTOR ...
    * ---------- */
    
        this.x = x;
        
        this.y = y;
        
        this.width = width;
        
        this.height = height;
                
        this.text = text;
        
        
        is_hidden = false;
    }
   
   
    public boolean isPressed(float mx, float my) { /*
    * This FUNCTION ...
    * ---------- */
      
        is_press = (((mx >= x) && (mx <= (x + width)) &&
                     (my >= y) && (my <= (y + height))) &&
                    !is_hidden);
        
      
        return (is_press && !is_hidden);
    }
    
    
    public void draw() { /*
    * This FUNCTION ...
    * ---------- */
     
        if (!is_hidden) {
        
            fill(COLOR_PRIMARY);
        
            rect(x, y, width, height);
 
 
            stroke(COLOR_SECONDARY);
        
            strokeWeight(STROKE_WEIGHT);
        
            line(x, y, (x + width), y);
        
            line((x + width), y, (x + width), (y + height));
        
            line((x + width), (y + height), x, (y + height));
        
            line(x, (y + height), x, y);
            
           
            textFont(TEXT_FONT);
        
            fill(COLOR_SECONDARY);
            
            text(text,
                 (x + PADDING),
                 ((y + ((TEXT_HEIGHT - PADDING) / 2)) + (height / 2)));
        }
    }
}


class TASMANTIS_TextField extends TASMANTIS_Widget { /*
* This CLASS ...
* ---------- */

    private final int TEXT_HEIGHT = 50;

    private final PFont TEXT_FONT = createFont("Courier", TEXT_HEIGHT);
    
    
    private String text;
    
    private int char_max;
    
    
    TASMANTIS_TextField(int x, int y, int width, int height, int char_max, String text) { /*
    * This CONSTRUCTOR ...
    * ---------- */
    
        this.x = x;
        
        this.y = y;
        
        this.width = width;
        
        this.height = height;
        
        this.char_max = char_max;
                
        this.text = text;
        
        
        is_hidden = false;
    }
    
    
    public boolean isPressed(float mx, float my) { /*
    * This FUNCTION ...
    * ---------- */
      
        is_press = (((mx >= x) && (mx <= (x + width)) &&
                     (my >= y) && (my <= (y + height))) &&
                    !is_hidden);
        
      
        return (is_press && !is_hidden);
    }
    
    
    public void draw() { /*
    * This FUNCTION ...
    * ---------- */
     
        if (!is_hidden) {
        
            fill(COLOR_SECONDARY);
        
            rect(x, y, width, height);
 
           
            textFont(TEXT_FONT);
        
            fill(COLOR_PRIMARY);
                      
            text(text,
                 (x + PADDING),
                 ((y + ((TEXT_HEIGHT - PADDING) / 2)) + (height / 2)));
        }
    }
    
    
    public void setText(String text) { /*
    * This FUNCTION ...
    * ---------- */
    
        this.text = text;
    }
    
    
    public void input(char ch) { /*
    * This FUNCTION ...
    * ---------- */
      
        if (ch == '<')
        
            backspace();
    
        else if (ch == '.') {
        
            if (!text.contains(".")) append('.');
            
        } else
        
            append(ch);
    }
    
    
    public void clear() { text = ""; }
    
    
    public void backspace() { if (text.length() > 0) text = text.substring(0, text.length() - 1); }
    
    
    public void append(char ch) { if (text.length() <= char_max) text += ch; }
    
    
    public float entry() { return float(text); }
    
    
    public boolean isNumber() { return !Float.isNaN(entry()); }
}


class TASMANTIS_ToggleSwitch extends TASMANTIS_Widget { /*
* This CLASS ...
* ---------- */
 
    private final int BTN_WIDTH = 100;
    
    private final int BTN_HEIGHT = 50;
    
    private final int WIDTH = ((BTN_WIDTH * 2) + (PADDING * 3));
    
    private final int HEIGHT = (BTN_HEIGHT + (PADDING * 2));
    
    private final int TEXT_HEIGHT = 40;

    private final PFont TEXT_FONT = createFont("Courier", TEXT_HEIGHT);
 
    
    private String choices[];
    
    private boolean is_on;
    
    
    TASMANTIS_ToggleSwitch(int x, int y, String choices[]) { /*
    * This CONSTRUCTOR ...
    * ---------- */
      
        this.x = x;
        
        this.y = y;
      
        this.choices = choices;
        
        
        is_on = true;
    }
    
    
    /* OVERRIDE */
    public int getWidth() { return WIDTH; }
    
    
    /* OVERRIDE */
    public int getHeight() { return HEIGHT; }
    
    
    public boolean isPressed(float mx, float my) { /*
    * This FUNCTION ...
    * ---------- */
      
        is_press = (((mx >= x) && (mx <= (x + WIDTH)) &&
                     (my >= y) && (my <= (y + HEIGHT))) &&
                    !is_hidden);
        
        if (is_press && !is_hidden) is_on = !is_on;
        
      
        return (is_press && !is_hidden);
    }
    
    
    public void draw() { /*
    * This FUNCTION ...
    * ---------- */
     
        if (!is_hidden) {
        
            fill(COLOR_SECONDARY);
        
            rect(x, y, WIDTH, HEIGHT);
 
            
            fill(is_on ? COLOR_SECONDARY
                       : COLOR_PRIMARY);
            
            rect((x + PADDING), (y + PADDING), BTN_WIDTH, BTN_HEIGHT);

            fill(is_on ? COLOR_PRIMARY
                       : COLOR_SECONDARY);
            
            rect((x + PADDING + BTN_WIDTH + PADDING), (y + PADDING), BTN_WIDTH, BTN_HEIGHT);
            

            stroke(COLOR_PRIMARY);
        
            strokeWeight(STROKE_WEIGHT);
        
            line((x + PADDING), (y + PADDING),
                 (x + PADDING + BTN_WIDTH), (y + PADDING));
        
            line((x + PADDING + BTN_WIDTH), (y + PADDING),
                 (x + PADDING + BTN_WIDTH), (y + PADDING + BTN_HEIGHT));
        
            line((x + PADDING + BTN_WIDTH), (y + PADDING + BTN_HEIGHT),
                 (x + PADDING), (y + PADDING + BTN_HEIGHT));
        
            line((x + PADDING), (y + PADDING + BTN_HEIGHT),
                 (x + PADDING), (y + PADDING));
                 
            line((x + (PADDING * 2) + BTN_WIDTH), (y + PADDING),
                 (x + (PADDING * 2) + (BTN_WIDTH * 2)), (y + PADDING));
        
            line((x + (PADDING * 2) + (BTN_WIDTH * 2)), (y + PADDING),
                 (x + (PADDING * 2) + (BTN_WIDTH * 2)), (y + PADDING + BTN_HEIGHT));
        
            line((x + (PADDING * 2) + (BTN_WIDTH * 2)), (y + PADDING + BTN_HEIGHT),
                 (x + (PADDING * 2) + BTN_WIDTH), (y + PADDING + BTN_HEIGHT));
        
            line((x + (PADDING * 2) + BTN_WIDTH), (y + PADDING + BTN_HEIGHT),
                 (x + (PADDING * 2) + BTN_WIDTH), (y + PADDING));
            
            
            textFont(TEXT_FONT);
        
            fill(is_on ? COLOR_PRIMARY
                       : COLOR_SECONDARY);
            
            text(choices[0],
                 (x + PADDING + ((BTN_WIDTH - textWidth(choices[0])) / 2)),
                 ((y + ((TEXT_HEIGHT - PADDING) / 2)) + (HEIGHT / 2)));
                 
            fill(is_on ? COLOR_SECONDARY
                       : COLOR_PRIMARY);
                       
            text(choices[1],
                 (x + (PADDING * 2) + BTN_WIDTH + ((BTN_WIDTH - textWidth(choices[1])) / 2)),
                 ((y + ((TEXT_HEIGHT - PADDING) / 2)) + (HEIGHT / 2)));
        }
    }
    
    
    public String getChoice() { return choices[int(is_on)]; }
}


class TASMANTIS_WidgetCollection { /*
* This CLASS ...
* ---------- */
    
    private ArrayList<TASMANTIS_Widget> widgets;
 
    
    TASMANTIS_WidgetCollection() { /* ----------
    * This CONSTRUCTOR ...
    * ---------- */
 
        widgets = new ArrayList<TASMANTIS_Widget>();
    }
    
    
    public void add(TASMANTIS_Widget widget) { /* ----------
    * This FUNCTION ...
    * ---------- */
     
        widgets.add(widget);
    }


    public void remove(TASMANTIS_Widget widget) { /* ----------
    * This FUNCTION ...
    * ---------- */
     
        widgets.remove(widget);
    }
    
    
    public void setHidden(boolean is_hidden) { /* ----------
    * This FUNCTION ...
    * ---------- */
      
        for (int i = 0; i < widgets.size(); i++)
          
            widgets.get(i).setHidden(is_hidden);
    }
    
    public void draw() { /* ----------
    * This FUNCTION ...
    * ---------- */
    
        for (int i = 0; i < widgets.size(); i++)
            
            widgets.get(i).draw();
    }
}
