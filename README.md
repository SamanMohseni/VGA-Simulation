# A simple VGA monitor simulator to test Verilog models

With this simulator, you can visualize the VGA output of your Verilog design in near real-time. However, the speed of simulation can either be faster or slower than reality, based on the complexity of your Verilog design and your system's speed.

To do this simulation, you need to have Verilator installed. Verilator is a free, open-source software tool that can convert Verilog to a cycle-accurate behavioral model in C++ or SystemC.
You also need to have OpenGL installed.
Using the following commands, you can install everything you need to run this simulation on Ubuntu Linux (tested on Ubuntu 22.04).

```bash
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install verilator
sudo apt-get install libglu1-mesa-dev freeglut3-dev mesa-common-dev
```

Now you're ready to run the simulation. Just put **"vga_controller.v"**, **"graphics.v"**, **"display.v"** and **"simulator.cpp"** in a folder (with **no spaces** in the folder name or directory) or clone into this repository, and open the terminal in the folder's directory and enter the following commands:

```bash
verilator -Wall --cc --exe simulator.cpp display.v -LDFLAGS -lglut -LDFLAGS -lGLU -LDFLAGS -lGL
make -j -C obj_dir -f Vdisplay.mk Vdisplay
obj_dir/Vdisplay
```
After execution, you should see a magenta circle on a green background, as shown below. You should also be able to move the circle using arrow keys.

![VGA Simulator](https://github.com/SamanMohseni/VGA-Simulation/blob/main/VGA_Simulator.png | width = 100)

## Simulating your own design
"display.v" is the top module of our design and also the interface to the simulator. This module uses two other sub-modules, one of which is "vga_controller.v", responsible for generating VGA synchronization signals, and the other is "graphics.v", which produces the display content by specifying the color of each pixel at any moment.
The "simulator.cpp" file is our custom simulator written in C++ that uses OpenGL to convert VGA signals into images.

By replacing the Verilog modules with your design and slightly modifying the "simulator.cpp" file, you'll be able to simulate VGA on your own projects.

## More on Verilator
In general, Verilator takes a module, for example, "top.v", as a top module and creates the "Vtop" class, whose header is located in the "Vtop.h" file. By including this file in your C++ simulator, you can access your Verilog design's inputs and outputs. Inputs and outputs of your design are publicly available in the "Vtop" class without changing the names.
With that said, you can easily modify the "simulator.cpp" to customize it for your design.
