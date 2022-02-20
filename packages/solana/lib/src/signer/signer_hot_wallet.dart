import 'package:solana/solana.dart';
import 'package:solana/src/encoder/signature.dart' as solana_signature;
import 'package:solana/src/signer/signer_base.dart';

class SignerHotWallet extends Signer {
  SignerHotWallet({
    required Ed25519HDKeyPair keyPair,
  }) : _keyPair = keyPair;

  /// The [_keyPair] associated to this wallet. This is exported
  /// because it can be needed in some places.
  final Ed25519HDKeyPair _keyPair;
  Ed25519HDKeyPair getKeyPair() => _keyPair;

  @override
  String get address => _keyPair.address;

  @override
  SignerType get signerType => SignerType.hotWallet;

  @override
  Future<SignedTx> signMessage({
    required Message message,
    required String recentBlockhash,
  }) async {
    final compiledMessage = message.compile(
      recentBlockhash: recentBlockhash,
      feePayer: this,
    );

    final signature = await sign(compiledMessage.data);

    return SignedTx(
      signatures: [signature],
      messageBytes: compiledMessage.data,
    );
  }

  @override
  Future<solana_signature.Signature> sign(Iterable<int> data) async => _keyPair.sign(data);
}
