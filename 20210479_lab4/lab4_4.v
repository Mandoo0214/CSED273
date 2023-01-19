/* CSED273 lab4 experiment 4 */
/* lab4_4.v */

/* Implement 5x3 Binary Mutliplier
 * You must use lab4_2 module in lab4_2.v
 * You cannot use fullAdder or halfAdder module directly
 * You may use keword "assign" and bitwise opeartor
 * or just implement with gate-level modeling*/
module lab4_4(
    input [4:0]in_a,
    input [2:0]in_b,
    output [7:0]out_m
    );
    
    wire [4:0] ABand0;
    wire [4:0] ABand1;
    wire [4:0] ABand2;
    wire [4:0] augend0;
    
    wire [4:0] out_s0;
    wire [4:0] out_s1;
    
    wire out_c0;
    wire out_c1;
    
    wire in_c;
    
    /* 회로에 사용되는 모든 and gate */
    assign ABand0[0] = 0;
    and(ABand0[1], in_a[1], in_b[0]);
    and(ABand0[2], in_a[2], in_b[0]);
    and(ABand0[3], in_a[3], in_b[0]);
    and(ABand0[4], in_a[4], in_b[0]);
    
    and(ABand1[0], in_a[0], in_b[1]);
    and(ABand1[1], in_a[1], in_b[1]);
    and(ABand1[2], in_a[2], in_b[1]);
    and(ABand1[3], in_a[3], in_b[1]);
    and(ABand1[4], in_a[4], in_b[1]);
    
    and(ABand2[0], in_a[0], in_b[2]);
    and(ABand2[1], in_a[1], in_b[2]);
    and(ABand2[2], in_a[2], in_b[2]);
    and(ABand2[3], in_a[3], in_b[2]);
    and(ABand2[4], in_a[4], in_b[2]);       
    
    assign in_c = 0;
    lab4_2 RA0(ABand0[4:0], ABand1[4:0], in_c, out_s0[4:0], out_c0);
    
    /* 두번째 리플 가산기의 augend 부분 */
    assign augend0[0] = out_s0[1];
    assign augend0[1] = out_s0[2];
    assign augend0[2] = out_s0[3];
    assign augend0[3] = out_s0[4];
    assign augend0[4] = out_c0;
    
    lab4_2 RA1(ABand2[4:0], augend0[4:0], in_c, out_s1[4:0], out_c1);
    
    assign out_m[0] = in_a[0] & in_b[0];
    assign out_m[1] = out_s0[0];
    assign out_m[2] = out_s1[0];
    assign out_m[3] = out_s1[1];
    assign out_m[4] = out_s1[2];
    assign out_m[5] = out_s1[3];
    assign out_m[6] = out_s1[4];
    assign out_m[7] = out_c1;
    
endmodule