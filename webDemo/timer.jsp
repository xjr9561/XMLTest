<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>定时器</title>
	<script type="text/javascript">
		var mesCurIndex=0;
		var sucaiCurIndex=0;
		var mesArr=new Array(); 
		var sucaiArr=new Array();
		mesArr[0]="http://172.16.190.56:50000/me-ext/com/sapdev/lagBehindReport/HourlyProductionKanban1.jsp?ACTIVITY_ID=YC_MES130_KANBAN1"; 
		mesArr[1]="http://172.16.190.56:50000/me-ext/com/sapdev/lagBehindReport/DailyProductionKanban1.jsp?ACTIVITY_ID=YC_MES129_KANBAN1";
		mesArr[2]="http://172.16.190.56:50000/me-ext/com/sapdev/lagBehindReport/HourlyProductionKanban2.jsp?ACTIVITY_ID=YC_MES130_KANBAN2";
		mesArr[3]="http://172.16.190.56:50000/me-ext/com/sapdev/lagBehindReport/DailyProductionKanban2.jsp?ACTIVITY_ID=YC_MES129_KANBAN2";
		sucaiArr[0]="http://172.16.231.22:8086/TrackingDataGrafic_Bu.aspx"; 
		sucaiArr[1]="http://172.16.231.22:8086/TrackingDataGrafic_Nei.aspx";
		sucaiArr[2]="http://172.16.231.22:8086/TrackingDataGrafic_Wai.aspx";
		sucaiArr[3]="http://172.16.231.22:8086/TrackingDataGrafic_Yu.aspx";
		
		/**
		 * 日期格式设置
		 * */
		Date.prototype.Format = function (fmt) {
		  var o = {
		    "M+": this.getMonth() + 1, //月份
		    "d+": this.getDate(), //日
		    "h+": this.getHours(), //小时
		    "m+": this.getMinutes(), //分
		    "s+": this.getSeconds(), //秒
		  };
		  if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
		  for (var k in o)
		  if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		  return fmt;
		}
		
		/**
		 * 设置日期格式
		 * */
		
		var ymd = new Date().Format("yyyy/MM/dd");
		
		/**
		 * 设置整点数组
		 * */
		var arr = new Array("01","02","03","04","05","06","07","08","09","10","11","12",
							 "13","14","15","16","17","18","19","20","21","22","23","00");
		
		var date1 = "";
		var date2 = "";
		/**
		 * MES报表图轮播
		 * */
		function time(date){
			//date1 = "2018/1/13 16:57:00"; 
			for (var i = 0 ; i < arr.length ; i++) {
				var point = ymd + " " + arr[i] + ":00:00";//下一个整点时间
				var pointDate = new Date(point).getTime();
				var tenMinutesDate = pointDate - 3000000;
				var tenMinutes = new Date(tenMinutesDate).Format("yyyy/MM/dd hh:mm:ss");//当前小时10分钟的时间
				//判断下一个整点是在第二天的00:00:00，将时间改为第二天的凌晨。
				if(arr[i] == "00"){
					pointDate = pointDate + 86400000;
					point = new Date(pointDate).Format("yyyy/MM/dd hh:mm:ss");
					tenMinutesDate = pointDate - 3000000;
					tenMinutes = new Date(tenMinutesDate).Format("yyyy/MM/dd hh:mm:ss");
				}
				//console.info(point + " " + tenMinutes);
				if(pointDate > date){//下一个整点时间的数值大于当前时间数值
					date1 = point;//将下一个整点时间赋值给date1保存。
					date2 = tenMinutes;//将当前小时10分钟的值赋给date2保存。
					break;//跳出循环
				}
			}
		}
		function mesTimer(){
			var mTimer = setInterval(function(){
				var obj = document.getElementById("showpage");
				obj.src = mesArr[mesCurIndex]; 
				if (mesCurIndex==mesArr.length-1) { 
					mesCurIndex=0; 
				} else { 
					mesCurIndex+=1; 
				} 
				obj.src = mesArr[mesCurIndex]; 
				var d1 = new Date().getTime();
				time(d1);
				var dateA = new Date(date1).getTime() - d1;   //时间差的毫秒数
				var dateB = new Date(date2).getTime() - d1;   //时间差的毫秒数 
				if(dateA >= 0 && dateB <=0){//当时间差小于0或者等于0的时候就停止当前定时器。
					clearInterval(mTimer);//停止mesTimer定时器
					mesCurIndex=0;//将索引清零
					obj.src = sucaiArr[sucaiCurIndex];
					suCaiTimer();//执行下一个定时器
					
				}
			},5000);
		}
		
		/**
		 * 数采图轮播
		 * */
		function suCaiTimer() {
			var scTimer = setInterval(function Timer(){ 
				var obj = document.getElementById("showpage");
				if (sucaiCurIndex==sucaiArr.length-1) { 
					sucaiCurIndex=0; 
				} else { 
					sucaiCurIndex+=1; 
				} 
				obj.src = sucaiArr[sucaiCurIndex]; 
				var d2 = new Date().getTime();
				//date1 = "2018/1/13 16:58:00"; 
				time(d2);
				var dateA = new Date(date1).getTime() - d2;   //时间差的毫秒数     
				var dateB = new Date(date2).getTime() - d2;   //时间差的毫秒数    
				//console.info(date2);
				if(dateA <= 0 || dateB >=0 ){//当时间差小于0或者等于0的时候就停止当前定时器。
					clearInterval(scTimer);//停止mesTimer定时器
					sucaiCurIndex=0;//将索引清零
					obj.src = mesArr[mesCurIndex];
					mesTimer();//执行下一个定时器
				}
			},5000);
		}
		mesTimer();
		
	</script>
</head>
<body>
	<!--<img src="img/0.jpg" width="427" height="219" id="showpic" /> 
	<div style="width: 100%;"></div>-->
	<frameset >
		<frame id="showpage" src="">
 	<noframes>
</body>
</html>