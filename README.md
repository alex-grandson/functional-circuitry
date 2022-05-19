# Functional circuitry

## Lab 2

### Variant 1
Implement arithemic function using verilog with only 1 adder and 2 multipliers:

![y=a^2+\sqrt[3]{b}](https://latex.codecogs.com/svg.latex?y=a^2+\sqrt[3]{b}) 

First, let's implement adder:

```
Add adder
```

Then, let's handle square which can be implemented through multiplier with 

Compiling:

```bash
➜ iverilog mult.v mult_tb.v
```

Debug info and standart output:
```bash
➜ ./a.out                  

VCD info: dumpfile mult_tb.vcd opened for output.

       A                     OUT
xxxxxxxx (  x)  xxxxxxxxxxxxxxxx (    x)
       A                     OUT
00001000 (  8)  0000000000000000 (    0)
       A                     OUT
00000000 (  0)  0000000001000000 (   64)
```

Let's ensure we implemented out multiplier module correctly.

Diagram:
```bash
➜ gtkwave.exe mult_tb.vcd
```
![mult_diagram.png](img/mult_diagram.png)