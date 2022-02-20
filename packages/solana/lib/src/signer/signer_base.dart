import 'package:solana/solana.dart';
import 'package:solana/src/encoder/signature.dart' as solana_signature;

enum SignerType { hotWallet, coldWallet }

abstract class Signer {
  SignerType get signerType;

  String get address;

  /// Sign a solana program message
  Future<SignedTx> signMessage({
    required Message message,
    // FIXME: should be string (no knowledge of these structures is needed here)
    required String recentBlockhash,
  });

  /// Returns a Future that resolves to the result of signing
  /// [data] with the private key held internally by a given
  /// instance
  Future<solana_signature.Signature> sign(Iterable<int> data);
}
