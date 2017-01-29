/*
Checagem do usuario se ja esta logado
copyright 2017 - Daniel Triboni
*/
var login = {
    initialize: function() {
        this.bindEvents();
    },
    bindEvents: function() {
        document.addEventListener("deviceready", this.fVerifyLogin, false);
    },
    fVerifyLogin: function(){
        if(window.localStorage.getItem('fbtoken') != null){
            $.mobile.loading('show', { text: 'Aguarde', textVisible: true, theme: 'a', textonly: false, html: '' });
            $('#userName').html('Ol&aacute; ' + window.localStorage.getItem('apelido').substr(0,20));
			if(window.localStorage.getItem('foto') == null){
				$('#userPic').attr('src', 'css/images/semfoto.png');
			}else{
				$('#userPic').attr('src', window.localStorage.getItem('foto'));
			}
			console.log('INFOAPP: LISTFRIENDS');
            $.mobile.changePage('#friendsPage'/*, {changeHash: false}*/);
            facebook.friends();
        }else{
            $('#form-login').show();
        }
    }
};
login.initialize();