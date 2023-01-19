/* CSED273 lab3 experiment 1 */
/* lab3_1.v */


/* Active Low 2-to-4 Decoder
 * You must use this module to implement Active Low 4-to-16 decoder */
module decoder(
    input wire en,
    input wire [1:0] in,
    output wire [3:0] out 
    );

    nand(out[0], ~in[0], ~in[1], ~en);
    nand(out[1],  in[0], ~in[1], ~en);
    nand(out[2], ~in[0],  in[1], ~en);
    nand(out[3],  in[0],  in[1], ~en);

endmodule


/* Implement Active Low 4-to-16 Decoder
 * You may use keword "assign" and operator "&","|","~",
 * or just implement with gate-level modeling (and, or, not) */
module lab3_1(
    input wire en,
    input wire [3:0] in,
    output wire [15:0] out
    );

    wire [3:0] enable; /* out에 연결될 decoder들의 enable 값을 지정할 wire */
    
    decoder D1(en, in[3:2], enable[3:0]);
    decoder D2(enable[0], in[1:0], out[3:0]);
    decoder D3(enable[1], in[1:0], out[7:4]);
    decoder D4(enable[2], in[1:0], out[11:8]);
    decoder D5(enable[3], in[1:0], out[15:12]);

endmodule
