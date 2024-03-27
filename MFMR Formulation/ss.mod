set I;
set J;
set N :=1..22;
set E:=21..22;
set P:=1..2;
set L1 := I union E;
set L2 := J union E;
set M  := I union J;

param C{N, N};
param d1:= 4;
param d2:= 4;
param m1 := 3;
param m2 := 3;

param L:=38;
param Z{N,N};
param z{N,P};
param A{N};
param w{N};

var a1{i in L1, j in L1} binary;
var b1{i in L1, j in L1} binary;
var a2{i in L2, j in L2} binary;
var b2{i in L2, j in L2} binary;

var d_y{i in M, j in M};
var d_x{i in M, j in M};

var d_h{i in M, j in M};
var d_v{i in M, j in M};

var u_0{i in M, j in M};  
var u_1{i in I, l in E};
var u_2{i in J, l in E};
var v_1{i in I, l in E};
var v_2{i in J, l in E};

var x1 {L1};
var y1 {L1};
var x2 {L2};
var y2 {L2};
#var w  {N};
#fix w[21] := 3;
#fix w[22] := 3;


minimize obj_fun:
		sum{i in I, j in I: i < j } C[i, j] * (d_x[i, j] + d_y[i, j])
		+sum{i in J, j in J: i < j } C[i, j] * (d_x[i, j] + d_y[i, j])
		+sum{i in I, j in J: i < j } C[i, j] * (d_h[i, j] + d_v[i, j]);    


subject to F12_1 {i in I, j in I: i < j}:
    d_h[i,j]>= d_x[i,j] + d_y[i,j];
subject to F12_2 {i in I, j in I: i < j}:
    d_x[i,j] >= x1[i] - x1[j]; 
subject to F12_3 {i in I, j in I: i < j}:
    d_x[i,j] >= x1[j] - x1[i];
subject to F12_4 {i in I, j in I: i < j}:
    d_y[i,j] >= y1[i] - y1[j];
subject to F12_5 {i in I, j in I: i < j}:
    d_y[i,j] >= y1[j] - y1[i];
    
    
subject to S12_1 {i in J, j in J: i < j}:
    d_h[i,j]>= d_x[i,j] + d_y[i,j];
subject to S12_2 {i in J, j in J: i < j}:
    d_x[i,j] >= x2[i] - x2[j]; 
subject to S12_3 {i in J, j in J: i < j}:
    d_x[i,j] >= x2[j] - x2[i];
subject to S12_4 {i in J, j in J: i < j}:
    d_y[i,j] >= y2[i] - y2[j];
subject to S12_5 {i in J, j in J: i < j}:
    d_y[i,j] >= y2[j] - y2[i];

subject to c11_1 {i in M, j in M: i < j}:
    d_v[i,j] = 4 * u_0[i,j];
subject to c11_2 {i in M, j in M: i < j}:
    u_0[i,j] >= z[i,1] - z[j,1] + 2 * (z[i,2] - z[j,2]);
subject to c11_3{i in M, j in M: i < j}:
    u_0[i,j] >= - (z[i,1] - z[j,1] + 2 * (z[i,2] - z[j,2]));



subject to c13_1 {l in E, i in I, j in J: i<j}:
    d_h[i,j] >= u_1[i,l] + v_1[i,l] + u_2[j,l] + v_2[j,l];
subject to c13_2 {i in I, l in E}:
    u_1[i,l] >= x1[i] - x1[l];
subject to c13_3 {i in I, l in E}:
    u_1[i,l] >= x1[l] - x1[i];
subject to c13_4 {i in I, l in E}:    
    v_1[i,l] >= y1[i] - y1[l];
subject to c13_5 {i in I, l in E}:   
    v_1[i,l] >= y1[l] - y1[i];
subject to c13_6 {j in J, l in E}:
    u_2[j,l] >= x2[j] - x2[l];
subject to c13_7 {j in J, l in E}:
    u_2[j,l] >= x2[l] - x2[j];
subject to c13_8 {j in J, l in E}:    
    v_2[j,l] >= y2[j] - y2[l];
subject to c13_9 {j in J, l in E}:
    v_2[j,l] >= y2[l] - y2[j];



subject to F_c39 {i in L1, j in L1: i<j}:
	x1[j]-x1[i] >= 1/2*(w[i]+w[j])-L*(1-a1[i,j]);
subject to F_c40 {i in L1, j in L1: i<j}:
	x1[i]-x1[j] >= 1/2*(w[i]+w[j])-L*(1-a1[j,i]);
subject to F_c41 {i in L1, j in L1: i<j}:
	y1[j]-y1[i] >= d1-m1*d1*(1-b1[i,j]);
subject to F_c42 {i in L1, j in L1: i<j}:
	y1[i]-y1[j] >= d1-m1*d1*(1-b1[j,i]);
subject to F_c43 {i in L1, j in L1: i<j}:
	y1[i]-y1[j] <= (1-a1[i,j]-a1[j,i])*(m1-1)*d1;
subject to F_c44 {i in L1, j in L1: i<j}:
	y1[j]-y1[i] <= (1-a1[i,j]-a1[j,i])*(m1-1)*d1;
subject to F_c45 {i in L1}:
	0<=y1[i]<=(m1-1)*d1;
subject to F_c46 {i in L1}:
	1/2*w[i]<=x1[i]<=L-1/2*w[i];
subject to F_c47 {i in L1, j in L1: i<j}:
	a1[i,j]+a1[j,i]+b1[i,j]+b1[j,i]=1;
subject to F_c48 {(i,j,k) in L1 cross L1 cross L1: i<j and k != i and k != j}:
    a1[i,j] + a1[j,k] <= 1 + a1[i,k];
subject to F_c49 {(i,j,k) in L1 cross L1 cross L1: i <j and k != i and k != j }:
    b1[i,j] + b1[j,k] <= 1 + b1[i,k];
    

subject to S_c39 {i in L2, j in L2: i<j}:
	x2[j]-x2[i] >= 1/2*(w[i]+w[j])-L*(1-a2[i,j]);
subject to S_c40 {i in L2, j in L2: i<j}:
	x2[i]-x2[j] >= 1/2*(w[i]+w[j])-L*(1-a2[j,i]);
subject to S_c41 {i in L2, j in L2: i<j}:
	y2[j]-y2[i] >= d2-m2*d2*(1-b2[i,j]);
subject to S_c42 {i in L2, j in L2: i<j}:
	y2[i]-y2[j] >= d2-m2*d2*(1-b2[j,i]);
subject to S_c43 {i in L2, j in L2: i<j}:
	y2[i]-y2[j] <= (1-a2[i,j]-a2[j,i])*(m2-1)*d2;
subject to S_c44 {i in L2, j in L2: i<j}:
	y2[j]-y2[i] <= (1-a2[i,j]-a2[j,i])*(m2-1)*d2;
subject to S_c45 {i in L2}:
	0<=y2[i]<=(m2-1)*d2;
subject to S_c46 {i in L2}:
	1/2*w[i]<=x2[i]<=L-1/2*w[i];
subject to S_c47 {i in L2, j in L2: i<j}:
	a2[i,j]+a2[j,i]+b2[i,j]+b2[j,i]=1;
subject to S_c48 {(i,j,k) in L2 cross L2 cross L2: i<j and k != i and k != j}:
    a2[i,j] + a2[j,k] <= 1 + a2[i,k];
subject to S_c49 {(i,j,k) in L2 cross L2 cross L2: i <j and k != i and k != j }:
    b2[i,j] + b2[j,k] <= 1 + b2[i,k];
    
    
subject to E1 {i in E}:
	x1[i]=x2[i];
subject to E2 {i in E}:
	y1[i]=y2[i];
	
	
#subject to A1 {i in L1}:
#     w[i]* d1 <= A[i]
    
#subject to A2 {i in L2}:
#     w[i]* d2 <= A[i]
     
    