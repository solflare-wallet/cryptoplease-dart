enum SignerType { hotWallet, coldWallet }

abstract class Signer {
  SignerType get signerType;

  String get address;
}
