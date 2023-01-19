/* CSED273 lab4 experiment 1 */
/* lab4_1.v */


/* Implement Half Adder
 * You may use keword "assign" and bitwise opeartor
 * or just implement with gate-level modeling*/
module halfAdder(
    input in_a,
    input in_b,
    output out_s,
    output out_c
    );

    xor(out_s, in_a, in_b);
    assign out_c = in_a & in_b;

endmodule

/* Implement Full Adder
 * You must use halfAdder module
 * You may use keword "assign" and bitwise opeartor
 * or just implement with gate-level modeling*/
module fullAdder(
    input in_a,
    input in_b,
    input in_c,
    output out_s,
    output out_c
    );
    
    wire out_c0;
    wire out_c1;
    
    wire out_s0;
    wire out_s1;
    
    halfAdder HA0(in_a, in_b, out_s0, out_c0);
    halfAdder HA1(out_s0, in_c, out_s1, out_c1);
    
    assign out_c = out_c0 | out_c1;
    assign out_s = out_s1;

endmodule