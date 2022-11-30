
\d .tr
\c 10000 10000
// functions:

basic:{
    [n]
    samples: $[mod[n;2]=1;ceiling((n+1)%2) cut (n+1)?1.0;"J"$(n%2) cut n?1.0];
    Z0: cos[(theta: 2*(acos -1)*samples[1])] * R: sqrt[-2 * log[samples 0]];
     Z1: sin[theta] * R;
      : Z0, Z1
     }

polar: {[n]
    $[mod[n;2]=1; samples: ("i"$((n+1)%2)) cut ((((n+1)?1.0)*2)-1); samples: ("i"$(n%2)) cut (((n?1.0)*2)-1)];
    u: samples[0];
    v: samples[1];
    s: (u*u)+v*v;
    
    z0: u*sqrt[(t:-2 * log[s]%s)];
    z1: v*sqrt[t];
    : z0, z1
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

