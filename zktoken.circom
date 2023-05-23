include "./node_modules/circomlib/circuits/pedersen.circom";
include "./node_modules/circomlib/circuits/eddsamimcsponge.circom";


template zktoken() {
    signal input senderPubKey;
    signal input senderPrivKey;
    signal input senderBalance;
    signal input amountToSend;
    signal input receiverPubKey;
    signal input receiverBalance;
    signal input nullifier;
    
    signal output senderNewBalance;
    signal output receiverNewBalance;
    signal output newNullifier;

    // Validate that the sender's private key matches the public key
    component ecdsa = EdDSAMiMCSpongeVerifier();
    ecdsa.enabled <== 1;
    ecdsa.privIn <== senderPrivKey;
    ecdsa.pubIn <== senderPubKey;

    // Check that the sender has enough balance
    signal validBalance;
    validBalance <== senderBalance - amountToSend;

    // Calculate new balances
    senderNewBalance <== validBalance;
    receiverNewBalance <== receiverBalance + amountToSend;

    // Generate new nullifier
    component newNullifierHash = Pedersen(512);
    newNullifierHash.in[0] <== senderPrivKey;
    newNullifierHash.in[1] <== senderNewBalance;
    newNullifier <== newNullifierHash.out[0];
}

component main = zktoken();
