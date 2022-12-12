

d) module
 kaloklijk
 kaloklijk to set up a kaloklijk library. 
 q).import.module`kaloklijk
// functions:

.kaloklijk.basic:{
    [n]
    samples: a cut (2*(a: ceiling[n%2]))?1.0;
    Z0: cos[(theta: 2*(acos -1)*samples[1])] * R: sqrt[-2 * log[samples 0]];
     Z1: sin[theta] * R;
      : Z0, Z1
     }


d) function
 kaloklijk
 .kaloklijk.basic
 generate random normal distributed numbers using basic method
 q) .kaloklijk.basic 10

.kaloklijk.polar: {[n]
    samples: -1+ a cut (2*(a:ceiling[n%2]))?2.0;
    u: samples[0];
    v: samples[1];
    s: (u*u)+v*v;
    ind: where (s>=1) or s=0;
    while[0<>count ind;
    s[ind]: (u[ind]*(u[ind]: -1+count[ind]?2.0))+v[ind]*(v[ind]: -1+count[ind]?2.0);
    ind: ind[where (s[ind] >= 1) or s[ind]=0];
    ];
    z0: -2* u*sq: sqrt -2*log[s]%s;
    z1: -2 * v*sq;
    z0, z1
  }

d) function
 kaloklijk
 .kaloklijk.polar
 generate random normal distributed numbers using polar method
 q) .kaloklijk.polar 10
 
 .kaloklijk.Wiener: {[t]
    Z:: .kaloklijk.polar ct: -1+count t;
    ti:: sqrt sums dt: 1_ t - prev t;
    W:: enlist 0f;
    c:: -1;
    ct { W ,: (Z[c] * ti[c+:: 1]) + last W }/1; // the 1 in the end is useless
    W
  }

d) function
 kaloklijk
 .kaloklijk.Wiener
 generate paths with Wiener process
 q) .kaloklijk.Wiener 0.01*til 101

.kaloklijk.discretSDE: {[X0;t;a;b]
                dW:: 1_ W - prev W: .kaloklijk.Wiener t;
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

d) function
 kaloklijk
 .kaloklijk.discretSDE
 generate random paths with Euler discretization of SDE
 q) .kaloklijk.discretSDE[100; 0.01*til 101; 0; 1]

.kaloklijk.paths:{[n;X0;t;a;b]
    files: `$' f:"result",/: (string') til n;
    dir: `$' f,\: ".csv";
    files set' discretSDE[X0;t;a;] each n#b;
    (save') dir;
    }

d) function
 kaloklijk
 .kaloklijk.paths
 generate n random paths with discretSDE and save it local-dir
 q).kaloklijk.paths[100;100; 0.01*til 101; 0; 1]

.kaloklijk.validator:{[n;X0]
    files: `$' "result",/: ((string') til n);
    tabs: (get') files;
    (0.15*n)<count select from @[tabs; ::; avg ] where (y<(X0-10)) or y>X0+10
     }

d) function
 kaloklijk
 .kaloklijk.validator
 validate that the average values of the paths - X0 > 10 or < 10 is not larger than 15% of the path generated
 q) .kaloklijk.validator[100;100]
