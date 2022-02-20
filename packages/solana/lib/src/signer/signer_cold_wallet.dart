import 'package:solana/src/signer/signer_base.dart';

class SignerColdWallet extends Signer {
  @override
  String get address => throw UnimplementedError();

  @override
  SignerType get signerType => SignerType.coldWallet;
}
