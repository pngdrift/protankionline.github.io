const IS_PROD = window.location.href.indexOf("web-temp") ? false : true;
const PROD_PATH = "https://tankionline.com";
const TEMP_PATH = "https://web-temp.tankionline.com";
const ID_BLOCK = "event-block";
const ID_BLOCK_SCRIPT = "event-block-script";

const LANGS = ['ru', 'en', 'de', 'pl', 'br', 'es', 'fa'];
const DEF_LANG = 'en';

const EVENTS = [
    {
        name: "yin_yang",
        landingPath: "/pages/yin_yang/",
        dates: [{ dateStart: dateFrom("february 4, 2020 5:00:01"), dateEnd: dateFrom("february 29, 2020 05:00:00") }],
        ru : { isActive : true, linkPathParams : "?lang=ru", imagePath : "/images/yin_yang_ru.png" },
        en : { isActive : true, linkPathParams : "?lang=en", imagePath : "/images/yin_yang_en.png" },
        de : { isActive : true, linkPathParams : "?lang=de", imagePath : "/images/yin_yang_en.png" },
        pl : { isActive : true, linkPathParams : "?lang=pl", imagePath : "/images/yin_yang_en.png" },
        br : { isActive : true, linkPathParams : "?lang=br", imagePath : "/images/yin_yang_en.png" },
        es : { isActive : true, linkPathParams : "?lang=es", imagePath : "/images/yin_yang_en.png" },
        // fa : { isActive : true, linkPathParams : "?lang=fa", imagePath : "/images/halloween_en.jpg" },
        countDownCss: "font-family: DinDisplay, serif;" +
          "color: #000;" +
          "font-weight: 600;" +
          "margin-top: 25px;" +
          "font-size: 70px!important;" +
          "display: block;" +
          "text-align: center;" +
          "margin-left: -20px;",
            countDownDigit: "display: inline-block; margin-left: 115px;",
            customStyle: function(lang) {
            return (lang  === 'br' || lang === 'es') ? "margin-top: 123px;" : "margin-top: 115px;";
          },
          eventBlock: function (imagePath) {
            return "background: url("+imagePath+") no-repeat;" +
              "background-size: contain;" +
              "width: 375px;" +
              "height: 234px;" +
              "margin-top: -226px;" +
              "cursor: pointer;";
        }
    },
     {
        name: "holi",
        landingPath: "/pages/holi/",
        dates: [{ dateStart: dateFrom("Mar 11, 2019 18:00:01"), dateEnd: dateFrom("Mar 26, 2019 05:00:00") }],
        ru : { isActive : true, linkPathParams : "?lang=ru", imagePath : "/images/holi_RU.jpg" },
        en : { isActive : true, linkPathParams : "?lang=en", imagePath : "/images/holi_EN.jpg" },
        de : { isActive : true, linkPathParams : "?lang=de", imagePath : "/images/holi_DE.jpg" },
        pl : { isActive : true, linkPathParams : "?lang=pl", imagePath : "/images/holi_PL.jpg" },
        br : { isActive : true, linkPathParams : "?lang=br", imagePath : "/images/holi_BR.jpg" },
        es : { isActive : true, linkPathParams : "?lang=es", imagePath : "/images/holi_ES.jpg" },
        fa : { isActive : true, linkPathParams : "?lang=fa", imagePath : "/images/holi_FA.jpg" },
        countDownCss: "font-family: DinDisplay, serif;" +
        "color: #EEFF30;" +
        "margin-top: 43px;" +
        "text-shadow: 0px 0px 25px #530BAE;" +
        "font-size: 48px!important;" +
        "display: block;" +
        "text-align: center;" +
        "margin-left: -42px;" +
        "font-style: italic;",
        countDownDigit: "display: inline-block; margin-left: 115px;",
        customStyle: function(lang) {
            return (lang  === 'br' || lang === 'es') ? "margin-top: 123px;" : "margin-top: 115px;";
        },
        eventBlock: function (imagePath) {
            return "background: url("+imagePath+") no-repeat;" +
                "background-size: contain;" +
                "width: 375px;" +
                "height: 234px;" +
                "margin-top: -226px;" +
                "cursor: pointer;";
        }
    }

]

const lang = initLanguage();
const event = getActiveByTime(EVENTS);

if(isAvailableScreen() && event && event[lang].isActive) {
    document.getElementById(ID_BLOCK).onclick = function () {
        window.location.href = event.landingPath + event[lang].linkPathParams;
    }
    setInterval(function() {
        var dateEnd =  event.dates.find(function(time) {
            return (time.dateEnd > new Date().getTime())
        }).dateEnd;
        var time_moscow = new Date().toLocaleString("en-US", {timeZone: 'Europe/Moscow'}),
            idEl = "countdown-time", now = new Date(time_moscow).getTime(),
            distance = dateEnd - now,
            days = Math.floor(distance / (1000 * 60 * 60 * 24)),
            hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)),
            minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60)),
            seconds = Math.floor((distance % (1000 * 60)) / 1000);

        days = ("0" + days).slice(-2); hours = ("0" + hours).slice(-2);
        minutes = ("0" + minutes).slice(-2);
        seconds = ("0" + seconds).slice(-2);

        document.getElementById(idEl).innerHTML =
            "<div id='digits'>" +
            "<span id='days' style='margin-right:30px'>"+ days + "</span>" +
            "<span id='hours'>" + hours + ":</span>" +
            "<span id='minutes'>"+ minutes + ":</span>" +
            "<span id='seconds'>"+ seconds + "</span>" +
            "</div>";
        if (distance < 0) { clearInterval(x);
            removeElement(document.getElementById(idEl));
        }
    }, 1000);

    document.getElementById('event-block').style.cssText = event.eventBlock(event[lang].imagePath);
    document.getElementById("countdown-digit").style.cssText = event.countDownDigit +  event.customStyle(lang);
    document.getElementById("countdown-time").style.cssText = event.countDownCss

} else  {try{removeElement(document.getElementById("event-block"));} catch (e) { }}


function initLanguage () {
    const langFromAttributeScript = document.getElementById(ID_BLOCK_SCRIPT).getAttribute("data-lang");
    if (isInArray(langFromAttributeScript, LANGS)) {
        return langFromAttributeScript;
    }
    return DEF_LANG;
}

function getActiveByTime(events) {
    const currentTime = new Date().getTime();
    return events.find(function(el) {
        return (isActiveEvent(el.dates))
    })
}

function isActiveEvent(dates) {
    const currentTime = new Date().getTime();
    return dates.find(function(el) {
        return (el.dateStart < currentTime && el.dateEnd > currentTime)
    })
}

function isAvailableScreen () {
    return window.innerWidth > 1000;
}

function isInArray(value, array) {
    return array.indexOf(value) > -1;
}

function dateFrom(str) {
    return new Date(str).getTime();
}

function lastDigitToWord(digit)
{
  var lastFigure = parseInt(digit.toString().substr(digit.toString().length - 1, 1));
  if (digit > 11 && digit < 15)
  {
    return  (lang == 'ru') ? 'ДНЕЙ' : 'DAYS';
  }
  else
  {
    if (lastFigure == 1) return (lang == 'ru') ? 'ДЕНЬ' : 'DAY';
    if (lastFigure > 1 && lastFigure < 5) return (lang == 'ru') ? 'ДНЯ' : 'DAYS';
    if (lastFigure == 0 || lastFigure >= 5) return (lang == 'ru') ? 'ДНЕЙ' : 'DAYS';
  }
}
