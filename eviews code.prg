'AFTER ESTIMATING ARMA OF Y WITH LAG SELECTION BY AIC, WE PROCEED WITH THE FORECAST TO OBTAIN A BENCHMARK
pageselect quarterly
smpl @first 2008q2
y.sheet
y.autoarma(tform=none, maxar=5, maxma=5, forclen=18, agraph, atable, etable, fgraph, eqname=y_arma) y_f c

smpl 2008q4 2012q4
y_arma.forecast(n, e, g) ybenchmark1

smpl @all
show y ybenchmark1
smpl 2007q1 2012q4
plot y ybenchmark1

'WE REPEAT THE SAME PROCESS PRETENDING TO BE IN DECEMBER (HAVING q3)
pageselect quarterly
smpl @first 2008q3
y.sheet
y.autoarma(tform=none, maxar=5, maxma=5, forclen=17, agraph, atable, etable, fgraph, eqname=y_arma_dec) y_f c

smpl 2008q4 2012q4
y_arma_dec.forecast(n, e, g) ybenchmark2

smpl @all
show y ybenchmark2
smpl 2007q1 2012q4
plot y ybenchmark2

' IN OCTOBER (m10) WE HAVE INDICATORS UP TO SEPTEMBER (m9)
pageselect monthly
smpl @first 2008m9

' ESTIMATE ARMA(1,2) MODEL WITH ci
equation ci_arma12.ls(optmethod=opg) ci c ar(1) ma(1) ma(2)

'CONSIDER THE MISSING MONTHS AND MAKE A FORECAST
smpl 2008m10 2008m12
ci_arma12.forecast(n, e, g) ci1

'COMPARE THE FORECAST WITH THE ACTUAL DATA
smpl @first 2008m12
plot ci ci1

smpl 2007m1 2008m12
plot ci ci1
show ci ci1
smpl @all

'COPY INDICATORS TO THE "QUARTERLY" PAGE
pageselect quarterly
smpl @first 2008q4
copy monthly\ci1 *

' IN OCTOBER WE HAVE GDP DATA UP TO Q2
'ESTIMATE THE BRIDGE MODEL (WITH DATA AVAILABLE IN OCTOBER)
smpl @first 2008q2
equation ci_bm.ls y c ci1*3

'MAKE Q4 FORECAST WITH THE BM
smpl 2008q4 2008q4
ci_bm.fit(f=na, n, g) ybm_ci1

' ESTIMATE A MIDAS MODEL (EXPONENTIAL ALMON LAGS) [IN OCTOBER]
smpl 1985q1 2008q2
equation ci_midas1.midas(fixedlag=3, midwgt=expalmon, s=0) y c(1) @ monthly\ci(-3)

'MAKE Q4 FORECAST WITH THE MIDAS (EXPONENTIAL ALMON LAGS) [IN OCTOBER]
smpl 2008q4 2008q4
ci_midas1.fit(f=na, g) ymidas_ci1

' ESTIMATE A U-MIDAS (GETS LAGS) [IN OCTOBER]
smpl 1985q1 2008q2
equation ci_umgets1.midas(fixedlag=12, midwgt=autogets, s=0) y c(1) @ monthly\ci(-3)

'MAKE Q4 FORECAST WITH THE U-MIDAS (GETS LAGS) [IN OCTOBER]
smpl 2008q4 2008q4
ci_umgets1.fit(f=na, g) y_umgets_ci1

' IN NOVEMBER (m11) WE HAVE INDICATORS UP TO OCTOBER (m10)
pageselect monthly
smpl @first 2008m10

'ESTIMATE ARMA(1,2) MODEL WITH ci [IN NOVEMBER]
equation ci2_arma12.ls(optmethod=opg) ci c ar(1) ma(1) ma(2)

'CONSIDER THE MISSING MONTHS AND MAKE A FORECAST
smpl 2008m11 2008m12
ci2_arma12.forecast(n, e, g) ci2

'COMPARE THE FORECAST WITH THE ACTUAL DATA
smpl @first 2008m12
plot ci ci2

smpl 2007m1 2008m12
plot ci ci2
smpl @all

'COPY INDICATORS TO THE "QUARTERLY" PAGE
pageselect quarterly
smpl @first 2008q4
copy monthly\ci2 *

' IN NOVEMBER WE HAVE GDP DATA UP TO Q2
'ESTIMATE THE BRIDGE MODEL (WITH DATA AVAILABLE IN NOVEMBER)
smpl @first 2008q2
equation ci2_bm.ls y c ci2*3

'MAKE Q4 FORECAST WITH THE BM
smpl 2008q4 2008q4
ci2_bm.fit(f=na, n, g) ybm_ci2

'MAKE A BM USING GETS METHOD [IN NOVEMBER]
smpl @first 2008q2
equation bm_gets2.varsel(method=auto, stricttests) y c(1) @ ci2(-1 to -8)

'MAKE Q4 FORECAST WITH THE BM OBTAINED THROUGH GETS [IN NOVEMBER]
smpl 2008q4 2008q4
bm_gets2.fit(f=na, n, g) ybm_gets2

'ESTIMATE A MIDAS (EXPONENTIAL ALMON LAGS) [IN NOVEMBER]
smpl 1985q1 2008q2
equation ci_midas2.midas(fixedlag=3, midwgt=expalmon, s=0) y c(1) @ monthly\ci(-2)

'MAKE Q4 FORECAST WITH THE MIDAS (EXPONENTIAL ALMON LAGS) [IN NOVEMBER]
smpl 2008q4 2008q4
ci_midas2.fit(f=na, g) ymidas_ci2

'ESTIMATE A U-MIDAS (GETS LAGS) [IN NOVEMBER]
smpl 1985q1 2008q2
equation ci_umgets2.midas(fixedlag=12, midwgt=autogets, s=0) y c(1) @ monthly\ci(-2)

'MAKE Q4 FORECAST WITH THE U-MIDAS (GETS LAGS) [IN NOVEMBER]
smpl 2008q4 2008q4
ci_umgets2.fit(f=na, g) y_umgets_ci2

' IN DECEMBER (m12) WE HAVE INDICATORS UP TO NOVEMBER (m11)
pageselect monthly
smpl @first 2008m11

'ESTIMATE ARMA(1,2) MODEL WITH ci [IN DECEMBER]
equation ci3_arma12.ls(optmethod=opg) ci c ar(1) ma(1) ma(2)

'CONSIDER THE MISSING MONTHS AND MAKE A FORECAST
smpl 2008m12 2008m12
ci3_arma12.forecast(n, e, g) ci3

'COMPARE THE FORECAST WITH THE ACTUAL DATA
smpl @first 2008m12
plot ci ci3

smpl 2007m1 2008m12
plot ci ci3
smpl @all

'COPY INDICATORS TO THE "QUARTERLY" PAGE
pageselect quarterly
smpl @first 2008q4
copy monthly\ci3 *

'IN DECEMBER WE HAVE GDP DATA UP TO Q3
'ESTIMATE THE BRIDGE MODEL (WITH DATA AVAILABLE IN DECEMBER)
smpl @first 2008q3
equation ci3_bm.ls y c ci3*3

'MAKE Q4 FORECAST WITH THE BM
smpl 2008q4 2008q4
ci3_bm.fit(f=na, n, g) ybm_ci3
show y ybm_ci1 ybm_ci2 ybm_ci3

'ESTIMATE A MIDAS (EXPONENTIAL ALMON LAGS) [IN DECEMBER]
smpl 1985q1 2008q3
equation ci_midas3.midas(fixedlag=3, midwgt=expalmon, s=0) y c(1) @ monthly\ci(-1)

'MAKE Q4 FORECAST WITH THE MIDAS (EXPONENTIAL ALMON LAGS) [IN DECEMBER]
smpl 2008q4 2008q4
ci_midas3.fit(f=na, g) ymidas_ci3
show y ymidas_ci1 ymidas_ci2 ymidas_ci3

'ESTIMATE A U-MIDAS (GETS LAGS) [IN DECEMBER]
smpl 1985q1 2008q3
equation ci_umgets3.midas(fixedlag=12, midwgt=autogets, s=0) y c
