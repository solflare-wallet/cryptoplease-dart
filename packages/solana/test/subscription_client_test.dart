import 'package:solana/solana.dart';
import 'package:solana/src/signer/signer_hot_wallet.dart';
import 'package:solana/src/subscription_client/optional_error.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  test('accountSubscribe must return account owned by the system program',
      () async {
    const originalLamports = 10 * lamportsPerSol;
    final sender = SignerHotWallet(keyPair: await Ed25519HDKeyPair.random());
    final recipient = SignerHotWallet(keyPair: await Ed25519HDKeyPair.random());
    final rpcClient = RPCClient(devnetRpcUrl);
    final signature = await rpcClient.requestAirdrop(
      address: sender.address,
      lamports: originalLamports,
    );

    final client = await SubscriptionClient.connect(devnetWebsocketUrl);
    final OptionalError result =
        await client.signatureSubscribe(signature).firstWhere((_) => true);

    expect(result.err, isNull);
    // System program
    final accountStream = client.accountSubscribe(sender.address);

    // Now send some tokens
    final wallet = Wallet(signer: sender, rpcClient: rpcClient);
    await wallet.transfer(
      destination: recipient.address,
      commitment: Commitment.confirmed,
      lamports: lamportsPerSol,
    );

    final account = await accountStream.firstWhere(
      (Account data) => true,
    );

    expect(account.lamports, lessThan(originalLamports));
  });
}
