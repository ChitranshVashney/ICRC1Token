Deploy the canister:
Deploy the canister using the minter identity:

```
dfx deploy icrc1_ledger_canister --argument="(record {
    token_symbol = \"CHINUICP\";
    token_name = \"Chinu Internet Computer Protocol\";
    minting_account = record { owner = principal \"$(dfx identity get-principal)\" };
    transfer_fee = 1000;
    metadata = vec {};
    feature_flags = opt record {icrc2 = true};
    initial_balances = vec { record { record { owner = principal \"$(dfx identity get-principal user1)\"; }; 10000; }; };
    archive_options = null;
})"
```

Deploy the Holder Canister:
You need to install the canister and pass any required initial arguments.

```
dfx canister install holder_canister
```

### Interacting with the Canisters

Set Allowance:
Allow the holder canister to transfer tokens on behalf of the user1:

```
dfx canister --identity=user1 call icrc1_ledger_canister approve "(principal \"$(dfx canister id holder_canister)\", 100)"
```

Deposit Tokens:
Have 'user1' call the deposit function to move tokens to the holder canister:

```
dfx canister --identity=user1 call holder_canister deposit "(100)"
```

Transfer Tokens:
Call the transfer function to send tokens back to the user from the holder canister:

```
dfx canister --identity=user1 call holder_canister transfer "(50)"
```
