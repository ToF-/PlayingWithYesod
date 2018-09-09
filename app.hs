{-# LANGUAGE TemplateHaskell, OverloadedStrings, QuasiQuotes, MultiParamTypeClasses, TypeFamilies  #-}
import Yesod
import Data.Text

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

getHomeR  = return $ object [("msg"::Text) .= ("Hello World"::Text)]

main :: IO ()
main = warp 3000 App
