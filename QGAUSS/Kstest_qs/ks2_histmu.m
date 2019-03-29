
## Author: sandh <sandh@DESKTOP-J16R45C>
## Created: 2017-06-10

function [xd hd hm xdp hdp hmp] = ks2_histmu(lrx, q, bet, muq, sig1, n , fac0)


       clear xd; clear hd; clear hm;
       clear xdp; clear hdp; clear hmp ;
 

##      printf(" delay q bet  sig %d %f %f %f\n", delay, q, bet, sig)  ;


      [qrnd momr] = q_genmu(n, q, bet, muq, sig1) ;

      
      [hsd xsd nb dx] = mycdf(lrx, fac0,0)  ;

      clear xsd; clear hsd; clear hsm;
      [hsd xsd] = hist(lrx, nb) ;

      [hsm] = hist(qrnd,xsd) ;

      clear xsdn;  clear hsdn ; clear hsmn;  clear idxn;
      idxn = (xsd <=0);
      xsdn = xsd(idxn); 
      hsdn = hsd(idxn) ;
      hsmn = hsm(idxn) ;
      nn = length(xsdn);
      
      clear xd; clear hd; clear hm;
      
      xd = xsdn;
      hd = hsdn/sum(hsd) ;
      hm = hsmn / sum(hsm)  ;

##  Positive side histogramd

     clear xsdp;  clear hsdp ; clear hsmp;  clear idxp;
      idxp = (xsd >0);
      xsdp = xsd(idxp); 
      hsdp = hsd(idxp) ;
      hsmp = hsm(idxp) ;
      np = length(xsdp);

      clear xdp; clear hdp; clear hmp; 
      xdp = xsdp;
      hdp = hsdp/sum(hsd) ;
      hmp = hsmp / sum(hsm)  ;

endfunction
