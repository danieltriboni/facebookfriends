var index = {
    initialize: function() {
        this.bindEvents();
    },
    bindEvents: function() {
        document.addEventListener("deviceready", this.fOnDeviceReady, false);

    },
    fOnDeviceReady: function(){
        //TODO - Montar Carregamento de Algo no load da INDEX
        //alert(window.localStorage.getItem('fbtoken'));
    }
};
index.initialize();