<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: an `Encryption` service exposing `encrypt()`/`decrypt()` built on ParagonIE Halite asymmetric sealing.
- When: you need to store data other code can encrypt with a public key and only decrypt with the private key.

---

- Requires the ParagonIE Halite library (libsodium) to be installed via Composer.
- Enable the module; it registers the `asymmetric_encryption.encrypt_data` service (`Encryption`). No admin form.

---

- `encrypt($text)` loads a public key and calls Halite `Crypto::seal()` (anonymous public-key encryption).
- `decrypt($text)` loads the secret key and calls `Crypto::unseal()`.
- Keys are generated once by `createKey()` using `KeyFactory::generateEncryptionKeyPair()` (random, not hardcoded).
- Halite/libsodium handles nonces internally, so there are no predictable IVs.
- The algorithm is sound; the main risk is key storage (see note): keys are written to a relative path `../keys/`.
- `KeyFactory::save()` stores the secret key to `../keys/private.key` without a passphrase — protect that directory.
- Because the path is relative to the PHP working directory, verify it resolves OUTSIDE the web root.
- Wrap `encrypt()`/`decrypt()` in your own code; the service is the integration point.
- Helper `encryptElementsStringConvert()` walks arrays to encrypt/decrypt each scalar element.
- `checkDependencies()` guards for the Halite class before running.
- Use for confidential field values or tokens you must round-trip.
- Encrypted output is a Halite sealed string; store it as-is.
- Rotate keys by regenerating the keypair and re-encrypting existing data.
- Ensure filesystem permissions on the key directory are locked down.
- Note a latent bug: `decrypt()` references an undefined `$this->loggerFactory` on the dependency-missing branch.
- Version 1.2.x supports Drupal 8/9/10.
