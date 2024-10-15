module MyModule::LandOwnershipRegistry {

    use aptos_framework::signer;

    /// Struct representing a piece of land and its current owner.
    struct Land has store, key {
        owner: address,
        description: vector<u8>, // Description or coordinates of the land
    }

    /// Function to register a new land by its owner.
    public fun register_land(owner: &signer, description: vector<u8>) {
        let land = Land {
            owner: signer::address_of(owner),
            description,
        };
        move_to(owner, land);
    }

    /// Function to transfer ownership of the land to another account.
    public fun transfer_ownership(sender: &signer, new_owner: address) acquires Land {
        let land = borrow_global_mut<Land>(signer::address_of(sender));
        land.owner = new_owner;
    }
}
