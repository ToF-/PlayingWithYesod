{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import Yesod
import System.Random
import Data.IORef

data DiceRoller = DiceRoller { genRef :: IORef StdGen }

mkYesod "DiceRoller" [parseRoutes|
/ HomeR GET
|]

instance Yesod DiceRoller

getHomeR :: Handler Html
getHomeR = do
    r <- fmap genRef getYesod
    value <- liftIO $ atomicModifyIORef r $ \g -> let (v,g') = randomR (1::Int, 6) g in (g',v)
    defaultLayout [whamlet|
        <p>Dice Roller:#{show value}
    |]

main :: IO ()
main = do
    g <- newStdGen
    r <- newIORef g
    warp 3000 DiceRoller { genRef = r }

