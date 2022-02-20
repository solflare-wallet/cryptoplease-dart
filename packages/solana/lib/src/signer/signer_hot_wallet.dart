import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/signer/signer_base.dart';

class SignerHotWallet extends Signer {
  /// The [signer] associated to this wallet. This is exported
  /// because it can be needed in some places.
  final Ed25519HDKeyPair signer;

  SignerHotWallet({
    required this.signer,
  });

  @override
  String get address => signer.address;

  @override
  SignerType get signerType => SignerType.hotWallet;
}
