// ignore_for_file: sort_constructors_first

import 'dart:async';

import 'package:solana/src/common/byte_array.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/encoder/signature.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:solana/src/signer/signer_base.dart';

typedef ColdAsyncMessageSign = Future<SignedTx> Function({required Iterable<int> data});
typedef ColdAsyncSign = Future<Signature> Function({required Iterable<int> data});

abstract class ColdWalletSignatureProvider {
  ColdAsyncMessageSign signMessage;
  ColdAsyncSign sign;

  ColdWalletSignatureProvider({required this.signMessage, required this.sign});
}

class SignerColdWallet extends Signer {
  SignerColdWallet({
    required this.coldWalletSignatureDelegate,
    required String publicKey,
  }) : _publicKey = publicKey;

  final String _publicKey;
  final ColdWalletSignatureProvider coldWalletSignatureDelegate;

  @override
  String get address => _publicKey;

  @override
  SignerType get signerType => SignerType.coldWallet;

  @override
  Future<SignedTx> signMessage({
    required Message message,
    required String recentBlockhash,
  }) {
    final compiledMessage = message.compile(
      recentBlockhash: recentBlockhash,
      feePayer: this,
    );
    final ByteArray data = compiledMessage.data;
    return coldWalletSignatureDelegate.signMessage.call(data: data);
  }

  @override
  Future<Signature> sign(Iterable<int> data) => coldWalletSignatureDelegate.sign.call(data: data);
}
