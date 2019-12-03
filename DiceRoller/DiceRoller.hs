{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
{-# LANGUAGE ViewPatterns      #-}
import Yesod
import System.Random

data DiceRoller = DiceRoller

mkYesod "DiceRoller" [parseRoutes|
/#Integer/ HomeR GET
|]

instance Yesod DiceRoller

getStdRandoms :: Integer -> IO [Integer]
getStdRandoms 0 = return []
getStdRandoms n = do
    r <- getStdRandom $ randomR (1::Integer,6)
    rs <- getStdRandoms (n - 1)
    return $ r : rs

getHomeR :: Integer -> Handler Html
getHomeR n = do
    dice <- liftIO $ getStdRandoms n
    defaultLayout [whamlet|
        <p>Dice Roller:#{show dice}
    |]

main :: IO ()
main = do
    warp 3000 DiceRoller

