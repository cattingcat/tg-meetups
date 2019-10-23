{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase    #-}
{-# LANGUAGE TypeOperators #-}

module WebApi.ItemApi
  ( ItemsApi
  , itemsServer
  ) where

import           Data.Aeson
import           GHC.Generics (Generic)
import           Servant

type GetById = "item" :> Capture "itemId" Integer :> Get '[ JSON] Item

type GetList = "item" :> Get '[ JSON] [Item]

type ItemsApi = GetById :<|> GetList

itemsServer :: Server ItemsApi
itemsServer = getItemById :<|> getItems

getItems :: Handler [Item]
getItems = return [exampleItem]

getItemById :: Integer -> Handler Item
getItemById =
  \case
    0 -> return exampleItem
    _ -> throwError err404

exampleItem :: Item
exampleItem = Item 0 "example item"

data Item =
  Item
    { itemId   :: Integer
    , itemText :: String
    }
  deriving (Eq, Show, Generic)

instance ToJSON Item

instance FromJSON Item
