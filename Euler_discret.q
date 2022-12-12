\l qlib.q
\l transform.q
.import.module `rlang
@[system; "p 5000"; {-2 x;}]
// Wiener function
Wiener: {[t]
	Z:: .tr.polar ct: -1+count t;
	ti:: sqrt sums dt: 1_ t - prev t;
	W:: enlist 0f;
	c:: -1;
	ct { W ,: (Z[c] * ti[c+:: 1]) + last W }/1; // the 1 in the end is useless
	W
  }
 // SDE with euler discretization
discretSDE: {[X0;t;a;b]
  				dW:: 1_ W - prev W: Wiener t;
  				ct: -1+count t;
  				yj:: enlist "f"$X0;
  				dt:: 1_t-prev t;
  				j :: -1;
  				ai:: a;
  				bi:: b;
  				ct {
  					 // check a, b is a function 
  					// ajj: $[100h = type a;a[y j;t j];a];
  					// bjj: $[100h = type b;b[y j;t j];b];
  					yj ,: (ai* dt j)+ (bi* dW  j+::1) +last yj ;
  					}/1;
  				

  					([]t: t; y: yj)
  	}  	
//Wiener 0, 0.01*1+til 100

paths:{[n;X0;t;a;b]
	files: `$' f: "result",/: (string') til n;
	dir: `$' f,\: ".csv";
	files set' discretSDE[X0;t;a;] each n#b;
	(save') dir;
 }

validator:{[n;X0]
	files: `$' "result",/: ((string') til n);
	tabs: (get') files;
	(0.15*n)<count select from @[tabs; ::; avg ] where (y<(X0-10)) or y>X0+10
 }


paths[100;100;0.01*til 101; 0; 1]
