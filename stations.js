/*function func() {

}
*/

var stations = {
   "United States": {
        "Illinois": {
            "Peoria": [
                {"name": "Illinois Statewide Emergency Management and ISP",
                "feedId": 10406},

                {"name": "Logan-Trivoli Fire and Rescue",
                "feedId": 18278},

                {"name": "Peoria City Fire Dispatch - PEOR 1 and 2",
                "feedId": 20305},

                {"name": "Peoria City Police Dispatch - PREP 1",
                "feedId": 20307},

                {"name": "Peoria County Fire - Digital",
                "feedId": 11466},

                {"name": "Peoria County Sheriff Dispatch",
                "feedId": 20301},
            ],
            "Tazewell": [
                {"name": "Deer Creek Fire and EMS Dispatch",
                "feedId": 29995},

                {"name": "Tazewell County Police and Fire - North",
                "feedId": 29257},

                {"name": "Illinois Statewide Emergency Management and ISP",
                "feedId": 10406},

                {"name": "Morton Fire",
                "feedId": 11720},

                {"name": "Tazewell County Sheriff, Pekin Police and Fire - TAZCOM",
                "feedId": 25126},

                {"name": "Washington Police and Fire, Northern Tazewell Fire",
                "feedId": 18187},
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
