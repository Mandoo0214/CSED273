/* CSED273 lab5 experiment 1 */
/* lab5_1.v */

`timescale 1ps / 1fs

/* Implement adder 
 * You must not use Verilog arithmetic operators */
module adder(
    input [3:0] x,
    input [3:0] y,
    input c_in,             // Carry in
    output [3:0] out,
    output c_out            // Carry out
); 

    ////////////////////////
    /* Add your code here */
    
    wire [3:0] mid_c0;
    wire [3:0] mid_c1;
    wire [3:0] mid_s0;
    wire [3:0] mid_s1;
    wire [3:0] mid_cout;
       
    xor(mid_s0[0], x[0], y[0]);
    and(mid_c0[0], x[0], y[0]);
    
    xor(mid_s1[0], mid_s0[0], c_in);
    and(mid_c1[0], mid_s0[0], c_in);
    
    assign mid_cout[0] = mid_c0[0] | mid_c1[0];
    assign out[0] = mid_s1[0];
    
    
    xor(mid_s0[1], x[1], y[1]);
    and(mid_c0[1], x[1], y[1]);
        
    xor(mid_s1[1], mid_s0[1], mid_cout[0]);
    and(mid_c1[1], mid_s0[1], mid_cout[0]);
        
    assign mid_cout[1] = mid_c0[1] | mid_c1[1];
    assign out[1] = mid_s1[1];
    
    
    xor(mid_s0[2], x[2], y[2]);
    and(mid_c0[2], x[2], y[2]);
        
    xor(mid_s1[2], mid_s0[2], mid_cout[1]);
    and(mid_c1[2], mid_s0[2], mid_cout[1]);
        
    assign mid_cout[2] = mid_c0[2] | mid_c1[2];
    assign out[2] = mid_s1[2];
    
    
    xor(mid_s0[3], x[3], y[3]);
    and(mid_c0[3], x[3], y[3]);
        
    xor(mid_s1[3], mid_s0[3], mid_cout[2]);
    and(mid_c1[3], mid_s0[3], mid_cout[2]);
        
    assign mid_cout[3] = mid_c0[3] | mid_c1[3];
    assign out[3] = mid_s1[3];
    
    assign c_out = mid_cout[3];    
    ////////////////////////

endmodule

/* Implement arithmeticUnit with adder module
 * You must use one adder module.
 * You must not use Verilog arithmetic operators */
module arithmeticUnit(
    input [3:0] x,
    input [3:0] y,
    input [2:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
    /* Add your code here */
    wire [3:0] in_y;
    
    assign in_y[0] = (y[0] & select[1]) | (~y[0] & select[2]);
    assign in_y[1] = (y[1] & select[1]) | (~y[1] & select[2]);
    assign in_y[2] = (y[2] & select[1]) | (~y[2] & select[2]);
    assign in_y[3] = (y[3] & select[1]) | (~y[3] & select[2]);
    
    adder A0(x[3:0], in_y[3:0], select[0], out[3:0], c_out);
    ////////////////////////

endmodule

/* Implement 4:1 mux */
module mux4to1(
    input [3:0] in,
    input [1:0] select,
    output out
);

    ////////////////////////
    /* Add your code here */
    assign out = select[1] ? (select[0] ? in[3] : in[2]) : (select[0] ? in[1] : in[0]);
    ////////////////////////

endmodule

/* Implement logicUnit with mux4to1 */
module logicUnit(
    input [3:0] x,
    input [3:0] y,
    input [1:0] select,
    output [3:0] out
);

    ////////////////////////
    /* Add your code here */
    wire [3:0] in_xy0;
    wire [3:0] in_xy1;
    wire [3:0] in_xy2;
    wire [3:0] in_xy3;
    
    assign in_xy0[0] = x[0] & y[0];
    assign in_xy0[1] = x[0] | y[0];
    assign in_xy0[2] = x[0] ^ y[0];
    assign in_xy0[3] = ~x[0];
    
    mux4to1 MUX0(in_xy0[3:0], select[1:0], out[0]);
    
    assign in_xy1[0] = x[1] & y[1];
    assign in_xy1[1] = x[1] | y[1];
    assign in_xy1[2] = x[1] ^ y[1];
    assign in_xy1[3] = ~x[1];
    
    mux4to1 MUX1(in_xy1[3:0], select[1:0], out[1]);
    
    assign in_xy2[0] = x[2] & y[2];
    assign in_xy2[1] = x[2] | y[2];
    assign in_xy2[2] = x[2] ^ y[2];
    assign in_xy2[3] = ~x[2];
    
    mux4to1 MUX2(in_xy2[3:0], select[1:0], out[2]);
    
    assign in_xy3[0] = x[3] & y[3];
    assign in_xy3[1] = x[3] | y[3];
    assign in_xy3[2] = x[3] ^ y[3];
    assign in_xy3[3] = ~x[3];
    
    mux4to1 MUX3(in_xy3[3:0], select[1:0], out[3]);
    ////////////////////////

endmodule

/* Implement 2:1 mux */
module mux2to1(
    input [1:0] in,
    input  select,
    output out
);

    ////////////////////////
    /* Add your code here */
    assign out = select ? in[1] : in[0];
    ////////////////////////

endmodule

/* Implement ALU with mux2to1 */
module lab5_1(
    input [3:0] x,
    input [3:0] y,
    input [3:0] select,
    output [3:0] out,
    output c_out            // Carry out
);

    ////////////////////////
    /* Add your code here */
    wire [3:0] Aout;
    wire [3:0] Lout;
    wire [1:0] in0;
    wire [1:0] in1;
    wire [1:0] in2;
    wire [1:0] in3;
    
    arithmeticUnit A(x[3:0], y[3:0], select[2:0], Aout[3:0], c_out);
    logicUnit L(x[3:0], y[3:0], select[1:0], Lout[3:0]);
    
    assign in0[0] = Aout[0];
    assign in0[1] = Lout[0];
    mux2to1 MUX0(in0[1:0], select[3], out[0]);
    
    assign in1[0] = Aout[1];
    assign in1[1] = Lout[1];
    mux2to1 MUX1(in1[1:0], select[3], out[1]);
    
    assign in2[0] = Aout[2];
    assign in2[1] = Lout[2];
    mux2to1 MUX2(in2[1:0], select[3], out[2]);
    
    assign in3[0] = Aout[3];
    assign in3[1] = Lout[3];
    mux2to1 MUX3(in3[1:0], select[3], out[3]);
    ////////////////////////

endmodule
