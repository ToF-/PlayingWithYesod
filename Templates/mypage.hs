{-# LANGUAGE TemplateHaskell, OverloadedStrings, QuasiQuotes, MultiParamTypeClasses, TypeFamilies  #-}
import text.hamlet (htmlurl, hamlet)
import text.blaze.html.renderer.string (renderhtml)
import data.text (text)

data MyRoute = Home

render :: MyRoute -> [(Text,Text)] -> Text
render Home _ = "/home"

footer :: HtmlUrl MyRoute
footer = [hamlet|
    Return to #
    <a href=@{Home}>Homepage
    .
|]

main :: IO ()
main = putStrLn $ renderHtml $ [hamlet|
<body>
    <p>This is my page.
    ^{footer}
|] render
