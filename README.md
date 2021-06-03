#  Acoola-Box-Backend

Utility for working with Get Outfit server written in [swift](https://swift.org).
- let to sheetURL URL of google sheet
## How it works
- call function with URL of google sheet
 ```swift
 var table = parser.fetchSheet(from: sheetURL)
 ```
- downloads a google sheet in .tsv format
- in a loop, for each line, download the product pages from link selected by the stylist
- parse the article, color and price of the product page
- save the received data in the tsv table

You can use [Xcode Playground](https://apps.apple.com/app/xcode/id497799835) for development

## Compile
```bash
swiftc acoola_get_parameters.swift
```

## Start
```bash
./acoola_get_parameters
```

