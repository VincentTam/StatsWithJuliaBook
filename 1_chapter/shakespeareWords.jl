using HTTP, JSON

data = HTTP.request("GET",
"http://www.gutenberg.org/files/53573/53573-0.txt")
vandercook = String(data.body)
vandercookWords = split(vandercook)

jsonWords = HTTP.request("GET",
"https://raw.githubusercontent.com/"*
"h-Klok/StatsWithJuliaBook/master/1_chapter/jsonCode.json")
parsedJsonDict = JSON.parse(String(jsonWords.body))

keywords = Array{String}(parsedJsonDict["words"])
numberToShow = parsedJsonDict["numToShow"]
wordCount = Dict([(x,count(w -> lowercase(w) == lowercase(x), vandercookWords))
                  for x in keywords])

sortedWordCount = sort(collect(wordCount),by=last,rev=true)
sortedWordCount[1:numberToShow]
