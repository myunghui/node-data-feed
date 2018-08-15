"use strict"

const express = require("express");
const app = express();
const cheerio = require("cheerio-httpcli");
const url = require("url");
		 
//console.log("__dirname=" + __dirname);
app.use(express.static(__dirname + "/public"));

app.get("/favicon.ico", function(request, response){
        response.end();
});
app.get("/",                 (request, response) => process(request, response));
app.get("/KOSPI",      (request, response) => process(request, response));
app.get("/KOSDAQ",  (request, response) => process(request, response));

function process(request, response) {
	
        console.log(getLogHeader() + "  request.header=" + JSON.stringify(request.headers));
        const word = "";
        const siseUrl = "https://finance.naver.com/sise";
		const keyMap = {"KOSPI":"#KOSPI_now", "KOSDAQ":"#KOSDAQ_now"};
		
		let keys = request.query.KEY;
		if (keys === undefined) {
			keys = url.parse(request.url).pathname.replace("/","");
			if (keys === "") {
				keys = "KOSPI|KOSDAQ";
			}
		}
		console.log("	>>>	" + keys);
		if (keys == undefined) {
			
			response.end();
			
		} else {
			
			cheerio.fetch(
				siseUrl, 
				{ q: word }, 
				function (err, $, res, body) {
					
					const SEP = "|";

					let key = "";
					let val = "";
					const keyArr = keys.split(SEP);
					for (let k=0;k < keyArr.length;k++) {
						key += (k === 0 ? "" : SEP) + keyArr[k];
						val  += (k === 0 ? "" : SEP) + $(keyMap[keyArr[k]]).text().replace(",", "");
					}
					console.log("	>>>	" + key);
					console.log("	>>>	" + val);
					//resContent[key] = val;
					const resContent = {"KEY":key, "VALUE":val};
					console.log(getLogHeader()  + " " + JSON.stringify(resContent));
					response.setHeader("Content-Type", "application/json");
					response.jsonp(resContent);
					response.end();
				}
			);
			
		}
		
}

const PORT_NUM = 4000;
app.listen(PORT_NUM, function(){
        let initLog = "\n";
        initLog += "*************************************************************";
        initLog += "\n";
        initLog += "\n";
        initLog += "    네이버 크롤링 서비스 개시 (포트번호 = " + PORT_NUM + ")";
        initLog += "\n";
        initLog += "\n";
        initLog += "*************************************************************";
        initLog += "\n";
    console.log(initLog);
});

function getLogHeader() {
	return "[" + getCurrentTimestamp() + "] ";
}

function getCurrentTimestamp() {
	const date = new Date();
	let chgTimestamp = date.getFullYear().toString();
	chgTimestamp += "/";
	chgTimestamp += addZero(date.getMonth()+1);
	chgTimestamp += "/";
	chgTimestamp += addZero(date.getDate().toString());
	chgTimestamp += " ";
	chgTimestamp += addZero(date.getHours().toString());
	chgTimestamp += ":";
	chgTimestamp += addZero(date.getMinutes().toString());
	chgTimestamp += ".";
	chgTimestamp += addZero(date.getSeconds().toString());
	return chgTimestamp;
}

function addZero(data){
	return (data < 10) ? "0" + data : data;
}
