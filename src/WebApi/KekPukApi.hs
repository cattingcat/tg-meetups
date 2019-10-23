{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE LambdaCase    #-}
{-# LANGUAGE TypeOperators #-}

module WebApi.KekPukApi
  ( KekPukApi
  , kekPukServer
  ) where

import           Data.Aeson
import           GHC.Generics (Generic)
import           Servant

type GetById = "kekPuk" :> Capture "itemId" Integer :> Get '[ JSON] Item

type GetList = "kekPuk" :> Get '[ JSON] [Item]

type KekPukApi = GetById :<|> GetList

kekPukServer :: Server KekPukApi
kekPukServer = getKekPukById :<|> getKekPuk

getKekPuk :: Handler [Item]
getKekPuk = return [exampleItem]

getKekPukById :: Integer -> Handler Item
getKekPukById =
  \case
    0 -> return exampleItem
    _ -> throwError err404

exampleItem :: Item
exampleItem = Item 0 "kek puk item"

data Item =
  Item
    { itemId   :: Integer
    , itemText :: String
    }
  deriving (Eq, Show, Generic)

instance ToJSON Item

instance FromJSON Item
