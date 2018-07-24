<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="zh-CN">
    <meta charset="UTF-8">
    <title>70-股票实时刷新</title>
    <link rel="stylesheet" href="css/mycss.css">
</head>
<body>
<div id="win">
    <div id="header">
        <div id="top">
            <div class="data">
                <ul>
                    <li class="exponent">
                        <span id="sse">上证指数</span>
                        <span id="sse_price">281.04</span>
                        <span id="sse_change">+1.21%</span>
                    </li>
                    <li class="exponent">
                        <span>深成指数</span>
                        <span>12814.04</span>
                        <span>+2.31%</span>
                    </li>
                    <li class="exponent">
                        <span>创板指数</span>
                        <span>1616.91</span>
                        <span>-0.73%</span>
                    </li>
                </ul>
            </div>
            <div class="data" id="list">
                <div id="input">
                   	<input id="addContext" type="text" name="addContext" value="s_sh000001"/>
                   	<input id="addBtn" type="button" value="添加" style="background-color: pink;"/>
                </div>
                <ul id="codeUl">
                    
                </ul>
            </div>
            <div class="data" id="current">
                <div id="logo">
                    <img src="images/bg-sun.png" alt=""/>
                </div>
                <div id="content">
                    <ul>
                        <li>
                            <span>股票代码</span>
                            <span id="cur_num">000001</span>
                        </li>
                        <li>
                            <span>当前价格</span>
                            <span id="cur_price">8.73</span>
                        </li>
                        <li>
                            <span>涨跌幅度</span>
                            <span id="cur_change">-1.81%</span>
                        </li>
                        <li>
                            <span>交易金额</span>
                            <span id="cur_money">3254646</span>
                        </li>
                        <li>
                            <span>交易量</span>
                            <span id="cur_vol">423678手</span>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="data">
                <iframe src="https://mguba.eastmoney.com/mguba/list/600000
" name="news" width="295px" height="180px" id="news"></iframe>
            </div>
        </div>
        <div id="down">
            <div class="data">
                <div class="title">分时线</div>
                <img src="http://image.sinajs.cn/newchart/min/n/sh000001.gif" id="minK" alt=""/>
            </div>
            <div class="data">
                <div class="title">日K线</div>
                <img src="http://image.sinajs.cn/newchart/daily/n/sh601006.gif" id="dayK" alt=""/>
            </div>
            <div class="data">
                <div class="title">周K线</div>
                <img src="http://image.sinajs.cn/newchart/weekly/n/sh000001.gif" id="weekK" alt=""/>
            </div>
            <div class="data">
                <div class="title">月K线</div>
                <img src="http://image.sinajs.cn/newchart/monthly/n/sh000001.gif" id="monthK" alt=""/>
            </div>
        </div>
    </div>
    <div id="bottom">
        <ul>
            <li></li>
            <li><a href="#">首页</a></li>
            <li><a href="#">历史数据分析</a></li>
            <li><a href="#">交易量分析</a></li>
            <li></li>
        </ul>
    </div>
    <p>&copy;&nbsp;2018&nbsp;华世洋&nbsp;林永健&nbsp;彭思明&nbsp;</p>
</div>

<script type="text/javascript" src="http://hq.sinajs.cn/list=s_sh000001"></script>
<script type="text/javascript" src="http://hq.sinajs.cn/list=s_sz399001"></script>
<script type="text/javascript" src="http://hq.sinajs.cn/list=s_sz399006"></script>
<script type="text/javascript" src="script/jQuery1.2.4.js"></script>
<script type="text/javascript" src="script/myscript.js"></script>
<script>
    $(function(){
    	var count = 0;
    	$("#addBtn").click(function(){
    		var context = $("#addContext").val();
    		if(context == ''){
    			alert("请输入股票代码");
    		}else{
	    		var addScript = "<script src='http://hq.sinajs.cn/list="+ context +"'><\/script>";
	    		$("head").append(addScript);
	    		
	    		var dataStr = "hq_str_"+context;
	            
            	var codeVal = eval(dataStr);
            	if(codeVal==''||codeVal==null){
            		alert("这不是一个正确的股票代码格式！");
            	}else{
	            	//插入到数据库
	            	$.ajax({
	        			type:"POST",
	        			url:"/addStock",
	        			data:{
	        				"addContext":codeVal,
	        				"addCode":context
	        				},
	        			success:function(result){
	        				if(result != '' || result != null){
	        					count++;
	        					appendLi(result,count);
	        				} 
	        			}
		        	});
            	}
	            
    		}
    	});
    	
    });
    function appendLi(result,count){
		var name = result.split(',')[0];
		var context1 = parseFloat(result.split(',')[1]).toFixed(2);
		var context2 = result.split(',')[3] + "%";
		var id = result.split(',')[7];
		var sc = result.split(',')[6];
		var ssc = sc.substring(2,sc.length);
		var codeLi = "";
		codeLi += '<li class="bank">';
		codeLi += '<span name="'+ ssc +'" class="d'+ count +'">'+ name +'</span>';
		codeLi += '<span class="d'+ count +'">'+ context1 +'</span>';
		codeLi += '<span class="d'+ count +'">'+ context2 +'</span>';
		codeLi += '<input id="'+ id +'" type="submit" value="删除" onclick="deleteLi('+ id +')" style="background-color: pink;"/>';
		codeLi += '</li>';
		$("#codeUl").append(codeLi);
	}
    
   	function deleteLi(id){
   		$.ajax({
   			url:"delStock",
   			data:{"id":id},
   			success:function(result){
   				var currLi = $("#"+ id +"").parent();
   				currLi.remove();
   			}
   		});
   		
   	}
</script>

<script>
var isOpen = false;
var cont = 1;
var timer=null;
window.onload = function(){
	var timmer = null;

    //模块一
    var lis = document.getElementsByClassName("exponent");
    var sse = lis[0];
    var sse_1 = sse.children[0];
    var sse_price = sse.children[1];
    var sse_change = sse.children[2];

    var deep = lis[1];
    var deep_1 = deep.children[0];
    var deep_price = deep.children[1];
    var deep_change = deep.children[2];

    var board = lis[2];
    var board_1 = board.children[0];
    var board_price = board.children[1];
    var board_change = board.children[2];
    
    clearInterval(timmer);
    timmer = setInterval(function(){
    	exponent("sh000001",sse_1,sse_price,sse_change);
        exponent("sz399001",deep_1,deep_price,deep_change);
        exponent("sz399006",board_1,board_price,board_change);
        
        
        
        setValue("d1");
    	setValue("d2");
    	setValue("d3");
    	setValue("d4");
    	setValue("d5");
    	setValue("d6");
    	setValue("d7");
    	setValue("d8");
    	isOpen = true;
    },1000);
}
function exponent(number,id1,id2,id3){
    var head = document.getElementsByTagName("head")[0];
    var firstChild = head.getElementsByTagName("script")[0];
    var createScript = document.createElement("script");
    createScript.src="http://hq.sinajs.cn/list=s_"+number;
    head.appendChild(createScript);

    if(isOpen) {
        var dataStr = "hq_str_s_"+number;
        var result = eval(dataStr);
        var stock=result.split(",");

        id1.innerHTML = stock[0];
        id2.innerHTML = parseFloat(stock[1]).toFixed(2);
        id3.innerHTML = stock[3] + "%";

        var num = parseFloat(stock[3]);
        if(num > 0){
            id1.style.color = "green";
            id2.style.color = "green";
            id3.style.color = "green";
        }
        else if(num < 0){
            id1.style.color = "red";
            id2.style.color = "red";
            id3.style.color = "red";
        }
    }
}

function getCurrent(number,id1,id2,id3,id4,id5){
    createScript(number);
    
    if(isOpen){
        var dataStr = "hq_str_s_"+number;
        var result = eval(dataStr);
        var stock=result.split(",");

        var d1 = document.getElementById(id1);
        d1.innerHTML = number;
        var d2 = document.getElementById(id2);
        d2.innerHTML = stock[1];
        var d3 = document.getElementById(id3);
        d3.innerHTML = stock[3] + "%";
        var d4 = document.getElementById(id4);
        id4.innerHTML = parseInt(stock[5]);
        var d5 = document.getElementById(id5);
        d5.innerHTML = stock[4]+"手";



        var num = parseFloat(stock[3]);
        if(num > 0){
            d1.style.color = "green";
            d1.previousElementSibling.style.color = "green";
            d2.style.color = "green";
            d2.previousElementSibling.style.color = "green";
            d3.style.color = "green";
            d3.previousElementSibling.style.color = "green";
            d4.style.color = "green";
            d4.previousElementSibling.style.color = "green";
            d5.style.color = "green";
            d5.previousElementSibling.style.color = "green";
        }
        else if(num < 0){
            d1.style.color = "red";
            d1.previousElementSibling.style.color = "red";
            d2.style.color = "red";
            d2.previousElementSibling.style.color = "red";
            d3.style.color = "red";
            d3.previousElementSibling.style.color = "red";
            d4.style.color = "red";
            d4.previousElementSibling.style.color = "red";
            d5.style.color = "red";
            d5.previousElementSibling.style.color = "red";
        }
    }
}
function picFlash(time,number,id1){
    

	cont++;
	if(cont>100){
		cont=1;
	}
    var id1 = document.getElementById(id1);
    
    id1.src ="http://image.sinajs.cn/newchart/"+time+"/n/"+number+".gif&i="+cont;
    
}
function setValue(className){
    var ds = document.getElementsByClassName(className);
    var li = ds[0];
    var number = li.getAttribute("name");
    li.style.cursor = "pointer";
    
    var num = parseFloat(ds[2].innerHTML);
    
    li.onclick = function(){
        //learInterval(timmer);
        
        	getCurrent(number, "cur_num", "cur_price", "cur_change", "cur_money", "cur_vol");
            picFlash("min", number, "minK");
            picFlash("daily", number, "dayK");
            picFlash("weekly", number, "weekK");
            picFlash("monthly", number, "monthK");
      
        
        getNews(number, "news");
    };
    
    if(num>0){
    	ds[0].style.color = "green";
    	ds[1].style.color = "green";
    	ds[2].style.color = "green";
    }
    else if(num<0){
    	ds[0].style.color = "red";
    	ds[1].style.color = "red";
    	ds[2].style.color = "red";
    }
}

function getNews(number,id){
    createScript(number);

    var id1 = document.getElementById(id);
    
    if(isOpen) {
        id1.src ="https://mguba.eastmoney.com/mguba/list/"+number;
    }
}
function createScript(number){
    var head = document.getElementsByTagName("head")[0];        //获取head标签
    var firstChild = head.getElementsByTagName("script")[0];    //获取script标签
    var createScript = document.createElement("script");        //创建script标签
    createScript.src="http://hq.sinajs.cn/list=s_"+number;      //设置要获取的股票地址
    head.appendChild(createScript);
}
</script>

</body>
</html>