# Asymmetric Encryption — manual setup guide

**Asymmetric Encryption** (`asymmetric_encryption`) is a developer building block:
it provides a Drupal service that *seals* (encrypts) and *unseals* (decrypts) data
using public/private keypairs. It is built on the ParagonIE **Halite** library
(which wraps libsodium), so it uses anonymous public‑key sealing — any code can
encrypt with the public key, but only the holder of the private key can decrypt.

There is **no admin form and no UI**. Enabling the module registers a service
(`asymmetric_encryption.encrypt_data`) that your own code calls: `encrypt($text)`
seals a value, `decrypt($text)` unseals it. The encryption itself is sound —
Halite/libsodium generates a random keypair and handles nonces internally, so
there are no predictable IVs to worry about.

The one thing you must get right is **key storage**, because encryption is only as
safe as the private key behind it. The module writes the secret key to a
filesystem path (`../keys/private.key`), unencrypted and without a passphrase. You
must make sure that directory resolves **outside the web root** and is locked down
with tight filesystem permissions so it can never be served or read by other
users. Never commit a private key to version control, and treat it like any other
secret — ideally kept out of the deployment artifact entirely. This version
(1.2.x) supports Drupal 8, 9, and 10.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the Halite library and the
   module with Composer, then enable it.

## Where it lives in the admin menu

Nowhere. Asymmetric Encryption is a code‑level service with no admin pages, no
settings form, and no permissions. You interact with it only from PHP.

## How to use it

1. Install the Halite library and the module (see
   [Installation](installation/index.md)).
2. From your own module or code, fetch the service and call it:

   ```php
   $crypto = \Drupal::service('asymmetric_encryption.encrypt_data');
   $sealed = $crypto->encrypt($plaintext);   // Halite Crypto::seal (public key)
   $plain  = $crypto->decrypt($sealed);      // Halite Crypto::unseal (secret key)
   ```

   Store the sealed string as‑is. A helper (`encryptElementsStringConvert()`) walks
   an array and encrypts/decrypts each scalar element for you.
3. **Protect the key directory.** The keypair is generated once
   (`KeyFactory::generateEncryptionKeyPair()`); the secret key lands at
   `../keys/private.key` relative to the PHP working directory. Verify that path
   resolves outside the web root and lock down its permissions. To rotate keys,
   regenerate the keypair and re‑encrypt any existing data.

> **Known issue:** on the branch where the Halite library is missing, `decrypt()`
> references an undefined `$this->loggerFactory`, which will raise an error. Make
> sure Halite is actually installed (see Installation) so that branch is never hit.
