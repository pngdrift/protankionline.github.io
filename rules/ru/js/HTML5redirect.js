//Глобальная переменная для лендинга
var TNKHTML5Redirect = false;

var TNKHTML5 = {
    _domains: (window.HTML5Domains ? HTML5Domains : []),
    _percentage: (window.HTML5Percentage ? HTML5Percentage : 0),
    // _URL: "https://" + document.location.host + "/html5/index.html" +
    // "?resources=https://s.%CLUSTER%.tankionline.com" +
    // "&config=https://c%NODE%.%CLUSTER%.tankionline.com/config.xml" +
    // "&locale=%LOCALE%&lang=%LOCALE%",
    _URL: ((navigator.sayswho[0] === 'Firefox' || navigator.sayswho[0] === 'Chrome') && isChrome76_OrLarge() && isAvailableOS()) ? (cluster !== 'us') ? "https://" + document.location.host + "/play/" +  document.location.hash : "https://" + document.location.host + "/play/?config-template=https://c{server}.us.tankionline.com/config.xml&resources=https://s.us.tankionline.com&server=1" + document.location.hash : false,
    _isLanding: null,
    init: function () {
        var self = this, html5, visit, flash;
        html5 = self.checkHTML5Cookie();
        flash = self.checkFlashCookie();
        visit = self.checkVisitCookie();
        //self._isLanding = self.checkIfLanding();

        if(globalLang == 'fa') {
            self.prepareURL();
            self.updateLink();
            Cookie.write('TNK_HTML5', true, 60 * 60 * 24 * 365, '/', '.tankionline.com');
        }

        //Уже играет на флеше или посещал, но не был направлен в HTML5-версию,
        //или не подходит браузер, или не подходит ширина экрана - на Flash
        if (flash || (visit && !html5) || !self.checkBrowserCompatibility() || !self.checkWindowWidth()) {
            Cookie.write('TNK_Flash', true, 60 * 60 * 24 * 365, '/', '.tankionline.com');
            return;
        }

        if (self.checkDomain() || html5 || self.checkPercentage()) {
            self.prepareURL();
            self.updateLink();
            Cookie.write('TNK_HTML5', true, 60 * 60 * 24 * 365, '/', '.tankionline.com');
            return;
        }
    },
    checkIfLanding: function () {
        return document.location.pathname.indexOf('/start') !== -1;
    },
    prepareURL: function () {
        var self = this;
        var server = selectProperServer();
        var node = serversMap[server];
        var locale = globalLang;

        if (globalLang == 'br' || globalLang == 'pt') {
            locale = 'pt_BR';
        }

        // self._URL = self._URL
        //     .replace(/%CLUSTER%/g, cluster)
        //     .replace(/%NODE%/g, node)
        //     .replace(/%LOCALE%/g, locale);
        // self._URL = self._URL

        if(globalLang == 'fa') {
            var paramsUrl = window.location.href.split('?')[1];
            // if(paramsUrl) self._URL += '&' + paramsUrl;
        }

        // Сервер больше не используется
        //if (self._isLanding) self._URL += "#/server=" + server;
    },
    updateLink: function () {
        var self = this;
        var fight = document.getElementById("fight");
        TNKHTML5Redirect = self._URL;
        if (fight) fight.href = self._URL;
    },
    checkDomain: function () {
        var self = this;
        return self._domains.indexOf(document.location.hostname) > -1;
    },
    checkBrowserCompatibility: function () {
        var UA = navigator.userAgent, versionOffset, version;
        if ((versionOffset = UA.indexOf("Chrome")) != -1) {
            version = parseInt(UA.substring(versionOffset + 7), 10);
            if (version > 55) return true;
        }

        if ((versionOffset = UA.indexOf("Firefox")) != -1) {
            version = parseInt(UA.substring(versionOffset + 8), 10);
            if (version > 52) return true;
        }
        return false;
    },
    checkPercentage: function () {
        var self = this;
        return parseInt(Math.random() * 100, 10) <= self._percentage;
    },
    checkHTML5Cookie: function () {
        return Cookie.read("TNK_HTML5");
    },
    checkFlashCookie: function () {
        return Cookie.read("TNK_Flash");
    },
    checkVisitCookie: function () {
        return Cookie.read("TNK_visit");
    },
    checkWindowWidth: function () {
        return window.innerWidth > 1366;
    }
};

var Cookie = {
    isSupported: function () {
        return !!navigator.cookieEnabled;
    },
    exists: function (name) {
        return document.cookie.indexOf(name + "=") + 1;
    },
    write: function (name, value, expires, path, domain, secure) {
        expires instanceof Date ? expires = expires.toGMTString()
            : typeof (expires) == 'number' && (expires = (new Date(+(new Date) + expires * 1e3)).toGMTString());
        var r = [name + "=" + encodeURIComponent(value)], s, i;
        for (i in s = {
            expires: expires,
            path: path,
            domain: domain
        })
            s[i] && r.push(i + "=" + s[i]);
        return secure && r.push("secure"), document.cookie = r.join(";"), true;
    },
    read: function (name) {
        var c = document.cookie, s = this.exists(name), e;
        return s ? decodeURIComponent(c.substring(s += name.length, (c.indexOf(";", s) + 1 || c.length + 1) - 1)) : "";
    },
    remove: function (name, path, domain) {
        return this.exists(name) && this.write(name, "", new Date(0), path, domain);
    }
};

TNKHTML5.init();
