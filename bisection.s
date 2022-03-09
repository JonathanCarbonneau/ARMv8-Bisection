.text
.global _start
.extern printf

_start:
    ADR     X3, coeff
    ADR     X0, t
    LDUR    D15,[X0]
    ADR     X0, a
    LDUR    D9, [X0]
    ADR     X0, b
    LDUR    D11,[X0]
    LDR     X5, =N
    LDR     X7,[X5]  
    MOV     X6, X7    
    MOV     X12, 1
    FMOV    D8, X12  
     
calculate:
    SUB     X6, X6, 1    
    MOV     X9, 8
    MUL     X10, X6, X9  
    LDR     D12,[X3,X10]  
    FMOV    D2, D12      
    FMOV    D3, D12     
    FMOV    D4, D12    
    FADD    D16, D9, D11   
    FMOV    D17, 2 
    FDIV    D1, D16, D17    
Loop:
    SUB    X6,X6,1 
    CMP    X6,0
    B.lT   end 
    BL continue
end:
    FSUB    D22, D11, D9   
    FCMP    D22, D15       
    B.LT    Exit             
    MOV     X13, 0
    FMOV    D23, X13         
    FCMP    D4, D23          
    B.EQ    Exit
    FMUL    D24, D2, D4    
    FCMP    D24, D23       
    B.LT    else          
    FMOV    D9, D1         
    MOV     X6, X7          
    BL      calculate        
else:
    FMOV    D11, D1         
    MOV     X6, X7         
    BL      calculate
continue:
    FMUL   D2, D2, D9 
    FMUL   D3, D3, D11 
    FMUL   D4, D4, D1  
    MOV     X9,8
    MUL     X10, X6, X9  
    LDR     D17,[X3, X10]
    FADD   D2, D2, D17 
    FADD   D3, D3, D17 
    FADD   D4, D4, D17 
    BL     Loop
Exit:
    ADR     X0, root
    FMOV    D0, D1
    BL      printf
    MOV     X0,#0
    MOV     w8,#93
    SVC     #0

.data
coeff:
    .double 5.3, 0.0, 2.9, -3.1
N:
    .dword 3 
a:
    .double -1.0
b:
    .double 1.0
t:
    .double 0.01
root:
    .ascii "calculated root %lf\n\0"

