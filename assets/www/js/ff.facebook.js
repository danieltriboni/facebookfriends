/*
Login com facebook via oAuth
Listagem de amigos e Autenticacao
copyright 2017 - Daniel Triboni
*/
var loginURL = 'https://www.facebook.com/dialog/oauth',
        logoutURL = 'https://www.facebook.com/logout.php',
        fbAppId,
        cordovaOAuthRedirectURL = "https://www.facebook.com/connect/login_success.html",
        logoutRedirectURL,
        loginCallback,
        obsShare,
        latShare,
        lngShare,
        cidadao,
        runningInCordova = false,
        loginProcessed = false;
var facebook = {
    initialize: function() {
            console.log('INFOAPP: Load Facebook OK');
            document.addEventListener("deviceready", function () { runningInCordova = true; }, false);
            btnFB.addEventListener('click', this.fLogin, false);
            fbAppId = 1218117214904751;
    },
    login:function(callback, options) {
        var loginWindow,
            startTime,
            scope = '',
            redirectURL = cordovaOAuthRedirectURL;
        if (!fbAppId) {
            return callback({status: 'unknown', error: 'Facebook App Id informado incorretamente.'});
        }
         var loginWindow_loadStartHandler = function(event) {
            navigator.notification.activityStart("Facebook Friends", "Aguarde...");
            var url = event.url;
            if (url.indexOf("access_token=") > 0 || url.indexOf("error=") > 0) {
                var timeout = 600 - (new Date().getTime() - startTime);
                setTimeout(function () {
                    loginWindow.close();
                    facebook.getInfo();
                }, timeout > 0 ? timeout : 0);
                facebook.oauthCallback(url);
            }
        };
        var loginWindow_exitHandler = function() {
            console.log('Removendo Listeners');
            if (loginCallback && !loginProcessed) facebook.loginCallback({status: 'user_cancelled'});
            loginWindow.removeEventListener('loadstop', facebook.loginWindow_loadStopHandler);
            loginWindow.removeEventListener('exit', facebook.loginWindow_exitHandler);
            loginWindow = null;
            navigator.notification.activityStop();
        };
        var loginWindow_loadStopHandler = function(){
            navigator.notification.activityStop();
            console.log('Pagina FB carregada');
        };
        if (options && options.scope) {
            scope = options.scope;
        }
        loginCallback = callback;
        loginProcessed = false;
        startTime = new Date().getTime();
        loginWindow = window.open(loginURL + '?client_id=' + fbAppId + '&redirect_uri=' + redirectURL + '&response_type=token&scope=' + scope, '_blank', 'location=no,clearcache=yes');
        loginWindow.addEventListener('loadstart', loginWindow_loadStartHandler);
        loginWindow.addEventListener('exit', loginWindow_exitHandler);
        loginWindow.addEventListener('loadstop', loginWindow_loadStopHandler);
        navigator.notification.activityStop();
    },
    oauthCallback: function(url) {
        var queryString, obj;
        loginProcessed = true;
        if (url.indexOf("access_token=") > 0) {
            $.mobile.loading('show', { text: 'Aguarde', textVisible: true, theme: 'a', textonly: false, html: '' });
            queryString = url.substr(url.indexOf('#') + 1);
            obj = facebook.parseQueryString(queryString);
            window.localStorage.setItem('fbtoken', obj['access_token']);
            console.log('INFOAPP: ' + window.localStorage.getItem('fbtoken'));
            if (loginCallback) facebook.loginCallback({status: 'connected', authResponse: {accessToken: obj['access_token']}});
        } else if (url.indexOf("error=") > 0) {
            queryString = url.substring(url.indexOf('?') + 1, url.indexOf('#'));
            obj = facebook.parseQueryString(queryString);
            if (loginCallback) facebook.loginCallback({status: 'not_authorized', error: obj.error});
        } else {
            if (loginCallback) facebook.loginCallback({status: 'not_authorized'});
        }
    },
    logout: function(callback) {
        console.log('INFOAPP: Logout Facebook...');
        var logoutWindow,
            token = window.localStorage.getItem('fbtoken');
            window.localStorage.removeItem('fbtoken');
        if (token) {
            console.log('INFOAPP: ' + logoutURL + '?access_token=' + token + '&next=' + logoutRedirectURL);
            logoutWindow = window.open(logoutURL + '?access_token=' + token + '&next=' + logoutRedirectURL, '_blank', 'location=no,clearcache=yes');
            if (runningInCordova) {
                setTimeout(function() {
                    logoutWindow.close();
                }, 700);
            }
        }
        if (callback) {
            callback();
        }
    },
    getInfo: function() {
        navigator.notification.activityStop();
        console.log('INFOAPP: Carregando info...');
        var method = 'GET', params = {}, xhr = new XMLHttpRequest(), url;
        params['access_token'] = window.localStorage.getItem('fbtoken');
        params['fields'] = "name,email";
        url = 'https://graph.facebook.com/me?' + facebook.toQueryString(params);
        console.log('INFOAPP: URL INfo: ' + url);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);
                    if(window.localStorage.getItem('email') == null){
                        console.log(data);
                        var name = data.name.split(" ");
                        window.localStorage.setItem('email', data.email);
                        window.localStorage.setItem('foto', 'http://graph.facebook.com/' + data.id + '/picture?type=large');
                        window.localStorage.setItem('nome', name[0]);
                        window.localStorage.setItem('apelido', name[0]);
                        location.href='main.html';
                    }
                } else {
                    var error = xhr.responseText ? JSON.parse(xhr.responseText).error : {message: 'Ocorreu um erro de parse do JSON'};
                    if (obj.error) alert(error);
                }
            }
        };
        xhr.open(method, url, true);
        xhr.send();
    },
    sortJsonArrayByProperty: function(objArray, prop, direction){
        if (arguments.length<2) throw new Error("sortJsonArrayByProp requires 2 arguments");
        var direct = arguments.length>2 ? arguments[2] : 1; //Default to ascending
        if (objArray && objArray.constructor===Array){
            var propPath = (prop.constructor===Array) ? prop : prop.split(".");
            objArray.sort(function(a,b){
                for (var p in propPath){
                    if (a[propPath[p]] && b[propPath[p]]){
                        a = a[propPath[p]];
                        b = b[propPath[p]];
                    }
                }
                // convert numeric strings to integers
                a = a.match(/^\d+$/) ? +a : a;
                b = b.match(/^\d+$/) ? +b : b;
                return ( (a < b) ? -1*direct : ((a > b) ? 1*direct : 0) );
            });
        }
    },
    friends: function(){
        $.mobile.loading('show', { text: 'Aguarde', textVisible: true, theme: 'a', textonly: false, html: '' });
        console.log('INFOAPP: Carregando List Friends...');
        var method = 'GET', params = {}, xhr = new XMLHttpRequest(), url;
        params['access_token'] = window.localStorage.getItem('fbtoken');
        url = 'https://graph.facebook.com/v2.8/me/taggable_friends?limit=5000&offset=5000&' + facebook.toQueryString(params);
        console.log('INFOAPP: URL INFO: ' + url);
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4) {
                if (xhr.status === 200) {
                    var res = JSON.parse(xhr.responseText);
                    var html = '';
                    for (x = 0; x < 5000; x++){
                        if (res.data[x] !== undefined){
                            var name = res.data[x].name.split(" ");
                            html += '<div class="wrapper" style="margin-left: 20px;">' +
                                    '<img src="' + res.data[x].picture.data.url + '" height="100" alt="" />' +
                                    '</div>' +
                                    '<div id="name" class="textUser">' + name[0].toUpperCase() + '<br><span class="surName">' + name[name.length - 1].toUpperCase() + '</span></div>';

                        }
                        //console.log(res.data[x].name);
                    }
                    $('#list').html(html);
                } else {
                    var error = xhr.responseText ? JSON.parse(xhr.responseText).error : 'Ocorreu um erro ao carregar a lista de Amigos';
                    common.fNotification('Para listar seus amigos, seu perfil deve estar configurado como TESTADOR para exibir seu Amigos Marcaveis no Facebook. Contate o desenvolvedor para configurar seu perfil na pagina de admin do Facebook Friends!', 'alert', null);
                }
                $.mobile.loading('hide');
            }
        };
        xhr.open(method, url, true);
        xhr.send();
    },
    parseQueryString: function(queryString) {
        var qs = decodeURIComponent(queryString),
            obj = {},
            params = qs.split('&');
        params.forEach(function (param) {
            var splitter = param.split('=');
            obj[splitter[0]] = splitter[1];
        });
        return obj;
    },
    toQueryString: function(obj) {
        var parts = [];
        for (var i in obj) {
            if (obj.hasOwnProperty(i)) {
                parts.push(encodeURIComponent(i) + "=" + encodeURIComponent(obj[i]));
            }
        }
        return parts.join("&");
    },
    fLogin: function() {
        console.log('INFOAPP: Login Facebook...');
        facebook.login(
                function(response) {
                    if(response.status === 'connected') {
                        window.localStorage.setItem('fbtoken', response.authResponse.accessToken);
                    } else {
                        alert('Falha ao autenticar-se no Facebook: ' + response.error);
                    }
                }, {scope: 'email,public_profile,user_friends'});
    }
};
facebook.initialize();

