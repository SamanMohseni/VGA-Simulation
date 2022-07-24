`timescale 1ns / 1ps

module display(
    input wire clk, reset,
    input wire up, down, left, right,
    output wire h_sync, v_sync,
    output wire [2:0] rgb
);
    
    // signal declaration
    wire [9:0] coord_x, coord_y;
    wire active_area;
    
    // assuming our main clk is 50MHz,
    // as its common between most of FPGA boards
    reg clk_25;
    always @(posedge clk)
    begin
        clk_25 <= ~clk_25;
    end
    
    // instantiate vga_controller circuit 
    vga_controller vga_controller_unit(
        .clk_25(clk_25), .reset(reset), .h_sync(h_sync), .v_sync(v_sync),
        .coord_x(coord_x), .coord_y(coord_y), .active_area(active_area)
    );
    
    // instantiate graphics generator
    graphics graphics_unit(
        .clk(clk), .reset(reset),
        .up(up), .down(down), .left(left), .right(right),
        .coord_x(coord_x), .coord_y(coord_y),
        .active_area(active_area), .rgb(rgb)
    );

endmodule
