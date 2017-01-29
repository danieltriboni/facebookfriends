var edit = false;
var internetConnection;
var common = {
    initialize: function() {
        this.bindEvents();
    },
    bindEvents: function() {
        document.addEventListener("deviceready", this.fOnDeviceReady, false);
        document.addEventListener("backbutton", this.onBackKeyDown, false);
        btnExit1.addEventListener('click', this.fExit, false);
        btnExit2.addEventListener('click', this.fExit, false);
        btnExit3.addEventListener('click', this.fExit, false);
    },
    fOnDeviceReady: function(){
        var networkState = navigator.connection.type;
        var states = {};

        states[Connection.UNKNOWN]  = 'UNKNOWN';
        states[Connection.ETHERNET] = 'ETHERNET';
        states[Connection.WIFI]     = 'WIFI';
        states[Connection.CELL_2G]  = '2G';
        states[Connection.CELL_3G]  = '3G';
        states[Connection.CELL_4G]  = '4G';
        states[Connection.CELL]     = 'CELL';
        states[Connection.NONE]     = 'NONE';
        console.log('INFOAPP: Common OK e Connection type: ' + states[networkState]);
        internetConnection = states[networkState];
    },
    onBackKeyDown: function(){
        location.href='main.html';
    },
    fExit: function(){
        common.fNotification('Deseja sair do aplicativo?', 'confirm', common.fConfirmExit);
    },
    fConfirmExit: function(buttonIndex){
        if(buttonIndex == 1)
            navigator.app.exitApp();
    },
    fNotification: function(msg, type, callBack, btYes, btNo, msgAttention){
        btYes = btYes || "Sim";
        btNo = btNo || "Nao";
        msgAttention = msgAttention || "Facebook Friends";
        if(type == 'alert'){
            navigator.notification.alert(
                msg,
                callBack,
                msgAttention,
                'OK'
            );
        }else{
            navigator.notification.confirm(
                msg,
                callBack,
                msgAttention,
                [btYes, btNo]
            );
        }
    },
    fCheckEmail: function(field){
    	var user = field.substr(0, field.indexOf("@"));
    	var domain = field.substr(field.indexOf("@")+ 1, field.length);
    	if ((user.length >=1) &&
    		(domain.length >=3) &&
    		(user.search("@")==-1) &&
    		(domain.search("@")==-1) &&
    		(user.search(" ")==-1) &&
    		(domain.search(" ")==-1) &&
    		(domain.search(".")!=-1) &&
    		(domain.indexOf(".") >=1)&&
    		(domain.lastIndexOf(".") < domain.length - 1)) {
    			return true;
    	} else{
    		return false;
    	}
    },
    rpad: function(originalstr, length, strToPad) {
            while (originalstr.length < length)
                originalstr = originalstr + strToPad;
            return originalstr;
    },
    fTrimWords: function(textToLimit, wordLimit) {
        var finalText = "";
        var text2 = textToLimit.replace(/\s+/g, ' ');
        var text3 = text2.split(' ');
        var numberOfWords = text3.length;
        var i=0;
        if(numberOfWords > wordLimit){
            for(i=0; i< wordLimit; i++)
                finalText = finalText+" "+ text3[i]+" ";
            return finalText+"...";
        }
        else
            return textToLimit;
    },
    fCurrDate: function(){
        var currDate  = new Date();
        var currDay   = ('0' + currDate.getDate()).slice(-2);
        var currMonth = currDate.getMonth();
        var currYear  = currDate.getFullYear();
        var currHour  = ('0' + currDate.getHours()).slice(-2);
        var currMin   = ('0' + currDate.getMinutes()).slice(-2);
        var currSec   = ('0' + currDate.getSeconds()).slice(-2);
        var nrMonth   = ["01","02","03","04","05","06","07","08","09","10","11","12"];
        var dt = currYear + nrMonth[currMonth] + currDay + currHour + currMin + currSec;
        return dt;
    }
};

common.initialize();
