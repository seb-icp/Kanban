import Array "mo:base/Array";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Nat32 "mo:base/Nat32";
import DB "mo:crud/Database";

import Types "./Types";

actor {

    type Id = Types.Id;
    type Card = Types.Card;
    type Column = Types.Column;

    func mirror (n : Nat32) : Nat32 {   //needed to get a function of type Nat32 -> Hash (Type Hash is type Nat32)
        return (n);
    };

    let dbCards = DB.Database<Id, Card>(Types.getNextId, Nat32.equal, #hash mirror); //The hash is the Nat32 itself
    let dbColumns = DB.Database<Id, Column>(Types.getNextId, Nat32.equal, #hash mirror);
    var lastId : Id = 0; 

    public func addColumn(title: Text) : async Nat32 {
        dbColumns.create({ title; })
    };

    public func readColumn(columnId: Nat32) : async DB.Res<Column> {
        dbColumns.read(columnId)
    };

    public func updateColumn(columnId: Nat32, column: Column) : async DB.Res<()> {
        dbColumns.update(columnId, column)
    };

    func deleteColumn(id: Id) : DB.Res<()> {
        dbCards.delete(id)
    };

    public func addCard(title: Text, description: Text, columnId: Nat32) : async DB.Res<Id> {
        lastId +=1;
        // Ensure column already exists
        switch (dbColumns.read(columnId)) {
            case (#ok(_)) #ok(dbCards.create({ title; description; columnId }));
            case (#err(e)) #err(e);
        }
        
    };

    public func readCard(cardId: Id) : async DB.Res<Card> {
        dbCards.read(cardId)
    };

    public func updateCard(cardId: Id, card: Card) : async DB.Res<()> {
        dbCards.update(cardId, card)
    };

    public func deleteCard(id: Id) : async DB.Res<()> {
        dbCards.delete(id)
    };


    public query func howManyCards() : async Nat32 {
        (lastId);
    };



    public func test () : async () {
        ignore (addColumn("Todo"));
        ignore (addColumn("InProgress"));
        ignore (addColumn("Done"));
        ignore (addCard("Seb", "Hello World", 0));
        ignore (addCard("Seba", "Hello World", 1));
        ignore (addCard("Sebas", "Hello World", 2));
        return ();
    }
    


};
