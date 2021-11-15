class NoTokenAccountException implements Exception {
  const NoTokenAccountException(this._account, this._mint);

  @override
  String toString() =>
      'this is not a token account for $_account and token $_mint';

  final String _account;
  final String _mint;
}
