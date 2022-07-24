`timescale 1ns / 1ps

module vga_controller(
    input  wire clk_25, reset,
    
    output reg h_sync, v_sync,
    output reg [9:0] coord_x, coord_y,
    output reg active_area
);

    // 640X480 VGA sync parameters
    localparam LEFT_PORCH		= 	48;
    localparam ACTIVE_WIDTH		= 	640;
    localparam RIGHT_PORCH		= 	16;
    localparam HORIZONTAL_SYNC	=	96;
    localparam TOTAL_WIDTH		=	800;
    
    localparam TOP_PORCH		= 	33;
    localparam ACTIVE_HEIGHT	= 	480;
    localparam BOTTOM_PORCH		= 	10;
    localparam VERTICAL_SYNC	=	2;
    localparam TOTAL_HEIGHT		=	525;

    // next state regs
    reg h_sync_next, v_sync_next;
    reg [9:0] coord_x_next, coord_y_next;
    reg active_area_next;
    
    // sequential logic
    always @(posedge clk_25)
    begin
        if(reset)
        begin
            h_sync <= 0;
            v_sync <= 0;
            coord_x <= 0;
            coord_y <= 0;
            active_area <= 0;
        end
        else
        begin
            h_sync <= h_sync_next;
            v_sync <= v_sync_next;
            coord_x <= coord_x_next;
            coord_y <= coord_y_next;
            active_area <= active_area_next;
        end
    end
    
    // combinational logic
    always @(*)
    begin
        h_sync_next = coord_x >= RIGHT_PORCH + ACTIVE_WIDTH && 
                      coord_x < RIGHT_PORCH + ACTIVE_WIDTH + HORIZONTAL_SYNC;
        v_sync_next	= coord_y >= TOP_PORCH + ACTIVE_HEIGHT && 
                      coord_y < TOP_PORCH + ACTIVE_HEIGHT + VERTICAL_SYNC;
        
        
        if(coord_x == TOTAL_WIDTH - 1)
        begin
            coord_x_next = 0;
            if(coord_y == TOTAL_HEIGHT - 1)
                coord_y_next = 0;
            else
                coord_y_next = coord_y + 1;
        end
        else
        begin
            coord_x_next = coord_x + 1;
            coord_y_next = coord_y;
        end
            
            
        active_area_next = coord_x < ACTIVE_WIDTH && coord_y < ACTIVE_HEIGHT;
    end


endmodule
