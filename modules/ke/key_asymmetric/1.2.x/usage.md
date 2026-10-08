<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Asymmetric Keys extends the Key module with two Key Type plugins — `asymmetric_private` (private keys) and `asymmetric_public` (public keys / X.509 certificates) — so public/private key material can be stored and managed as Key entities, validated by phpseclib.

---

The module adds two `KeyType` plugins to the Key ecosystem: **Private key** (`asymmetric_private`) and **Public key/certificate** (`asymmetric_public`), both using the `textarea_field` key input. When you save a key of these types, the value is validated with the **phpseclib** library; if it is recognised, extracted metadata (format, algorithm, key size, hashing algorithm, fingerprint, and — for certificates — subject/issuer/validity) is stored in the key's *key type settings* config so Drupal code can inspect the key without parsing the raw value. A **"Skip key validation"** checkbox accepts any value as-is (no metadata then), and a **passphrase** field (never stored) validates password-protected private keys. The public key type adds one UI-editable setting, **`private_key`**, a reference to a corresponding `asymmetric_private` key so applications can recognise a key pair. A helper service, `key_asymmetric.key_pair` (`getKeyProperties()`), returns the same metadata for a raw key string. The module deliberately does **not** reformat values or generate keys (`generateKeyValue()` throws) — it only stores and describes them. It exists as a separate module purely because of its phpseclib dependency; combine it with Key + Encrypt + an encryption method for actual asymmetric encryption.

---

- Store an RSA private key securely as a Drupal Key entity (type `asymmetric_private`).
- Store a public key or X.509 certificate as a Key entity (type `asymmetric_public`).
- Keep a public/private key pair together and link them via the public key's `private_key` setting.
- Let an external library retrieve a stored private key through the Key API.
- Inspect a stored key's format/algorithm/key size from its key type settings without parsing the PEM.
- Read a certificate's subject, issuer and validity (not_before/not_after) from stored metadata.
- Validate a pasted key with phpseclib on save to catch malformed key material early.
- Use the "Info" button on the key form to display a key's detected properties.
- Accept a non-standard key value by ticking "Skip key validation" (stored without metadata).
- Validate a password-protected private key by entering its passphrase (not stored) on save.
- Provide keys for signing data (private key) inside a Drupal application.
- Provide a public key so third parties can encrypt data only the private-key holder can decrypt.
- Filter available keys programmatically by type via `key.repository->getKeysByType('asymmetric_public')`.
- Select suitable keys by inspecting stored `format`/`private_key` metadata in code.
- Back an API integration (e.g. JWT/OAuth) that needs a stored signing private key.
- Store an X.509 client certificate for mutual-TLS calls from Drupal.
- Compute/store a public key fingerprint for display or matching.
- Supply keys to the Encrypt module ecosystem for asymmetric encryption/decryption workflows.
- Recognise a key pair across applications by the stored private-key reference.
- Implement a custom key type subclassing `AsymmetricPrivateKeyType` to enforce specific formats/sizes.
- Manage many keys of differing formats (PKCS1/PKCS8, PEM or base64) under one consistent key type.
- Get a raw key string's properties via `key_asymmetric.key_pair` service without creating a Key entity.
