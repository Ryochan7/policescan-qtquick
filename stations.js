/*function func() {

}
*/

var stations = {
   "United States": {
        "Illinois": {
            "Peoria": {
                "Illinois Statewide Emergency Management and ISP": "http://www.broadcastify.com/scripts/playlists/1/10406/-5891805236.m3u",
                "Logan-Trivoli Fire and Rescue": "http://www.broadcastify.com/scripts/playlists/1/18278/-5891805236.m3u",
                "Peoria City Fire Dispatch - PEOR 1 and 2": "http://www.broadcastify.com/scripts/playlists/1/20305/-5891805236.m3u",
                "Peoria City Police Dispatch - PREP 1": "http://www.broadcastify.com/scripts/playlists/1/20307/-5891805236.m3u",
                "Peoria County Fire - Digital": "http://www.broadcastify.com/scripts/playlists/1/11466/-5891805236.m3u",
                "Peoria County Fire Dispatch - Analog": "http://www.broadcastify.com/scripts/playlists/1/4374/-5891805236.m3u",
                "Peoria County Sheriff Dispatch": "http://www.broadcastify.com/scripts/playlists/1/20307/-5891104376.m3u",
                "W9UVI 147.0750 MHz Peoria AARC Repeater": "http://www.broadcastify.com/scripts/playlists/1/23099/-5891805236.m3u",
                "WX9PIA 444.050 Mhz Amateur Repeater": "http://www.broadcastify.com/scripts/playlists/1/7628/-5891805236.m3u",
            },
            "Tazwell": {
                "Deer Creek Fire Dispatch": "http://www.broadcastify.com/scripts/playlists/1/15467/-5891829104.m3u",
                "East Peoria Police and Fire": "http://www.broadcastify.com/scripts/playlists/1/1158/-5891829104.m3u",
                "Illinois Statewide Emergency Management and ISP": "http://www.broadcastify.com/scripts/playlists/1/10406/-5891829104.m3u",
                "Morton Fire": "http://www.broadcastify.com/scripts/playlists/1/11720/-5891829104.m3u",
                "Pekin and Schaeferville Fire - MABAS": "http://www.broadcastify.com/scripts/playlists/1/5026/-5891829104.m3u",
                "Pekin Fire - North": "http://www.broadcastify.com/scripts/playlists/1/11334/-5891829104.m3u",
                "Pekin Police and Fire, Tazewell County Sheriff": "http://www.broadcastify.com/scripts/playlists/1/18795/-5891829104.m3u",
                "Washington Police and Fire, Northern Tazewell Fire": "http://www.broadcastify.com/scripts/playlists/1/18795/-5891829104.m3u",
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
