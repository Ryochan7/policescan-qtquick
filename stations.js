/*function func() {

}
*/

var stations = {
   "United States": {
        "Illinois": {
            "Peoria": {
                "Illinois Statewide Emergency Management and ISP": "http://relay.broadcastify.com/2hdmkps081zx9yj.mp3",
                "Logan-Trivoli Fire and Rescue": "http://relay.broadcastify.com/k5tnvx7bd1f6jc4.mp3",
                "Peoria City Fire Dispatch - PEOR 1 and 2": "http://relay.broadcastify.com/d7jqyn104fv9pb5.mp3",
                "Peoria City Police Dispatch - PREP 1": "http://relay.broadcastify.com/jmrdp1gy4c9b3kt.mp3",
                "Peoria County Fire - Digital": "http://relay.broadcastify.com/hmdcnr3yf4s5jtg.mp3",
                "Peoria County Sheriff Dispatch": "http://relay.broadcastify.com/2ryfzb85kqhmp19.mp3",
            },
            "Tazewell": {
                "Deer Creek Fire and EMS Dispatch": "http://relay.broadcastify.com/p6mz2sd95gnbqrj.mp3",
                "Tazewell County Police and Fire": "http://relay.broadcastify.com/k69t34scymqr8np.mp3",
                "Illinois Statewide Emergency Management and ISP": "http://relay.broadcastify.com/2hdmkps081zx9yj.mp3",
                "Morton Fire": "http://relay.broadcastify.com/mnbkzgw5qcr489v.mp3",
                "Tazewell County Sheriff, Pekin Police and Fire - TAZCOM": "http://relay.broadcastify.com/yw483tr7jznvpmh.mp3",
                "Washington Police and Fire, Northern Tazewell Fire": "http://relay.broadcastify.com/6231jsknbzq4td7.mp3",
            }
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
    var result = {};
    if (country in stations && region in stations[country] && county in stations[country][region])
    {
        for (var station in stations[country][region][county])
        {
            result[station] = stations[country][region][county][station];
        }
    }


    return result;
}
