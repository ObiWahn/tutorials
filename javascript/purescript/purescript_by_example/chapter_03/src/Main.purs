module Main where

import Prelude
import Control.Monad.Eff
import Control.Monad.Eff.Console

import Data.AddressBook
import Data.Maybe


main :: forall a. Eff( console :: CONSOLE | a ) Unit
main = do
    let address = { street: "123 Fake St.", city: "Faketown", state: "CA" }
    let entry = { firstName: "John", lastName: "Smith", address: address }
    let book1 = insertEntry entry emptyBook

    log "log $ showEntry entry"
    log $ showEntry entry

    log "log $ maybeEntryToString $ findEntry \"John\" \"Smith\" book1"
    log $ maybeEntryToString $ findEntry "John" "Smith" book1

    log "log $ maybeEntryToString $ findEntryByStreet1 \"123 Fake St.\"" 
    log $ maybeEntryToString $ findEntryByStreet "123 Fake St." book1

    log "contains Entry:"
    log $ show $ containsEntry "John" "Smith" book1

    let book2 = removeDuplicateEntry book1

    -- solution form book that did not make me happy :(
    let printEntry2 firstName lastName book = showEntry <$> findEntry firstName lastName book
    --let printEntry2 = (((showEntry <$>) <<<) <<<) <<< findEntry
    print $ printEntry2 "John" "Smith" book1
