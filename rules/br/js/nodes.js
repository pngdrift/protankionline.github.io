if(typeof Sentry !== 'undefined') {
    Sentry.init({dsn: 'https://28d38300d93b4614b750dbf9f2eb499a@sentry.tankionline.com/31'});
}
try {
    var preferred = [];
    var preferedNodes = [];
    var nodesLocaleMap = [];
    var nodeNames = {};
    var currentCluster = 'eu';
    var hostArray = document.location.hostname.split('.');
    var hostLast = hostArray.pop();
    var hostPreLast = hostArray.pop();
    if ('3dtank.com' === hostPreLast + '.' + hostLast) {
        currentCluster = 'zh';
    }
    if (window.cluster) {
        currentCluster = cluster;
    }
    var nodesLocaleName = currentCluster.toUpperCase();

    function prepareNodes() {
        if (window.stat) {
            for (var node in stat.nodes) {
                var int = node.replace('us-', '').replace('main.', '').replace('c', '') * 1;
                createNode(int);
            }
        } else {
            for (var int = 1; int < 50; int++) {
                createNode(int);
            }
        }

    }
    function createNode(int) {
        preferred[int] = int;
        preferedNodes[int] = int;
        nodeNames[int] = {
            name: "c" + int,
            maxUsers: 2500
        };
        nodesLocaleMap[int] = nodesLocaleName + int;
    }
    prepareNodes();
    var serversMap = flipArray(nodesLocaleMap);
    Object.size = function (obj) {
        var size = 0, key;
        for (key in obj) {
            if (obj.hasOwnProperty(key))
                size++;
        }
        return size;
    };
    function flipArray(trans) {
        var key, tmp_ar = {};
        for (key in trans) {
            if (trans.hasOwnProperty(key)) {
                tmp_ar[trans[key]] = key;
            }
        }
        return tmp_ar;
    }

    function nodesToHosts() {
        var re = /^.*\.([^.]+)$/;
        for (var node in stat.nodes) {
            var nodeHost = node.match(re);
            if (nodeHost) {
                stat.nodes[nodeHost[1]] = stat.nodes[node];
            }
        }
    }

    Array.prototype.shuffle = function () {
        var i = this.length, j, temp;
        if (i === 0) {
            return this;
        }
        while (--i) {
            j = Math.floor(Math.random() * (i + 1));
            temp = this[i];
            this[i] = this[j];
            this[j] = temp;
        }
        return this;
    };
    function selectProperServer(first) {
        nodesToHosts();
        var firstVisit = first || false, minFill = 1, server, minNodes = [], maxNodes = [], online = 0, fill = 0;
        if (firstVisit) {
            for (var i = preferred.length; i > 0; i--) {
                var j = preferred[i];
                if (j && stat.nodes[nodeNames[j].name]) {
                    online = parseInt(stat.nodes[nodeNames[j].name].online, 10);
                    fill = online / nodeNames[j].maxUsers;
                    if (fill < minFill) {
                        return nodesLocaleMap[j];
                    }
                }
            }
        }

        for (var i in nodeNames) {
            if (nodeNames[i] && nodeNames[i].name && stat.nodes[nodeNames[i].name]) {
                online = parseInt(stat.nodes[nodeNames[i].name].online);
                fill = online / nodeNames[i].maxUsers;
                if (fill < minFill) {
                    minNodes.push(i);
                } else {
                    maxNodes.push(i);
                }
            }
        }
        if (minNodes.length) {
            server = minNodes.shuffle()[Math.floor(Math.random() * minNodes.length)];
        } else if (maxNodes.length) {
            server = maxNodes.shuffle()[Math.floor(Math.random() * maxNodes.length)];
        }
        return nodesLocaleMap[server];
    }
    function parseHash() {
        var param = {}, tmp, tmp2;
        tmp = (document.location.hash.substr(1)).split('&');
        for (var i = 0; i < tmp.length; i++) {
            tmp2 = tmp[i].split('=');
            if (tmp2[0] == '/server') {
                tmp2[0] = 'server';
            }
            param[tmp2[0]] = tmp2[1];
        }
        return param;
    }

} catch (err) {
    if(typeof Sentry !== 'undefined') {
        Sentry.captureException(err);
    }
}
