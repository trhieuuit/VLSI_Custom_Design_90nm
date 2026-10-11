# VLSI Custom Design 90nm

This project focuses on the full-custom design flow of CMOS Integrated Circuits, encompassing schematic entry, layout design, parasitic RC extraction, and HSPICE simulation.
The coursework explores the fundamental characteristics of MOSFETs, standard logic gates (Inverter, NAND2), sequential logic (D Flip-Flop), and advanced circuits such as a
10GHz Ring Oscillator and a 2-to-4 Address Decoder. Through 14 comprehensive exercises, the project evaluates crucial VLSI parameters—including propagation delay, power consumption,
static noise margin (SNM), and parasitic RC effects—bridging the gap between theoretical calculations and practical post-layout physical behaviors.

This repository contains the schematic designs, layout masks, HSPICE simulations, and technical analyses for 14 exercises in the VLSI coursework project.

## Project Exercises

### Exercise 1: Inverter Gate
- **Requirement:** Design schematic and layout, and analyze transient operation.


- **Result:** Mapped logic levels operate correctly. Post-layout simulation shows Fall time (82.59ps) is greater than Rise time (78.30ps) due to the impact of extracted parasitic RC elements altering the discharge characteristics.




### **Exercise 2: NAND2 Gate**
- **Requirement:** Design schematic and layout, and perform DC analysis.


- **Result:** Output strictly follows the NAND truth table. Post-layout Rise time increases significantly (from 21.2ps to 36.6ps) due to parasitic components introduced by the parallel PMOS structure.




### **Exercise 3: D Flip-Flop (Transmission Gate)**
- **Requirement:** Design a DFF using a D Latch, and evaluate area, power, and simulation parameters.


- **Result:** The circuit correctly flips state on the clock's rising edge. Post-layout propagation delay and transition times increase sharply due to heavy RC parasitics from clock distribution networks and metal routing.




### **Exercise 4 & 5: NMOS and PMOS I-V Characteristics**
- **Requirement:** Analyze I-V curves with Length = 0.1um and varying Widths (0.2um, 1um, 2um).


- **Result:** The graphs clearly demonstrate cut-off, linear, and saturation regions. Maximum saturation current is directly proportional to channel width, though slightly degraded by contact resistance and parasitic capacitance.




### **Exercise 6: Pass Transistor Transmission**
- **Requirement:** Evaluate logic transmission capabilities of single NMOS and PMOS pass transistors.


- **Result:** NMOS passes a strong 0 but a weak 1 (voltage drops by $V_{tn}$). PMOS passes a strong 1 but a weak 0 (voltage floats at $\vert{}V_{tp}\vert{}$).




### **Exercise 7: Pass Transistor Chain**
- **Requirement:** Simulate a 3-stage NMOS series chain and a cascaded pass-transistor circuit.


- **Result:** In a series chain, the threshold voltage drop ($V_{tn}$) only occurs at the first transistor; subsequent stages act as small ohmic resistors. In ungrounded cascaded nodes, static subthreshold leakage can drive floating nodes to inaccurate voltage levels.




### **Exercise 8: Inverter Static Noise Margin (SNM)**
- **Requirement:** Design an inverter with $W_n=5\mu m, W_p=2\mu m$ and measure static noise margin.


- **Method:** Perform a DC sweep and extract points where $dV_{out}/dV_{in} = -1$ to find $V_{IL}$ and $V_{IH}$.


- **Result:** The switching threshold is balanced at $V_{SP} = 0.633V$. Total noise margin is 0.924V (77% of the supply voltage), proving excellent noise immunity.




### **Exercise 9: RC Circuit Charge/Discharge**
- **Requirement:** Simulate the charging/discharging process of a 1st-order RC circuit.


- **Method:** Calculate the time constant $\tau$ and compare it with the theoretical transition formula $2.2RC$.


- **Result:** Minimal error (~2.5%) exists between theory and simulation, primarily caused by the practical input pulse's finite slope (10fs) compared to an ideal step function.




### **Exercise 10: Carrier Mobility Comparison**
- **Requirement:** Compare the mobility of holes (PMOS) and electrons (NMOS).


- **Method:** Connect both devices as diodes to force saturation and measure the $I_{ds}$ difference.


- **Result:** NMOS current is ~2.24 times higher than PMOS. Standard inverter sizing requires $W_p \approx 2.24W_n$ to balance pull-up and pull-down speeds.




### **Exercise 11: RC Extraction**
- **Requirement:** Extract RC parasitics from the Inverter Unit ($W_n=1\mu m, W_p=2.24\mu m$).


- **Result:** Due to a larger $W_p$, PMOS junction capacitance is 1.74 times higher than NMOS. Conversely, PMOS parasitic resistance (6.47 $\Omega$) is lower than NMOS (9.04 $\Omega$) due to a larger diffusion area and more parallel contacts.




### **Exercise 12: Propagation Delay Estimation**
- **Requirement:** Calculate and measure the delay of an Inverter Unit driving a second Inverter Unit.


- **Method:** Utilize the dynamic equivalent resistance ($R_{eq}$) extracted from a 50fF load simulation to apply the $2.2RC$ delay model.


- **Result:** Actual simulation delays (16-18ps) are significantly slower than mathematical estimates (~7ps) because the simplified model ignores finite input signal slopes and short-circuit currents during switching.




### **Exercise 13: 10GHz Ring Oscillator**
- **Requirement:** Design a self-oscillating circuit targeting a 10GHz frequency.


- **Method:** Calculate required stages ($N=3$) based on unit delay, then sweep the width multiplier ($K$) and Length ($L$) to tune the frequency.


- **Result:** At $L=0.14\mu m$, the oscillator stabilizes at 9.9GHz, yielding a 1% error margin from the target.




### **Exercise 14: 2-to-4 Address Decoder**
- **Requirement:** Design, layout, and simulate a 2-to-4 decoder.


- **Method:** Apply Logical Effort to determine the architecture with the lowest normalized delay: NAND2-INV-NAND2-INV.


- **Result:** Correctly demultiplexes logic signals. Minor local variations in rise/fall times across outputs are observed due to varying wire lengths and uneven parasitic capacitances.