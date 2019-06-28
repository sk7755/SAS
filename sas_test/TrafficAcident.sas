data TrafficAccident;
input age $ total_accident deads injuries serious_injury slight_injury total_decl @@;
label age = '나이' total_accident = '발생 건수' deads = '사망자수' injuries = '부상자수'
	serious_injury = '중상' slight_injury = '경상' total_decl = '부상신고';

/*
death_rate = deads / total_accident;
serious_injury_rate = serious_injury / total_accident;
slight_injury_rate = slight_injury / total_accident;
injury_rate = injuries / total_accident;
*/


cards;
12세이하 398 0 434 77 230 127
13-20세  6256 97 8986 1997 5824 1165
21-30세  28727 420 44204 9587 31478 3139
31-40세  33618 511 50796 11405 36228 3163
41-50세  42204 636 63137 14389 44858 3890
51-60세  53631 940 80116 18822 56770 4524
61-64세  18095 330 27142 6257 19309 1576
65세이상  30012 843 43469 11073 29713 2683
불명 4207 4 4753 651 3101 1001
;
run;

/* 전체 데이터 개요 */
proc print data =TrafficAccident label;
run;


/* 1.  나이에 따른 중상, 경상, 부상 신고의 비율. 범주형 자료분석*/
data injury_data;
input age $ injury_type $ count @@;

cards;
13_20 serious 1997
13_20 slight 5824
13_20 declare 1165
21_30 serious 9587
21_30 slight 31478
21_30 declare 3139
31_40 serious 11405
31_40 slight 36228
31_40 declare 3163
41_50 serious 14389
41_50 slight 44858
41_50 declare 3890
51_60 serious 18822
51_60 slight 56770
51_60 declare 4524
61_64 serious 6257
61_64 slight 19309
61_64 declare 1576

;
run;

/* 독립성 검정 = 가해자 나이에 따른 부상비율은 서로 독립적인가? */

proc freq data =injury_data order = data;
weight count;
tables age*injury_type /nocol norow nopercent expected chisq;
run;

/* 2. 나이에 따른 사망률 선형 회귀 분석
나이는 범주의 평균으로 산정하였음*/
data death_data;

input min_age max_age total_accident deaths @@;
age = (min_age + max_age) / 2;
death_rate = deaths / total_accident;
cards;
13 20 6256 97
21 30 28727 420
31 40 33618 511
41 50 42204 636
51 60 53631 940
61 64 18095 330
;
run;

proc print data =death_data;
run;

proc reg data = death_data;
model death_rate = age / dw;
run;
quit;