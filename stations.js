/*function func() {

}
*/

var stations = {
   "United States": {
        "Illinois": {
            "Peoria": [
                {"name": "Illinois Statewide Emergency Management and ISP",
                "feedId": 10406,
                "url": "http://relay.broadcastify.com/2hdmkps081zx9yj.mp3"},

                {"name": "Logan-Trivoli Fire and Rescue",
                "feedId": 18278,
                "url": "http://relay.broadcastify.com/k5tnvx7bd1f6jc4.mp3"},

                {"name": "Peoria City Fire Dispatch - PEOR 1 and 2",
                "feedId": 20305,
                "url": "http://relay.broadcastify.com/d7jqyn104fv9pb5.mp3"},

                {"name": "Peoria City Police Dispatch - PREP 1",
                "feedId": 20307,
                "url": "http://relay.broadcastify.com/jmrdp1gy4c9b3kt.mp3"},

                {"name": "Peoria County Fire - Digital",
                "feedId": 11466,
                "url": "http://relay.broadcastify.com/hmdcnr3yf4s5jtg.mp3"},

                {"name": "Peoria County Sheriff Dispatch",
                "feedId": 20301,
                "url": "http://relay.broadcastify.com/2ryfzb85kqhmp19.mp3"},
            ],
            "Tazewell": [
                {"name": "Deer Creek Fire and EMS Dispatch",
                "feedId": 29995,
                "url": "http://relay.broadcastify.com/p6mz2sd95gnbqrj.mp3"},

                {"name": "Tazewell County Police and Fire - North",
                "feedId": 29257,
                "url": "http://relay.broadcastify.com/k69t34scymqr8np.mp3"},

                {"name": "Illinois Statewide Emergency Management and ISP",
                "feedId": 10406,
                "url": "http://relay.broadcastify.com/2hdmkps081zx9yj.mp3"},

                {"name": "Morton Fire",
                "feedId": 11720,
                "url": "http://relay.broadcastify.com/mnbkzgw5qcr489v.mp3"},

                {"name": "Tazewell County Sheriff, Pekin Police and Fire - TAZCOM",
                "feedId": 25126,
                "url": "http://relay.broadcastify.com/yw483tr7jznvpmh.mp3"},

                {"name": "Washington Police and Fire, Northern Tazewell Fire",
                "feedId": 18187,
                "url": "http://relay.broadcastify.com/6231jsknbzq4td7.mp3"},
            ]
        }
    }
}

function getCountries()
{
    var result = [];
    for (var country in stations)
    {
        result.push(country);
    }

    return result;
}

function getRegionsForCountry(country)
{
    var result = [];
    if (country in stations)
    {
        for (var region in stations[country])
        {
            result.push(region);
        }
    }

    return result;
}

function getCountiesForRegion(country, region)
{
    var result = [];
    if (country in stations && region in stations[country])
    {
        for (var county in stations[country][region])
        {
            result.push(county);
        }
    }


    return result;
}

function getStationsForCounty(country, region, county)
{
    var result = [];
    if (country in stations && region in stations[country] && county in stations[country][region])
    {
        for (var station in stations[country][region][county])
        {
            result.push(stations[country][region][county][station]);
        }
    }

    return result;
}
