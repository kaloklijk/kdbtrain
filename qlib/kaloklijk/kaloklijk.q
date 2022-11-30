

d) module
 kaloklijk
 kaloklijk to set up a kaloklijk library. 
 q).import.module`kaloklijk
// functions:

.kaloklijk.basic:{
    [n]
    samples: $[mod[n;2]=1;("i"$((n+1)%2)) cut (n+1)?1.0;("i"$(n%2)) cut n?1.0];
    Z0: cos[(theta: 2*3.14159265*samples[1])] * R: sqrt[-2 * log[samples[0]]];
     Z1: sin[theta] * R;
      : Z0, Z1
     }

d) function
 kaloklijk
 .kaloklijk.basic
 generate random normal distributed numbers using basic method
 q) .kaloklijk.basic 10

.kaloklijk.polar: {[n]
    $[mod[n;2]=1; samples: ("i"$((n+1)%2)) cut ((((n+1)?1.0)*2)-1); samples: ("i"$(n%2)) cut (((n?1.0)*2)-1)];
    u: samples[0];
    v: samples[1];
    s: (u*u)+v*v;
    
    z0: u*sqrt[(t:-2 * log[s]%s)];
    z1: v*sqrt[t];
    : z0, z1
  }


d) function
 kaloklijk
 .kaloklijk.polar
 generate random normal distributed numbers using polar method
 q) .kaloklijk.polar 10