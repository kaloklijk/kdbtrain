
\d .tr
\c 10000 10000
// functions:

basic:{
    [n]
    samples: a cut (2*(a: ceiling[n%2]))?1.0;
    Z0: cos[(theta: 2*(acos -1)*samples[1])] * R: sqrt[-2 * log[samples 0]];
     Z1: sin[theta] * R;
      : Z0, Z1
     }

polar: {[n]
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
// driver code
1 "functions: basic, polar\n-----------------------------------------------\n";
1 "basic: number of random number create\n";
1 "polar: number of random number create\n\n";
input:{-2 x; read0 0}
method: input"Choose a transform type: ";
-2 "\n", method, " transform:\n";
n: "J"$input"Number of random variables create: ";
-2 "Creating ", (string n), " random numbers:";
// output
.Q.trp[
  show ;
  n#get[`$method] n;
  {-2 x, .Q.sbt y}
  ]
-1 "\nexec time:";
\t n#get[`$method] n;
// .Q.fc[get[`$method]] samples
//exit 1

