/*function func() {

}
*/

var stations = {
   "United States": {
        "Illinois": {
            "Peoria": {
                "Illinois Statewide Emergency Management and ISP": "http://relay.broadcastify.com:80/2688078843.mp3",
                "Logan-Trivoli Fire and Rescue": "http://relay.broadcastify.com/534665862.mp3",
                "Peoria City Fire Dispatch - PEOR 1 and 2": "http://relay.broadcastify.com/796834349.mp3",
                "Peoria City Police Dispatch - PREP 1": "http://relay.broadcastify.com/892764013.mp3",
                "Peoria County Fire - Digital": "http://relay.broadcastify.com/978466158.mp3",
                "Peoria County Fire Dispatch - Analog": "http://relay.broadcastify.com/910249871.mp3",
                "Peoria County Sheriff Dispatch": "http://relay.broadcastify.com/249300614.mp3",
                "WX9PIA 444.050 Mhz Amateur Repeater": "http://relay.broadcastify.com/143165466.mp3",
            },
            "Tazewell": {
                "Deer Creek Fire Dispatch": "http://relay.broadcastify.com:80/1269221.mp3",
                "East Peoria Police and Fire": "http://relay.broadcastify.com:80/613663865.mp3",
                "Illinois Statewide Emergency Management and ISP": "http://relay.broadcastify.com:80/268807884.mp3",
                "Morton Fire": "http://relay.broadcastify.com:80/298110944.mp3",
                "Pekin Fire - North": "http://relay.broadcastify.com:80/430334611.mp3",
                "Pekin Police and Fire, Tazewell County Sheriff": "http://relay.broadcastify.com:80/15402082.mp3",
                "Washington Police and Fire, Northern Tazewell Fire": "http://relay.broadcastify.com:80/261742943.mp3",
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
