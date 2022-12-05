

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
