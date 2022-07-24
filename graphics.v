`timescale 1ns / 1ps

module graphics(
    input wire clk, reset,
    input wire up, down, left, right,
    input wire [9:0] coord_x, coord_y,
    input wire active_area,
    
    output reg [2:0] rgb
);
    
    localparam RADIUS = 25;
    
    localparam CIRCLE_COLOR = 3'b101; // magenta
    localparam BACKGROUND_COLOR = 3'b010; // green
    
    // signal declaration
    reg [9:0] center_x, center_y;

    // next state regs
    reg [9:0] center_x_next, center_y_next;
    
    // sequential logic
    always @(posedge clk)
    begin
        if(reset)
        begin
            center_x <= 100;
            center_y <= 100;
        end
        else
        begin
            center_x <= center_x_next;
            center_y <= center_y_next;
        end
    end
    
    // moving the circle by one pixel based on inputs
    always @(*)
    begin
        center_x_next = center_x;
        center_y_next = center_y;
        
        if(up)
          center_y_next = center_y - 1;
        if(down)
          center_y_next = center_y + 1;
        if(left)
          center_x_next = center_x - 1;
        if(right)
          center_x_next = center_x + 1;
    end
    
    // check if the current pixel is inside our circle
    reg in_circle;
    always @(*)
    begin	        
        in_circle = (center_x - coord_x) * (center_x - coord_x) + 
                    (center_y - coord_y) * (center_y - coord_y) <= RADIUS * RADIUS;
        
        // default value
        rgb = 3'b000;
        if(active_area)
            rgb = BACKGROUND_COLOR;
        if(active_area && in_circle)
            rgb = CIRCLE_COLOR;
    end


endmodule
