
*============================================================*
**       		 CFPS 练习  
**Goal		:    有关教育或家庭
**Data		:    cfps2014adult.dta
**Author	:  	 ZhangYi zhangyiceee@163.com 15592606739
**Created	:  	 20191207
**Last Modified: 2019
*============================================================*
	capture	clear
	capture log close
	set	more off
	set scrollbufsize 2048000
	capture log close 
	use "/Users/zhangyi/Documents/数据集/CFPS/real_cfps/CFPS2014/cfps2014adult.dta"
	codebook cfps_party,d
	drop if cfps_party ==-8
	codebook qn12012,d
	drop if qn12012==-2
	drop if qn12012==-1
	drop if qn12012==.
	tab1 cfps_party qn12012,m
	reg qn12012 cfps_party
	*党员的生活满意度高
