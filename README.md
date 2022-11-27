
# 24-hour-clock-with-assembly-language-for-8052
Here is a simple project on how to make a digital clock with 8051(89c51,89s52) microcontroller. The clock is efficient and their is no difference in time even in milli seconds. You can verify it with the digital clock you have. In the project i utilized the 8051 microcontroller internal clock source to produce a delay exactly equal to 1 second. This delay is then used to build a efficient clock with 89s52 microcontroller. Usually digital RTC(real time clocks) are interfaced with microcontrollers to make a digital clock. But i utilized the internal timers of 89s52 microcontroller to generate a precise time for making a clock with 8051 microcontroller. 16×2 lcd is interfaced with 8051 microcontroller to display time on lcd. Time in minutes, hours and seconds will be displayed on 16×2 lcd. 4×4 numeric keypad is also part of the 8051 digital clock project. It is used to set time, user manually enters the hours, minutes and seconds by pressing the buttons of 4×4 numeric keypad. Buttons represents numbers on keypad.

**Programing language:** Assembly  

**Used Hardware:** 
- 16×2 lcd                        (To display time)
- 8051                              (89c51 or any of 8051 series microcontroller)
- Potentiometer/variable resistor                (For setting LCD contrast)
- Crystal(11.0592 MHz)    (For clock generation)
- 4×4 keypad                     (For setting time)
- 5 volts power supply for driving lcd and microcontroller.
- Buzzer (for 1 hour reminder)

![ScreenShot of Proteus Circuit](https://github.com/aknahin/24-hour-clock-with-assembly-language-for-8052/blob/main/ScreenShots/Proteus%20Circuit.png)

Proteus circuit and hardware circuit is a bit different. In proteus circuit I didn't use P0 for any work. Buzzer is active low in my hardware setup. So, I have to put a not gate in proteus circuit.
## 8051 digital clock – Working

When you are done with all the above circuit building and code compilation. Then burn the code in your 8051 microcontrollers with a good burner and now it's time to test the code. At the start of the circuit triggering/powering you will see a cursor blinking on the first line of the 16×2 lcd and on second line you will see time in hours, minutes and seconds. Hour increments after every 60 minutes, minute is incremented after 60 seconds. When hour, minute and seconds reaches 24, 60, 60 they are again initialized with 0 for next reading. You will hear the buzzer in every 1hrs.
