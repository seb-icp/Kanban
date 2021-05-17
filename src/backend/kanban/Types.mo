import Nat32 "mo:base/Nat32";

module {

    public type Id = Nat32;

    // A column contains a collection of cards
    public type Column = {
        title: Text;
    };

    // A card contains a title and description of the work to be done
    public type Card = {
        title: Text;
        description: Text;
        columnId: Nat32;
    };

    public func getNextId(card: Any, id: ?Id) : Id {
        switch (id) {
            case (?id) id + 1;
            case (null) 0;
        }
    };

};