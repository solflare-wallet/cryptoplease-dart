import 'package:solana/solana.dart';

Future<void> airdrop(
  RPCClient client,
  String walletAddress, {
  int? sol,
  int? lamports,
}) async {
  // Request some tokens first
  final int? amount = sol != null ? sol * lamportsPerSol : lamports;
  if (amount == null) {
    throw const FormatException('either specify "sol" or "lamports"');
  }
  final txSignature = await client.requestAirdrop(
    address: walletAddress,
    lamports: amount,
  );
  await client.waitForSignatureStatus(txSignature, Commitment.finalized);
}
