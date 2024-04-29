import HashMap "mo:base/HashMap";
import Token "/Token.mo";

actor holder_canister {
  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.hash, Principal.equal);

  public shared (caller) func approve(amount : Nat) : async () {
    await Token.approve(caller, amount);
  };

  public shared (caller) func deposit(amount : Nat) : async () {
    let _ = await Token.transfer_from(caller, Principal.fromActor(this), amount);
    balances.put(caller, amount + balances.get(caller, 0));
  };

  public shared (caller) func transfer(amount : Nat) : async () {
    // Check if the user has enough balance
    let balance = balances.get(caller, 0);
    if (balance >= amount) {
      // Transfer tokens back to the user from the holder canister
      let _ = await Token.transfer(caller, amount);
      balances.put(caller, balance - amount);
    } else {
      throw Error.reject("Insufficient balance.");
    };
  };
};
