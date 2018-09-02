module Data.AddressBook where

-- pulp dep install purescript-lists --save

import Prelude
import Data.List
import Data.Maybe              -- optionals
import Control.Plus (empty)    -- empty valu
import Control.Monad.Eff
import Control.Monad.Eff.Console

---- types ----
type Entry =
    { firstName :: String
    , lastName  :: String
    , address   :: Address
    }

type Address =
    { street :: String
    , city   :: String
    , state  :: String
    }

type AddressBook = List Entry


---- top level value declaration/binding ----
emptyBook :: AddressBook
emptyBook = empty              -- from control Plus


---- functions ----
showEntry :: Entry -> String
showEntry entry =  entry.lastName  ++ ", "
                ++ entry.firstName ++ ": "
                ++ showAddress entry.address

showAddress :: Address -> String
showAddress address =  address.street  ++ ", "
                    ++ address.city    ++ ", "
                    ++ address.state


insertEntry :: Entry -> AddressBook -> AddressBook
-- insertEntry entry book = Cons entry book
insertEntry = Cons -- eta conversion

-- findEntry :: String -> String -> AddressBook -> Maybe Entry
-- findEntry first last book = head $ filter filterEntry book
-- findEntry first last book = ( head <<< filter filterEntry ) book -- function backward composition
findEntry :: String -> String -> AddressBook -> Maybe Entry
findEntry first last = head <<< filter filterEntry -- eta conversion
    where
    filterEntry :: Entry -> Boolean
    filterEntry entry = entry.firstName == first && entry.lastName == last

findEntryByStreet :: String -> AddressBook -> Maybe Entry
findEntryByStreet streetaddress =  head <<< filter (\x -> x.address.street == streetaddress)

maybeEntryToString :: Maybe Entry -> String
maybeEntryToString = maybe "Entry not Found" showEntry
-- maybeEntryToString maybeEntry =
--     case maybeEntry of
--         Just entry  -> showEntry entry
--         Nothing     -> "Entry not Found"

containsEntry :: String -> String -> AddressBook -> Boolean
containsEntry first last = not $ null <<< filter (\x -> x.firstName == first && x.lastName == last)

removeDuplicateEntry :: AddressBook -> AddressBook
removeDuplicateEntry = nubBy (\x y -> x.firstName == y.firstName && x.lastName == y.lastName)


---- Types for filter and head will be deduced to:
-- filter :: ( Entry -> Boolean ) -> AddressBook -> AddressBook
-- head :: AddressBook -> Maybe Entry

---- probably not so good style
-- printMaybeEntry :: forall a. Maybe Entry -> Eff ( console :: CONSOLE | a ) Unit
-- printMaybeEntry maybeEntry =
--     case maybeEntry of
--         Just entry  -> log $ showEntry entry
--         Nothing     -> log "Entry not Found"

-- printEntry :: forall a. String -> String -> List Entry -> Eff ( console :: CONSOLE | a ) Unit
-- printEntry first last book = printMaybeEntry $ findEntry first last book
-- printEntry = (((printMaybeEntry <<<) <<<) <<<) findEntry -- eta
