<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EncryptionMethod plugins

Four Encrypt-framework `EncryptionMethod` plugins, in
`src/Plugin/EncryptionMethod/`, all extending `Drupal\encrypt\Plugin\EncryptionMethod\EncryptionMethodBase`.
Each implements `encrypt($text, $key)`, `decrypt($text, $key)`, and `checkDependencies($text, $key)`.
`$key` is the raw PEM key material handed in by the Encryption Profile's Key entity.

## phpseclib methods

`PublicRsaEncryptionMethod` (id `public_rsa`, `key_type = {"pem_public"}`, `can_decrypt = FALSE`):
- `encrypt()`: `PublicKeyLoader::load($key)`; if the result is a `phpseclib3\Crypt\Common\PublicKey`
  it returns `base64_encode($publicKey->encrypt($text))`, else throws `EncryptException`
  ("not in a correct format").
- `decrypt()`: always throws `EncryptionMethodCanNotDecryptException`.

`PrivateRsaEncryptionMethod` (id `private_rsa`, `key_type = {"pem_private"}`):
- `encrypt()`: `PublicKeyLoader::load($key)`; if a `PrivateKey`, returns
  `base64_encode($privateKey->getPublicKey()->encrypt($text))` (derives the public key to encrypt).
- `decrypt()`: `PublicKeyLoader::load($key)->decrypt(base64_decode($text))`.

Both phpseclib plugins:
- Implement `ContainerFactoryPluginInterface`; the constructor injects
  `key_asymmetric.key_pair` (`KeyPairInterface $keyPair`) and merges `defaultConfiguration()` via
  `NestedArray::mergeDeep`.
- `checkDependencies()`: errors if `Composer\InstalledVersions::isInstalled('phpseclib/phpseclib')`
  is false, or (when a key is given) if `$this->keyPair->getKeyProperties($key, '')` contains a
  `cert` key ("Cannot use a certificate for this encryption.").
- Encryption uses phpseclib's own RSA defaults (padding is not overridden in this module).

## OpenSSL Seal methods (envelope encryption)

Raw RSA cannot encrypt large data, so these use `openssl_seal()`: a random symmetric key encrypts the
data with **AES256**, and RSA encrypts that symmetric key. Output is three base64 parts joined by
`ENVELOPE_SEPARATOR` (`,`): `base64(sealed) . "," . base64(ekv[0]) . "," . base64(iv)` — sealed
message, encrypted symmetric key, and the 16-byte IV (`openssl_random_pseudo_bytes(16)`).

`PublicOpenSslSealEncryptionMethod` (id `public_openssl_seal`, `key_type = {"pem_public"}`):
- `encrypt()`: `openssl_pkey_get_public($key)` then `openssl_seal($text, $sealed, $ekv, [$pubKey], "AES256", $iv)`.
- `decrypt()`: returns `$text` unchanged (a public key cannot decrypt).

`PrivateOpenSslSealEncryptionMethod` (id `private_openssl_seal`, `key_type = {"pem_private"}`,
implements `ContainerFactoryPluginInterface`):
- `create()` injects the `state` service.
- `encrypt()`: loads the private key with `openssl_pkey_get_private($key, $this->getPassPhrase($key))`,
  derives the public key via `openssl_pkey_get_details()`, then `openssl_seal(...)` as above.
- `decrypt()`: splits `$text` on `,`; if not exactly 3 parts returns `$text` unchanged; otherwise
  `openssl_open(base64_decode(part0), $decrypted, base64_decode(part1), $privKey, "AES256", base64_decode(part2))`.
- `getPassPhrase($key_value)` (private): reads the passphrase from the State API key
  `encrypt_rsa.private.<md5($key_value)>.passphrase` (default `''`). Per the README there is no UI for
  this — a passphrase-protected private key needs that State value set out of band. The `md5()` is only
  a lookup index for the State key, not a security control.

Both OpenSSL Seal plugins' `checkDependencies()` error only if the `openssl` PHP extension is not loaded.
