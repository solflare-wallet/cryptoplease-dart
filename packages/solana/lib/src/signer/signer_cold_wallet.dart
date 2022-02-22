// ignore_for_file: sort_constructors_first

import 'dart:async';

import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/encoder/signature.dart';
import 'package:solana/src/encoder/signed_tx.dart';
import 'package:solana/src/signer/signer_base.dart';

typedef ColdAsyncMessageSign = Future<SignedTx> Function({required Message message, required String recentBlockhash});
typedef ColdAsyncSign = Future<Signature> Function({Iterable<int> data});

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
  }) =>
      coldWalletSignatureDelegate.signMessage.call(message: message, recentBlockhash: recentBlockhash);

  @override
  Future<Signature> sign(Iterable<int> data) => coldWalletSignatureDelegate.sign.call(data: data);
}
