clear

*Open Airbnb Dublin dataset*
import excel "/Users/rishiahuja/Documents/Trinity /Dissertation/Data/Dublin_Data_Final.xls", sheet("final") firstrow clear
save Dataset_RA.dta, replace

*Replace blank with 0 for y, n, mi, and nr*
replace y = 0 if (y >= .)
replace n = 0 if (n >= .)
replace mi = 0 if (mi >= .)
replace nr = 0 if (nr >= .)

*Create variable indicating same-sex couples*
generate lg = 1
replace lg = 0 if treatment ==2
replace lg = 0 if treatment ==4

*Create variable indicating same-sex male couple
generate g = 1
replace g = 0 if treatment ==2
replace g = 0 if treatment ==3
replace g = 0 if treatment ==4

*Create variable indicating same-sex female couple
generate l = 1
replace l = 0 if treatment ==1
replace l = 0 if treatment ==2
replace l = 0 if treatment ==4

*Create natural log of prices
generate lnp = ln(price)

*Drop unnecesary lines
drop in 795/797

****************************************

*Regression 1* (Direct impact of same-sex couple on outcome variables)

probit y lg
*Psuedo R2 = .0120
*LG = -.324 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = -.125 (P= 0.000)

probit y lg, robust
*Psuedo R2 = .0120
*LG = -.324 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = -.125 (P= 0.000)

logit y lg
*Psuedo R2 = .0120
*LG = -.519 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = -.125 (P= 0.000)

logit y lg, robust
*Psuedo R2 = .0120
*LG = -.519 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = -.125 (P= 0.000)

*------------*

probit n lg
*Psuedo R2 = .000
*LG = .051 (P = 0.627)
margins, dydx (*) predict (pr)
*LG = .013 (P= 0.627)

probit n lg, robust
*Psuedo R2 = .000
*LG = .051 (P = 0.627)
margins, dydx (*) predict (pr)
*LG = .013 (P= 0.627)

logit n lg
*Psuedo R2 = .000
*LG = .092 (P = 0.627)
margins, dydx (*) predict (pr)
*LG = .013 (P= 0.627)

logit n lg, robust
*Psuedo R2 = .000
*LG = .092 (P = 0.628)
margins, dydx (*) predict (pr)
*LG = .013 (P= 0.627)

*------------*

probit mi lg
*Psuedo R2 = .002
*LG = -.110 (P = 0.332)
margins, dydx (*) predict (pr)
*LG = -.023 (P= 0.332)

probit mi lg, robust
*Psuedo R2 = .002
*LG = -.110 (P = 0.333)
margins, dydx (*) predict (pr)
*LG = -.023 (P= 0.332)

logit mi lg
*Psuedo R2 = .002
*LG = -.206 (P = 0.332)
margins, dydx (*) predict (pr)
*LG = -.023 (P= 0.333)

logit mi lg, robust
*Psuedo R2 = .002
*LG = -.206 (P = 0.333)
margins, dydx (*) predict (pr)
*LG = -.023 (P= 0.333)

*------------*

*Majority of the discrimination is occuring in nr versus mi and n

probit nr lg
*Psuedo R2 = .021
*LG = .421 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = .136 (P= 0.000)

probit nr lg, robust
*Psuedo R2 = .021
*LG = .421 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = .136 (P= 0.000)

logit nr lg
*Psuedo R2 = .021
*LG = .712 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = .137 (P= 0.000)

logit nr lg, robust
*Psuedo R2 = .021
*LG = .712 (P = 0.000)
margins, dydx (*) predict (pr)
*LG = .137 (P= 0.000)

*------------*

*Examining Male/Male versus Female/Female relationships (FINAL INCLUSION IN PAPER)

probit y g,robust
*Psuedo R2 = .028
*G = -.550 (P = 0.000)
margins, dydx (*) predict (pr) post
*G = -.209 (P= 0.000)

probit y l,robust
*Psuedo R2 = .003
*L = .190 (P = 0.079)
margins, dydx (*) predict (pr) post
*L = .074 (P= 0.077)

probit y g l,robust
*Psuedo R2 = .028
*G = -.556 (P = 0.000)
*L = -.019 (P = 0.868)
margins, dydx (*) predict (pr) post
*G = -.556 (0.000)
*L = -.007 (P = 0.868)

*****************************************

*Regression 2* (Harvard Regression besides Race of Host)

probit y lg male multiplelist shared rev lnp 
*Psuedo R2 = .0362
*LG = -.325 (P = 0.001)
margins, dydx (*) predict (pr) post
*LG = -.123 (P = 0.000)
*Male = .096 (P = 0.007)
*MultipleList = .108 (P = 0.003)
*Shared = -.134 (P = .009) 
*Rev = .021 (P = .565)
*Price = -.122 (P = .005)

probit y lg male multiplelist shared rev lnp, robust 
*Psuedo R2 = .0361
*LG = -.325 (P = 0.001)
margins, dydx (*) predict (pr) post
*LG = -.123 (P= 0.000)
*Male = .096 (P = 0.007)
*MultipleList = .108 (P = 0.003)
*Shared = -.134 (P = .009) 
*Rev = .021 (P = .565)
*Price = -.122 (P = .006)

logit y lg male multiplelist shared rev lnp 
*Psuedo R2 = .0361
*LG = -.522 (P = 0.001)
margins, dydx (*) predict (pr) post
*LG = -.122 (P= 0.000)
*Male = .096 (P = 0.006)
*MultipleList = .107 (P = 0.004)
*Shared = -.135 (P = .009) 
*Rev = .021 (P = .565)
*Price = -.124 (P = .004)

logit y lg male multiplelist shared rev lnp, robust 
*Psuedo R2 = .0361
*LG = -.522 (P = 0.001)
margins, dydx (*) predict (pr) post 
*LG = -.122 (P= 0.000)
*Male = .096 (P = 0.007)
*MultipleList = .107 (P = 0.004)
*Shared = -.135 (P = .009) 
*Rev = .021 (P = .565)
*Price = -.124 (P = .005)

*Separation of Male/Male and Female/Female (FINAL INCLUSION IN PAPER)

probit y g l male multiplelist shared rev lnp, robust 
*Psuedo R2 = .054
*G = -.578 (P = 0.000)
*L = -.006 (P = 0.959)
margins, dydx (*) predict (pr) post
*G = -.214 (P= 0.000)
*L = -.002 (P = 0.959)
*Male = .094 (P = 0.007)
*MultipleList = .107 (P = 0.003)
*Shared = -.145 (P = .004) 
*Rev = .014 (P = .683)
*Price = -.137 (P = .001)

*Robustness Check: Probit and Logit Model for No instead of Yes* - n drops from 794 to 743

probit n lg male multiplelist shared rev lnp 
*Psuedo R2 = .020
*LG = .019 (P = 0.863)
margins, dydx (*) predict (pr) post
*LG = .005 (P = 0.863)
*Male = -.087 (P = 0.002)
*MultipleList = -.029 (P = 0.322)
*Shared = .057 (P = .162) 
*Rev = -.014 (P = .622)
*Price = .037 (P = .271)

probit n lg male multiplelist shared rev lnp, robust 
*Psuedo R2 = .020
*LG = .019 (P = 0.862)
margins, dydx (*) predict (pr) post
*LG = .005 (P= 0.862)
*Male = -.087 (P = 0.002)
*MultipleList = -.029 (P = 0.318)
*Shared = .057 (P = .135) 
*Rev = -.014 (P = .622)
*Price = .037 (P = .245)

logit n lg male multiplelist shared rev lnp 
*Psuedo R2 = .020
*LG = .038 (P = 0.848)
margins, dydx (*) predict (pr) post 
*LG = .005 (P= 0.848)
*Male = -.088 (P = 0.002)
*MultipleList = -.029 (P = 0.331)
*Shared = .056 (P = .166) 
*Rev = -.012 (P = .660)
*Price = .035 (P = .293)

logit n lg male multiplelist shared rev lnp, robust 
*Psuedo R2 = .020
*LG = .038 (P = 0.846)
margins, dydx (*) predict (pr) post
*LG = .005 (P= 0.846)
*Male = -.088 (P = 0.002)
*MultipleList = -.029 (P = 0.328)
*Shared = .056 (P = .129) 
*Rev = -.012 (P = .661)
*Price = .035 (P = .258)

*Robustness Check: Probit and Logit Model for Nr instead of Yes* - n drops from 794 to 743 

probit nr lg male multiplelist shared rev lnp 
*Psuedo R2 = .038
*LG = .460 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = .146 (P = 0.000)
*Male = -.001 (P = 0.974)
*MultipleList = -.116 (P = 0.001)
*Shared = .009 (P = .839) 
*Rev = -.037 (P = .242)
*Price = .005 (P = .892)

probit nr lg male multiplelist shared rev lnp, robust 
*Psuedo R2 = .038
*LG = .460 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = .146 (P= 0.000)
*Male = -.001 (P = 0.974)
*MultipleList = -.116 (P = 0.001)
*Shared = .009 (P = .838) 
*Rev = -.037 (P = .242)
*Price = .005 (P = .889)

logit nr lg male multiplelist shared rev lnp 
*Psuedo R2 = .039
*LG = .790 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = .148 (P= 0.000)
*Male = -.001 (P = 0.966)
*MultipleList = -.121 (P = 0.001)
*Shared = .012 (P = .815) 
*Rev = -.037 (P = .247)
*Price = .006 (P = .885)

logit nr lg male multiplelist shared rev lnp, robust 
*Psuedo R2 = .039
*LG = .790 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = .148 (P= 0.000)
*Male = -.001 (P = 0.966)
*MultipleList = -.121 (P = 0.001)
*Shared = .011 (P = .815) 
*Rev = -.037 (P = .246)
*Price = .006 (P = .881)


**************************************

*Regression 3* (Are effects driven by host characteristics)?

*Create interaction terms*
generate sharedint = lg*shared
generate multiplelistint = lg*multiplelist
generate revint = lg*rev

generate sharedg = g*shared
generate multiplelistg = g*multiplelist
generate revg = g*rev
generate maleg = g*male

generate sharedl = l*shared
generate multiplelistl = l*multiplelist
generate revl = l*rev
generate malel = l*male


probit y lg shared sharedint
*Psuedo R2 = .0124
*LG = -.325 (P = 0.015)
margins, dydx (*) predict (pr) post
*LG = -.126 (P= 0.013)
*Shared = -.023 (P= 0.651)
*SharedInt = .001 (P.990)

probit y lg shared sharedint, robust
*Psuedo R2 = .0124
*LG = -.325 (P = 0.015)
margins, dydx (*) predict (pr) post
*LG = -.126 (P= 0.014)
*Shared = -.023 (P= 0.651)
*SharedInt = .001 (P= 0.990)

logit y lg shared sharedint
*Psuedo R2 = .0124
*LG = -.520 (P = 0.015)
margins, dydx (*) predict (pr) post
*LG = -.125 (P= 0.013)
*Shared = -.023 (P= 0.651)
*SharedInt = .001 (P.994)

logit y lg shared sharedint, robust
*Psuedo R2 = .0124
*LG = -.520 (P = 0.015)
margins, dydx (*) predict (pr) post
*LG = -.125 (P= 0.013)
*Shared = -.023 (P= 0.651)
*SharedInt = .001 (P= 0.994)

*Separate Male/Male and Female/Female (FINAL INCLUSION IN PAPER)

probit y g l shared sharedg sharedl, robust
*Psuedo R2 = .030
*G = -.662 (P = 0.000)
*L = .107 (P = 0.532)
margins, dydx (*) predict (pr) post
*G = -.251 (P= 0.000)
*L = .041 (P = 0.532)
*Shared = -.022 (P = 0.651)
*SharedG = .072 (P = 0.374)
*SharedL = -.087 (P = 0.319) 

**************************************

probit y lg multiplelist multiplelistint
*Psuedo R2 = .023
*LG = -.440 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = -.168 (P= 0.000)
*Multiple = .060 (P= 0.266)
*MultipleInt = .106 (P= 0.148)

probit y lg multiplelist multiplelistint, robust
*Psuedo R2 = .023
*LG = -.440 (P = 0.000)
*LG = -.168 (P= 0.000)
*Shared = .060 (P= 0.267)
*SharedInt = .106 (P= 0.148)

logit y lg multiplelist multiplelistint
*Psuedo R2 = .023
*LG = -.711 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = -.169 (P= 0.000)
*Multiple = .059 (P= 0.266)
*MultipleInt = .107 (P= 0.142)

logit y lg multiplelist multiplelistint, robust
*Psuedo R2 = .023
*LG = -.711 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = -.169 (P= 0.000)
*Shared = .059 (P= 0.267)
*SharedInt = .107 (P= 0.142)

*Separate Male/Male and Female/Female (FINAL INCLUSION IN PAPER)

probit y g l multiplelist multiplelistg multiplelistl, robust
*Psuedo R2 = .041
*G = -.726 (P = 0.000)
*L = -.082 (P = 0.567)
margins, dydx (*) predict (pr) post
*G = -.273 (P = 0.000)
*L = -.031 (P = 0.567)
*MultipleList = .058 (P= 0.267)
*MultipleListG = .150 (P= 0.075)
*MultipleListL = .053 (P= 0.561)

**************************************

probit y lg rev revint
*Psuedo R2 = .014
*LG = -.297 (P = 0.022)
margins, dydx (*) predict (pr) post
*LG = -.115 (P= 0.021)
*Rev = .055 (P= 0.272)
*RevInt = -.016 (P= 0.814)

probit y lg rev revint, robust
*Psuedo R2 = .014
*LG = -.297 (P = 0.023)
margins, dydx (*) predict (pr) post
*LG = -.115 (P= 0.021)
*Rev = .055 (P= 0.272)
*RevInt = -.016 (P= 0.814)

logit y lg rev revint
*Psuedo R2 = .014
*LG = -.478 (P = 0.023)
margins, dydx (*) predict (pr) post
*LG = -.115 (P= 0.021)
*Rev = .055 (P= 0.272)
*RevInt = -.016 (P= 0.822)

logit y lg rev revint, robust
*Psuedo R2 = .014
*LG = -.478 (P = 0.023)
margins, dydx (*) predict (pr) post
*LG = -.115 (P= 0.021)
*Rev = .055 (P= 0.272)
*RevInt = -.016 (P= 0.822)

*Separate Male/Male and Female/Female (FINAL INCLUSION IN PAPER)

probit y g l rev revg revl, robust
*Psuedo R2 = .030
*G = -.489 (P = 0.001)
*L = -.008 (P = 0.964)
margins, dydx (*) predict (pr) post
*G = -.186 (P = 0.001)
*L = -.003 (P = .964)
*Rev = .054 (P= 0.272)
*RevG = -.046 (P= 0.570)
*RevL = -.008 (P= 0.929)

**************************************

probit y lg male genderint
*Psuedo R2 = .025
*LG = -.530 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = -.202 (P= 0.000)
*Male = .007 (P= 0.889)
*Genderint = .183 (P= 0.010)

probit y lg male genderint, robust
*Psuedo R2 = .025
*LG = -.530 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = -.202 (P= 0.000)
*Male = .007 (P= 0.889)
*GenderInt = .183 (P= 0.010)

logit y lg male genderint
*Psuedo R2 = .025
*LG = -.858 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = -.203 (P= 0.000)
*Male = .007 (P= 0.889)
*GenderInt = .184 (P= 0.009)

logit y lg male genderint, robust
*Psuedo R2 = .025
*LG = -.858 (P = 0.000)
margins, dydx (*) predict (pr) post
*LG = -.203 (P= 0.000)
*Male = .007 (P= 0.889)
*GenderInt = .184 (P= 0.009)

*Separate Male/Male and Female/Female (FINAL INCLUSION IN PAPER)

probit y g l male maleg malel, robust
*Psuedo R2 = .041
*G = -.730 (P = 0.000)
*L = -.274 (P = 0.093)
margins, dydx (*) predict (pr) post
*G = -.274 (P = 0.000)
*L = -.103 (P = .091)
*Male = .007 (P = .889)
*MaleG = .153 (P= 0.066)
*MaleL = .214 (P= 0.017)

**************************************

*Regression 4* (Are effects driven by location characteristics)?

*Create interaction terms*
generate medianint = lg*median
generate locint = lg*location_scoremedian

generate mediang = g*median
generate medianl = l*median

generate locg = g*location_scoremedian
generate locl = l*location_scoremedian

probit y lg median medianint
*Psuedo R2 = .0144
*LG = -.219 (P = 0.083)
margins, dydx (*) predict (pr) post
*LG = -.085 (P= 0.081)
*Median = .008 (P= 0.875)
*MedianInt = -.086 (P= 0.219)

probit y lg median medianint, robust
*Psuedo R2 = .0144
*LG = -.219 (P = 0.083)
margins, dydx (*) predict (pr) post
*LG = -.085 (P= 0.081)
*Median = .008 (P= 0.875)
*MedianInt = -.086 (P= 0.219)

logit y lg median medianint
*Psuedo R2 = .014
*LG = -.350 (P = 0.083)
margins, dydx (*) predict (pr) post
*LG = -.084 (P= 0.081)
*Median = .008 (P= 0.875)
*MedianInt = -.086 (P= 0.215)

logit y lg median medianint, robust
*Psuedo R2 = .014
*LG = -.350 (P = 0.083)
margins, dydx (*) predict (pr) post
*LG = -.084 (P= 0.081)
*Median = .008 (P= 0.875)
*MedianInt = -.086 (P= 0.216)

*Separate Male/Male and Female/Female (FINAL INCLUSION IN PAPER)

probit y g l median mediang medianl, robust
*Psuedo R2 = .032
*G = -.403 (P = 0.006)
*L = .049 (P = 0.762)
margins, dydx (*) predict (pr) post
*G = -.153 (P = 0.005)
*L = .019 (P = .762)
*Median = .008 (P = .875) 
*MedianG = -.130 (P =.111)
*MedianL = -.052 (P = .553)

*Sample drops from 794 to 699

probit y lg review_scores_location locint
*Psuedo R2 = .019
*LG = -2.46 (P = 0.05)
margins, dydx (*) predict (pr) post
*LG = -.949 (P= 0.048)
*Location = -.100 (P= 0.004)
*LocationInt = .090 (P= 0.083)

probit y lg review_scores_location locint, robust
*Psuedo R2 = .019
*LG = -2.46 (P = 0.052)
margins, dydx (*) predict (pr) post
*LG = -.949 (P= 0.050)
*Location = -.100 (P= 0.004)
*LocationInt = .090 (P= 0.085)

logit y lg review_scores_location locint
*Psuedo R2 = .019
*LG = -3.948 (P = 0.053)
margins, dydx (*) predict (pr) post
*LG = -.945 (P= 0.051)
*Location = -.100 (P= 0.005)
*LocationInt = .089 (P= 0.086)

logit y lg review_scores_location locint, robust
*Psuedo R2 = .019
*LG = -3.948 (P = 0.055)
margins, dydx (*) predict (pr) post
*LG = -.945 (P= 0.052)
*Location = -.100 (P= 0.004)
*LocationInt = .089 (P= 0.088)

*Separate Male/Male and Female/Female (FINAL INCLUSION IN PAPER)

probit y g l review_scores_location locg locl, robust
*Psuedo R2 = .036
*G = -.709 (P = 0.000)
*L = -.142 (P = 0.355)
margins, dydx (*) predict (pr) post
*G = -.268 (P = 0.000)
*L = -.054 (P = .354)
*Review Scores = -.106 (P = .001) 
*LocG = .158 (P = .058)
*LocL = .127 (P = .138)

**************************************
