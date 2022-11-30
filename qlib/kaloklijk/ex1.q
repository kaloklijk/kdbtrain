args:.Q.def[`name`port!("ex1.q";9082);].Q.opt .z.x

/ remove this line when using in production
/ ex1.q:localhost:9082::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9082"; } @[hopen;`:localhost:9082;0];

\c 10000 10000
\l qlib.q


.import.module`kaloklijk


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
  n# .kaloklijk[`$method] n;
  {-2 x, .Q.sbt y}
  ]
-1 "\nexec time:";
\t n# .kaloklijk[`$method] n;
// .Q.fc[get[`$method]] samples
//exit 1

