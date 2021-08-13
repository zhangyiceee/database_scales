

*============================================================*
*				抓取广西异地扶贫搬迁数据  
**Goal		:    
**Data		:    
**Author	:  	 ZhangYi zhangyiceee@163.com 15592606739
**Created	:  	 20210813
**Last Modified: 201
*============================================================*
	capture	clear
	capture log close
	set	more off
	set scrollbufsize 2048000
	capture log close 


	global output "/Users/zhangyi/Documents/GitHub/database_scales/Relocation/output"
	global raw "/Users/zhangyi/Documents/GitHub/database_scales/Relocation/raw"
	global working "/Users/zhangyi/Documents/GitHub/database_scales/Relocation/working"
	cd "/Users/zhangyi/Documents/GitHub/database_scales/Relocation/"

	forvalue page=1/43{
	copy "http://www.gxazzx.org.cn/index.php?m=place&c=index&a=lists&city=0&county=0&place=&dosubmit=%E6%9F%A5%E8%AF%A2&page=`page'" "working/test.txt" ,text replace
	infix strL v 1-100000 using "working/test.txt", clear 	
	keep if (index(v,"<td>") | index(v,"</td>")) 
	replace  v=regexs(1) if regexm(v,"(.*)</td>")
	replace v =v+v[_n+1]  if regexm(v,"<td>")==1 & regexm(v[_n+1],"<td>")==0

	drop if regexm(v,"<td>")==0
	replace v = ustrregexra(v,"<.*?>","")        // 去除目标数据中的标签
	forvalue i = 1/10 {                                                                //循环生成8个变量
	gen v`i' = v[_n+`i']                                                //每个变量的取值为v第_n+`i'个观测
	format %10s v`i' 
	}        
	    keep if mod(_n,11) == 1                                          // 保留行数除以11余数为1的行
	rename _all (集中安置点名称 村 乡镇 县城 县 市 建档立卡对象 同步搬迁 合计 是否为万人以上集中安置点 是否为800以上的集中安置点)    
	save "working/relocation`page'" ,replace
	}


	use "working/relocation1.dta",replace
	forvalue x =2/43{
	append using "working/relocation`x'.dta"
	  erase "working/relocation`x'.dta" 
	} 
	save "output/relocation.dta",replace 
	erase "working/relocation1.dta"








