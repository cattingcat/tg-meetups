{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase    #-}
{-# LANGUAGE TypeOperators #-}

module SampleApi (runApi) where

import           Data.Aeson
import           GHC.Generics             (Generic)
import           Network.Wai
import           Network.Wai.Handler.Warp
import           Servant
import           System.IO

-- * api
type ItemApi = "item" :> Get '[ JSON] [Item] :<|> "item" :> Capture "itemId" Integer :> Get '[ JSON] Item

itemApi :: Proxy ItemApi
itemApi = Proxy

-- * item
data Item =
  Item
    { itemId   :: Integer
    , itemText :: String
    }
  deriving (Eq, Show, Generic)

instance ToJSON Item

instance FromJSON Item

-- * app
runApi :: IO ()
runApi = do
  let port = 5000
      settings = setPort port $ setBeforeMainLoop (hPutStrLn stderr ("listening on port " ++ show port)) defaultSettings
  runSettings settings =<< mkApp

mkApp :: IO Application
mkApp = return $ serve itemApi server

server :: Server ItemApi
server = getItems :<|> getItemById

getItems :: Handler [Item]
getItems = return [exampleItem]

getItemById :: Integer -> Handler Item
getItemById =
  \case
    0 -> return exampleItem
    _ -> throwError err404

exampleItem :: Item
exampleItem = Item 0 "example item"
