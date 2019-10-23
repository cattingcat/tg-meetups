{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

module WebApi.Root where

import           Data.Aeson
import           GHC.Generics             (Generic)
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           System.IO
import           WebApi.ItemApi           (ItemsApi, itemsServer)
import           WebApi.KekPukApi         (KekPukApi, kekPukServer)

type ServerApi = KekPukApi :<|> ItemsApi

server :: Server ServerApi
server = kekPukServer :<|> itemsServer

runApi :: IO ()
runApi = do
  let port = 5000
      settings = setPort port $ setBeforeMainLoop (hPutStrLn stderr ("listening on port " ++ show port)) defaultSettings
  runSettings settings (serve (Proxy :: Proxy ServerApi) server)
