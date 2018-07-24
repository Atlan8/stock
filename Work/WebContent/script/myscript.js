var isOpen = false;
    
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
            picFlash("min","sh000001","minK");
            picFlash("daily","sh000001","dayK");
            picFlash("weekly","sh000001","weekK");
            picFlash("monthly","sh000001","monthK");

            exponent("sh000001",sse_1,sse_price,sse_change);
            exponent("sz399001",deep_1,deep_price,deep_change);
            exponent("sz399006",board_1,board_price,board_change);

            getData("sz000027","d22","d23","d24");
            getData("sh600000","dd22","dd23","dd24");
            getData("sh600028","ddd22","ddd23","ddd24");
            getData("sz000063","dddd22","dddd23","dddd24");
            getData("sh600029","ddddd22","ddddd23","ddddd24");

            getCurrent("sz000027","cur_num","cur_price","cur_change","cur_money","cur_vol");

            setValue("d22","sz000027",timmer);
            setValue("dd22","sh600000",timmer);
            setValue("ddd22","sh600028",timmer);
            setValue("dddd22","sz000063",timmer);
            setValue("ddddd22","sh600029",timmer);
            isOpen = true;
        },3000);
    };
	
    function exponent(number,id1,id2,id3){
        var head = document.getElementsByTagName("head")[0];        //获取head标签
        var firstChild = head.getElementsByTagName("script")[0];    //获取script标签
        var createScript = document.createElement("script");        //创建script标签
        createScript.src="http://hq.sinajs.cn/list=s_"+number;      //设置要获取的股票地址
        head.appendChild(createScript);

        if(firstChild){
            head.removeChild(firstChild);                           //删除script标签
        }
        
        if(isOpen) {
            var dataStr = "hq_str_s_"+number;
            var result = eval(dataStr);                             //eval方法作用：把字符串转变量使用
            var stock=result.split(",");

            id1.innerHTML = stock[0];
            id2.innerHTML = parseFloat(stock[1]).toFixed(2);
            id3.innerHTML = stock[3] + "%";
        }
    }

    function getData(number,id1,id2,id3){		    	                        //定义可传参的方法getData，
        var head = document.getElementsByTagName("head")[0];        //获取head标签
        var firstChild = head.getElementsByTagName("script")[0];    //获取script标签
        var createScript = document.createElement("script");        //创建script标签
        createScript.src="http://hq.sinajs.cn/list="+number;      //设置要获取的股票地址
        head.appendChild(createScript);	                            //把script标签添加到head里
        if(firstChild){
            head.removeChild(firstChild);                           //删除script标签
        }
        if(isOpen){
            var dataStr = "hq_str_"+number;
            var result = eval(dataStr);                             //eval方法作用：把字符串转变量使用
            var stock=result.split(",");                        //把获取到的股票数据以,号为分界拆分成数组。

            var d23=document.getElementById(id1); 				//找id名称为d23的标签
            d23.innerHTML=stock[0];   				                //把数组下标为3的数据设置给标签。
            var d24=document.getElementById(id2);
            d24.innerHTML=parseFloat(stock[3]).toFixed(2);
            var d25=document.getElementById(id3);
            var num1 = parseFloat(stock[3]);
            var num2 = parseFloat(stock[1]);
            var change = (num1/num2 - 1) * 100;
            d25.innerHTML= change.toFixed(2) + "%";
        }
    }

    function getCurrent(number,id1,id2,id3,id4,id5){		    	                        //定义可传参的方法getData，
        var head = document.getElementsByTagName("head")[0];        //获取head标签
        var firstChild = head.getElementsByTagName("script")[0];    //获取script标签
        var createScript = document.createElement("script");        //创建script标签
        createScript.src="http://hq.sinajs.cn/list=s_"+number;      //设置要获取的股票地址
        head.appendChild(createScript);	                            //把script标签添加到head里
        if(firstChild){
            head.removeChild(firstChild);                           //删除script标签
        }
        if(isOpen){
            var dataStr = "hq_str_s_"+number;
            var result = eval(dataStr);                             //eval方法作用：把字符串转变量使用
            var stock=result.split(",");                        //把获取到的股票数据以,号为分界拆分成数组。

            var id1 = document.getElementById(id1); 				//找id名称为d23的标签
            id1.innerHTML = number;   				                //把数组下标为3的数据设置给标签。
            var id2 = document.getElementById(id2);
            id2.innerHTML = stock[1];
            var id3 = document.getElementById(id3);
            id3.innerHTML = stock[3] + "%";
            var id4 = document.getElementById(id4);
            id4.innerHTML = parseInt(stock[5]);
            var id5 = document.getElementById(id5);
            id5.innerHTML = stock[4]+"手";
        }
    }

    function picFlash(time,number,id1){
        var head = document.getElementsByTagName("head")[0];        //获取head标签
        var firstChild = head.getElementsByTagName("script")[0];    //获取script标签
        var createScript = document.createElement("script");        //创建script标签
        createScript.src="http://image.sinajs.cn/newchart/"+time+"/n/"+number+".gif";      //设置要获取的股票地址
        head.appendChild(createScript);	                            //把script标签添加到head里

        var id1 = document.getElementById(id1);
        if(firstChild){
            head.removeChild(firstChild);                           //删除script标签
        }
        if(isOpen) {
            id1.src ="http://image.sinajs.cn/newchart/"+time+"/n/"+number+".gif";
        }
    }

    function setValue(id,number,timmer){
        var id1 = document.getElementById(id);
        id1.style.cursor = "pointer";

        id1.onclick = function(){
            clearInterval(timmer);
            getCurrent(number,"cur_num","cur_price","cur_change","cur_money","cur_vol");
            picFlash("min",number,"minK");
            picFlash("daily",number,"dayK");
            picFlash("weekly",number,"weekK");
            picFlash("monthly",number,"monthK");

            getNews(number,"news");
        };
    }

    function getNews(number,id){
        var head = document.getElementsByTagName("head")[0];        //获取head标签
        var firstChild = head.getElementsByTagName("script")[0];    //获取script标签
        var createScript = document.createElement("script");        //创建script标签
        createScript.src="https://mguba.eastmoney.com/mguba/list/"+number;;      //设置要获取的股票地址
        head.appendChild(createScript);	                            //把script标签添加到head里

        var id1 = document.getElementById(id);
        if(firstChild){
            head.removeChild(firstChild);                           //删除script标签
        }
        if(isOpen) {
            id1.src ="https://mguba.eastmoney.com/mguba/list/"+number;
        }
    }