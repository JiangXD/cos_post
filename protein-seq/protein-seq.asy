settings.tex="xelatex";

path myp=(-10,-8){right}..(0,-13){down}..(5,-40){right}::(10,-15){right}..(13,-42){down}..(26,-46){right};

//draw(myp);

string myseq="MVEAILRSTLGARTTVMAALSYLSVLCFVPLLVDRDDEFVYFHAKQGLVIWMWGVLALFALHVPVLGKWIFGFSSMGVLVFSLLGLVSVVFQRAWKLPVVSWVADRI";
int mystrlen=length(myseq);
real mylen=arclength(myp);
real myD=mylen/mystrlen;
real myt=0;
bool out=true;
bool km=false;
pen myfp=black;

for(int i=0;i<mystrlen;++i)
{
  int myi=i+1;
  if(myi>=15 && myi<=34 || myi>=47 && myi<=65 || myi>=69 && myi<=91)
  {
    myfp=red;
    km=true;
  }
  else
  {
    if(km)
      out=!out;
    myfp=out?black:heavygreen;
    km=false;
  }
 
  real t=arctime(myp,myt);
  filldraw(shift(point(myp,t))*scale(myD/2.0)*unitcircle, drawpen=black+0.02, fillpen=myfp); 
  label(scale(0.07)*baseline(substr(myseq,i,1)), point(myp,t), white+font("OT1","phv","m","n"));
  myt+=myD;
}
