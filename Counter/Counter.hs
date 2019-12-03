{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import Yesod
import Data.IORef

data Counter = Counter { getCounter :: IORef Integer }

mkYesod "Counter" [parseRoutes|
/ HomeR GET
|]

instance Yesod Counter

increment :: Integer -> (Integer,Integer)
increment n = (n+1,value)
    where value = n

getHomeR :: Handler Html
getHomeR = do
    counter <- fmap getCounter getYesod
    value <- liftIO $ atomicModifyIORef counter increment
    defaultLayout [whamlet|
        <p>Counter:#{show value}
    |]

main :: IO ()
main = do
    ref <- newIORef 0
    warp 3000 Counter { getCounter = ref }
