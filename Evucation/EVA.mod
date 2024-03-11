set I := 1..20;
set P := 1..2;
set N := 1..22; # Assuming this includes all departments and elevators
set E := 21..22; # Elevators

param d{P,P};
param c{I, I};
param A{N};
param lambda {I};
param mu {E};
param w_F := 38;
param h_F := 12;
param alpha := 1;
param e_jd{P, E};

var x {I, P} binary;
var y {I, E} binary;

#minimize obj_fun:
#    sum {i in I, j in I, k in P, l in P: i<j} c[i,j] * d[k,l] * x[i,k] * x[j,l];
    
# Combined objective function
minimize obj_fun:
    alpha * sum {i in I, j in I, k in P, l in P: i<j} c[i,j] * d[k,l] * x[i,k] * x[j,l] +
    1.5 * sum {i in I, j in P, d in E} lambda[i] * e_jd[j,d] * x[i,j] * y[i,d];

subject to c1 {i in I}:
    sum{k in P} x[i,k] = 1;
    
subject to c_4 {k in P}:
    sum{i in N} A[i] * x[i,k] <= w_F * h_F;
	
subject to assign_stairwell {i in I}:
	sum {e in E} y[i,e] = 1;
	
subject to stairwell_capacity {e in E}:
	sum {i in I} lambda[i] * y[i,e] <= mu[e];