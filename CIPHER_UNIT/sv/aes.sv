
module cipher_unit(
input CLK,
input CLR,
input CK,
input [31:0] KEY [7:0],
input [1:0] KL, 
input enc_dec,
input logic [31:0]state_i[3:0],
output logic [31:0]state_o[3:0],
output logic CF
);
    

//declaring varibales
logic [31:0]Rk[3:0];
logic [3:0]R;            
logic SCLR;
logic SE;
logic KF;

logic mux0;
logic mux1;
logic [1:0]mux2;
logic mux3;
logic mux4;
logic mux5;
logic mux6;



logic [31:0]state_i0[3:0];//    for state
logic [31:0]state_o0[3:0];

logic [31:0]state_i1[3:0];//    for BS
logic [31:0]state_o1[3:0];

logic [31:0]state_i2[3:0];//    for RS 
logic [31:0]state_o2[3:0];

logic [31:0]state_i3[3:0];//    for MC
logic [31:0]state_o3[3:0];

logic [31:0]state_i4[3:0];//    for ARK
logic [31:0]state_o4[3:0];


CU_S s(
.CLK(CLK),
.CLR(CLR),
.enc_dec(enc_dec),
.KL(KL),
.KF(KF),
.mux0(mux0),
.mux1(mux1),
.mux2(mux2),
.mux3(mux3),
.mux4(mux4),
.mux5(mux5),
.mux6(mux6),
.SE(SE),
.SCLR(SCLR),
.CF(CF),
.R(R)
);//            CONTROL UNIT




KEXP kexp(
.CLK(CLK),
.R(R),
.KL(KL),
.KEY(KEY),
.Rk(Rk),
.CLR(CK),
.KF(KF)
);//            KEY EXPANSION


State Si(
.CLK(CLK),
.enable(SE),
.CLR(SCLR),
.state_i(state_i0),
.state_o(state_o0)
);  


assign state_o = state_o0; //<------ changes here

BS Bs(
.state_i(state_i1),   
.enc_dec(enc_dec),
.state_o(state_o1)
);//            BYTE SUB ARRAY


RS Rs(
.state_i(state_i2),
.enc_dec(enc_dec),
.state_o(state_o2)
);//            ROW SHIFT


MC Mc(
.state_i(state_i3),   
.enc_dec(enc_dec),
.state_o(state_o3)
);//            MIXED COLUMN ARRAY


ARK Ark(
.state_i(state_i4),
.Rk(Rk),
.state_o(state_o4)
);//            ADD ROUND KEY


always_comb
begin
    state_i1 = mux1?(state_o0):(state_o2);//        into BS 


    
    state_i2 = mux2[1]?(state_o3):(mux2[0]?(state_o1):(state_o4));//into RS
    
    /*
    case(mux2)//                                    into RS
        0:  // LATCH INFERRED HERE CHANGED TO REMOVE LATCH, kept in files to make reading the statement above easier
            begin
                state_i2 = state_o4;
            end
        1:
            begin
                state_i2 = state_o1;
            end                   
        2:
            begin
                state_i2 = state_o3;
            end                               
    endcase
    */

    
    state_i3 = mux3?(state_o2):(state_o4);//        into MC


    case(mux4)//                                    into ARK
        0:
            begin
                state_i4 = mux6?state_o2:state_o3;//EN
            end
        1:
            begin
                state_i4 = state_o0;//E0
            end  
    endcase


    case(mux5)//                               into state
        0:
            begin
                state_i0 = mux0?state_i:state_o1;//decryption
            end
        1:
            begin
                state_i0 = mux0?state_i:state_o4;//encryption
            end        
    endcase


end

    
endmodule
