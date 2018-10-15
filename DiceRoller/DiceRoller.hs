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

getRandom :: RandomGen (stdGen) => stdGen -> (stdGen, Int)
getRandom gen = (gen',value)
    where
    (value,gen') = randomR (1,6) gen

getHomeR :: Handler Html
getHomeR = do
    ref <- fmap genRef getYesod
    dice <- liftIO $ atomicModifyIORef ref getRandom
    defaultLayout [whamlet|
        <p>Dice Roller:#{show dice}
    |]

main :: IO ()
main = do
    g <- newStdGen
    r <- newIORef g
    warp 3000 DiceRoller { genRef = r }

