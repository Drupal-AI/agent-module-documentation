# Asymmetric (public/private) keys — manual setup guide

**Asymmetric (public/private) keys** (`key_asymmetric`) extends the
[Key](https://www.drupal.org/project/key) module so you can store and manage
public/private key material — RSA private keys, public keys, and X.509
certificates — as first‑class Key entities. It adds two new **key types** to
Key's *Add key* form: **Private key** (`asymmetric_private`) and **Public
key/certificate** (`asymmetric_public`). Once a key is stored this way, other
Drupal code can look it up through the Key API instead of hard‑coding a path to a
PEM file.

When you paste a key and save it, the module validates the value with the
**phpseclib** library and records useful metadata about it — format, algorithm,
key size, fingerprint, and (for certificates) the subject, issuer, and validity
dates. That metadata is stored alongside the key so your code can inspect a key
without re‑parsing the raw material. A **Skip key validation** checkbox lets you
store an unusual value as‑is, and a **passphrase** field (never stored) lets you
validate a password‑protected private key. A public key can point at its matching
private key so applications can recognise the two as a pair.

The module deliberately does **not** generate keys or reformat what you paste — it
only stores and describes existing key material. It exists as a separate module
purely because of its phpseclib dependency. To actually encrypt or sign data,
combine it with Key plus the [Encrypt](https://www.drupal.org/project/encrypt)
module and an encryption method. It has no admin page of its own (the
[Key](https://www.drupal.org/project/key) module provides the *Keys* UI and its
permissions) and no Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its phpseclib
   dependency with Composer, and enable it alongside Key.

## Where it lives in the admin menu

Asymmetric Keys has no configuration page of its own. You work with it through
the Key module's screen at **Configuration → System → Keys**
(`/admin/config/system/keys`), which requires the **Administer keys** permission
that the Key module provides.

## How to use it

To store a key:

1. Go to **Configuration → System → Keys** and click **Add key**.
2. Give the key a label, then choose a **Key type** of **Private key** or
   **Public key/certificate** — the two types this module adds.
3. Choose how the value is provided (the **Key provider**). Paste the value into
   the textarea, or, for a real secret, use the *File* or *Environment* provider
   instead of storing it in configuration.
4. Optionally press the **Info** button to see the key's detected properties
   (format, algorithm, key size, fingerprint, certificate details) before saving.
5. For a password‑protected private key, enter its **passphrase** so validation
   can succeed — the passphrase is only used to validate and is never stored. If
   you need to store a value phpseclib does not recognise, tick **Skip key
   validation**.
6. When adding a **Public key/certificate**, you can set its **Private key**
   field to the corresponding `asymmetric_private` key, which links the two as a
   key pair.
7. Click **Save**.

Developers can read a stored key back through Key's repository service
(`\Drupal::service('key.repository')->getKey('my_key')`), filter keys by type
with `getKeysByType('asymmetric_public')`, or inspect a raw key string without
creating an entity via the `key_asymmetric.key_pair` service — see the
[`agent/`](../agent/start.md) docs for code examples.
