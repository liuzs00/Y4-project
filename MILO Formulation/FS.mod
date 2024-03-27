set I := 1..20;
set P := 1..2;
set N := 1..22;
set E := 21..22;

param D{P,P};
param C{I, I};
param A{N};
param h{N};
param w{N};
param w_F:=32;
param h_F:=12;

var d_v{i in I, j in I};
var u_0{i in I, j in I};  
var z {N, P} binary;

  
minimize obj_fun:
    sum{i in I, j in I: i < j } C[i, j] * (d_v[i, j]);
    
subject to c1 {i in I}:
	sum{k in P} z[i,k] = 1;
	
subject to c1_1 {i in E, l in P}:
	 z[i,l]=1;
	
subject to c2_1 {(i,j) in I cross I: i < j}:
    d_v[i,j] = 4 * u_0[i,j];
subject to c2_2 {(i,j) in I cross I: i < j}:
    u_0[i,j] >= z[i,1] - z[j,1] + 2 * (z[i,2] - z[j,2]);
subject to c2_3{(i,j) in I cross I: i < j}:
    u_0[i,j] >= - (z[i,1] - z[j,1] + 2 * (z[i,2] - z[j,2]));

subject to c_4  {k in P}:
	sum{i in N} A[i]*z[i,k] <= w_F*h_F;


