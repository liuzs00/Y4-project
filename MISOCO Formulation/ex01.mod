set I := 1..20;
set P := 1..2;
set N := 1..22;
set E := 21..22;

param C{I, I};
param A{N};
param h{N};
param w{N};
param beta_wh := 2;
param beta_hw := 2;
param w_F:=38;
param h_F:=12;

var d_h{i in I, j in I};
var d_v{i in I, j in I};
var d_y{i in I,j in I};
var d_x{i in I,j in I};
var u_0{i in I, j in I};  
var u_1{i in I,n in E};
var u_2{i in I,n in E};
var v_1{i in I,n in E};
var v_2{i in I,n in E};
#var w{i in N} >=0;
#fix w[21] := 3;
#fix w[22] := 3;
#var h{i in N} >=0;
#fix h[21] := 3;
#fix h[22] := 3;
var X {i in N, j in N} binary;
var Y {i in N, j in N} binary;
var Z {i in N, j in N} binary;
var z {i in N, k in P} binary;
var x {i in N};
var y {i in N};

minimize obj_fun:
    sum{i in I, j in I: i < j } C[i, j] * (d_h[i, j] + d_v[i, j]);
    
subject to c7 {i in I}:
	sum{k in P} z[i,k] = 1;
subject to c8 {k in P, i in I, j in I:i<j}:
	Z[i,j]>= z[i,k] + z[j,k]-1;
subject to c9 { k in P, i in I, j in I:i<j}:
	Z[i,j]<= 1-z[i,k] + z[j,k];
subject to c10 { k in P, i in I, j in I:i<j}:
	Z[i,j]<= 1+z[i,k] - z[j,k];
	

subject to c11_1 {i in I, j in I: i < j}:
    d_v[i,j] = 4 * u_0[i,j];

subject to c11_2 {i in I, j in I: i < j}:
    u_0[i,j] >= z[i,1] - z[j,1] + 2 * (z[i,2] - z[j,2]);

subject to c11_3{i in I, j in I: i < j}:
    u_0[i,j] >= - (z[i,1] - z[j,1] + 2 * (z[i,2] - z[j,2]));




subject to c12_1 {i in I, j in I: i < j}:
    d_h[i,j]>= d_x[i,j] + d_y[i,j];
subject to c12_2 {i in I, j in I: i < j}:
    d_x[i,j] >= x[i] - x[j]; 
subject to c12_3 {i in I, j in I: i < j}:
    d_x[i,j] >= x[j] - x[i];
subject to c12_4 {i in I, j in I: i < j}:
    d_y[i,j] >= y[i] - y[j];
subject to c12_5 {i in I, j in I: i < j}:
    d_y[i,j] >= y[j] - y[i];


subject to c13_1 {l in E,i in I, j in I : i < j}:
    d_h[i,j] >= u_1[i,l] + v_1[i,l] + u_2[j,l] + v_2[j,l] - 2*(w_F+h_F)*Z[i,j];

subject to c13_2 {i in I, l in E}:
    u_1[i,l] >= x[i] - x[l];
subject to c13_3 {i in I, l in E}:
    u_1[i,l] >= x[l] - x[i];
subject to c13_4 {i in I, l in E}:    
    v_1[i,l] >= y[i] - y[l];
subject to c13_5 {i in I, l in E}:   
    v_1[i,l] >= y[l] - y[i];
subject to c13_6 {j in I, l in E}:
    u_2[j,l] >= x[j] - x[l];
subject to c13_7 {j in I, l in E}:
    u_2[j,l] >= x[l] - x[j];
subject to c13_8 {j in I, l in E}:    
    v_2[j,l] >= y[j] - y[l];
subject to c13_9 {j in I, l in E}:
    v_2[j,l] >= y[l] - y[j];

subject to c14_1 {i in N}:
	x[i]+0.5*w[i] <= 0.5*w_F;
subject to c14_2 {i in N}:
	x[i]-0.5*w[i] >= -0.5*w_F;

subject to c15_1 {i in N}:
	y[i]+0.5*h[i] <= 0.5*h_F;
subject to c15_2 {i in N}:
	y[i]-0.5*h[i] >= -0.5*h_F;


subject to c18 {i in N, j in N:i<j}:
	x[i]-x[j] >= 0.5*(w[i]+w[j])-w_F*(1-Z[i,j]+X[i,j]+Y[i,j]);
subject to c19 {i in N, j in N:i<j}:
	x[j]-x[i] >= 0.5*(w[i]+w[j])-w_F*(2-Z[i,j]-X[i,j]+Y[i,j]);
subject to c20 {i in N, j in N:i<j}:
	y[i]-y[j] >= 0.5*(h[i]+h[j])-h_F*(2-Z[i,j]+X[i,j]-Y[i,j]);
subject to c21 {i in N, j in N:i<j}:
	y[j]-y[i] >= 0.5*(h[i]+h[j])-h_F*(3-Z[i,j]-X[i,j]-Y[i,j]);

subject to c22 {k in P, i in E}:
	z[i,k]=1;

subject to c23 {i in N, j in E}:
	Z[i,j]=1;

#subject to c24 {i in I}:
#	w[i]*h[i] >= A[i];
#subject to c25 {i in I}:
#	w[i]-beta_wh*h[i] <= 0;
#subject to c26 {i in I}:
#	w[i]-beta_hw*h[i] <= 0;
	
	