import 'package:cryptography/cryptography.dart' as crypto;
import 'package:solana/src/base58/encode.dart';
import 'package:solana/src/common/byte_array.dart';

class Signature extends ByteArray {
  Signature.from(crypto.Signature signature) : _data = signature.bytes;
  Signature.fromBytes(List<int> bytes) : _data = bytes;

  final ByteArray _data;

  String toBase58() => base58encode(_data.toList(growable: false));

  @override
  Iterator<int> get iterator => _data.iterator;
}
