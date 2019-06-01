/*function func() {

}
*/

var stations = {
   "United States": {
        "Illinois": {
            "Peoria": {
                "Illinois Statewide Emergency Management and ISP": "http://relay.broadcastify.com/x3q4zn0tvd7wrp8.mp3",
                "Logan-Trivoli Fire and Rescue": "http://relay.broadcastify.com/7pkt0vhbd892y5f.mp3",
                "Peoria City Fire Dispatch - PEOR 1 and 2": "http://relay.broadcastify.com/pb1jvyf5qr8m0s2.mp3",
                "Peoria City Police Dispatch - PREP 1": "http://relay.broadcastify.com/hr7wbx2fqvy5t0s.mp3",
                "Peoria County Fire - Digital": "http://relay.broadcastify.com/g34bvrxqmd0t5hs.mp3",
                "Peoria County Sheriff Dispatch": "http://relay.broadcastify.com/xg2bhntz48my70s.mp3",
            },
            "Tazewell": {
                "Deer Creek Fire and EMS Dispatch": "http://relay.broadcastify.com/q42bmd350p6sk81.mp3",
                "Tazewell County Police and Fire": "http://relay.broadcastify.com/gp9snj0yw72h4z8.mp3",
                "Illinois Statewide Emergency Management and ISP": "http://relay.broadcastify.com/x3q4zn0tvd7wrp8.mp3",
                "Morton Fire": "http://relay.broadcastify.com/21c5rxtwb8gkzfs.mp3",
                "Tazewell County Sheriff, Pekin Police and Fire - TAZCOM": "http://relay.broadcastify.com/b4v78rn9w1xmg3h.mp3",
                "Washington Police and Fire, Northern Tazewell Fire": "http://relay.broadcastify.com/vwqyc1j0tb8zs7f.mp3",
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
