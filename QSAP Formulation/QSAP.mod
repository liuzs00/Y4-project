set I := 1..20;
set J := 1..20;

set P := 1..2;
set N := 1..22; # Assuming this includes all departments and elevators
set E := 21..22; # Elevators

param D{P,P};
param C{I, I};
param A{N};

param w_F:=32;
param h_F:=12;

var z {N, P} binary;


minimize obj_fun:
    sum {i in I, j in I, k in P, l in P: i<j} C[i,j] * D[k,l] * z[i,k] * z[j,l];

subject to c1 {i in I}:
    sum{k in P} z[i,k] = 1;
    
#subject to c1_1 {i in E, k in P}:
#     z[i,k] = 1;

subject to c_4 {k in P}:
    sum{i in N} A[i] * z[i,k] +18 <= w_F * h_F;

# Ensure that the binary restriction on z is implicitly handled by its declaration






