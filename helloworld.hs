{-# LANGUAGE TemplateHaskell, OverloadedStrings, QuasiQuotes, MultiParamTypeClasses, TypeFamilies  #-}
import Yesod

data HelloWorld = HelloWorld

mkYesod "HelloWorld" [parseRoutes|
/ HomeR GET
|]

instance Yesod HelloWorld

getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|Hello World!|]

main :: IO ()
main = warp 3000 HelloWorld
