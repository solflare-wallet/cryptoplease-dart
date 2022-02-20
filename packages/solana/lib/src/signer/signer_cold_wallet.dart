import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/encoder/signature.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:solana/src/signer/signer_base.dart';

class SignerColdWallet extends Signer {
  SignerColdWallet({
    required String publicKey,
  }) : _publicKey = publicKey;

  final String _publicKey;

  @override
  String get address => _publicKey;

  @override
  SignerType get signerType => SignerType.coldWallet;

  @override
  Future<SignedTx> signMessage({
    required Message message,
    required String recentBlockhash,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Signature> sign(Iterable<int> data) {
    throw UnimplementedError();
  }
}
