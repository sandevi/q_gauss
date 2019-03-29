function [pval, ks, d] = ks2test (x, y, alt)

  if (nargin < 2 || nargin > 3)
    usage ("[pval, ks] = kolmogorov_smirnov_test_2 (x, y, tol)");
  endif

  if (! (isvector (x) && isvector (y)))
    error ("kolmogorov_smirnov_test_2: both x and y must be vectors");
  endif

  if (nargin == 2)
    alt = "!=";
  else
    if (! isstr (alt))
      error ("kolmogorov_smirnov_test_2: alt must be a string");
    endif
  endif

  n_x = length (x);
  n_y = length (y);
  n   = n_x * n_y / (n_x + n_y);
  x   = reshape (x, n_x, 1);
  y   = reshape (y, n_y, 1);
  [s, i] = sort ([x; y]);
  count (find (i <= n_x)) = 1 / n_x;
  count (find (i > n_x)) = - 1 / n_y;

  z = cumsum(count);
  if ( find(diff(s))) 
    ## There are some ties, so keep only those changes.
##    warning ("cannot compute correct p-values with ties")
    elems = [find(diff(s)); n_x + n_y];
    z = z(elems);
  endif
  
  if (strcmp (alt, "!=") || strcmp (alt, "<>"))
    d    = max (abs (z));
    ks   = sqrt (n) * d;
    pval = 1 - kolmogorov_smirnov_cdf (ks);
  elseif (strcmp (alt, ">"))
    d    = max (z);
    ks   = sqrt (n) * d;
    pval = exp (-2 * ks^2);
  elseif (strcmp (alt, "<"))
    d    = min (z);
    ks   = -sqrt (n) * d;
    pval = exp (-2 * ks^2);
  else
    error ("kolmogorov_smirnov_test_2: option %s not recognized", alt);
  endif

  if (nargout == 0)
    printf ("  pval: %g\n", pval);
  endif

endfunction
