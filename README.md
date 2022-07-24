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

Now you're ready to run the simulation. Just put **"vga_controller.v"**, **"graphics.v"**, **"display.v"** and **"simulator.cpp"** in a folder and open the terminal in the folder's directory and enter the following commands:

```bash
verilator -Wall --cc --exe simulator.cpp display.v -LDFLAGS -lglut -LDFLAGS -lGLU -LDFLAGS -lGL
make -j -C obj_dir -f Vdisplay.mk Vdisplay
obj_dir/Vdisplay
```
You should see a magenta circle on a green background after execution. You should also be able to move the circle using arrow keys.

## More on Verilator:
In general, Verilator takes a module, for example, "top.v", as a top module and creates the "Vtop" class, whose header is located in the "Vtop.h" file. By including this file in your C++ simulator, you can access your Verilog design's inputs and outputs. Inputs and outputs of your design are publicly available in the "Vtop" class without changing the names.
With that said, you can easily modify the "simulator.cpp" to customize it for your design.
