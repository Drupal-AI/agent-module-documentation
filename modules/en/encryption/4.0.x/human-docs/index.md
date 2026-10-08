# Encryption — manual setup guide

**Encryption** (`encryption`) supplies simple two-way (symmetric) encryption and
decryption for other code to use. It exposes an `encrypt()` / `decrypt()` service
built on **AES-256-CTR** through PHP's OpenSSL, with the encryption key held in
`settings.php`. It has **no module dependencies**. This is a developer-oriented
building block, not an end-user feature — it is a lightweight alternative to the
full [Encrypt](https://www.drupal.org/project/encrypt) / Key ecosystem for when a
module just needs to keep a value out of the database in clear text.

The design gets the important things right. The key lives in
`$settings['encryption_key']` in `settings.php` — not in configuration and not in
the database — so it is neither exported to Git nor present in a database dump,
which is the correct place for a symmetric key. Each encryption generates a fresh
random IV that is prepended to the ciphertext, as CTR mode requires.

Understand its scope: it defends data **at rest** against a database-only
compromise (a leaked dump, or SQL injection reading a column). It does **not**
protect against an attacker who can read `settings.php` or execute code, because
they have the key. And CTR is a confidentiality mode — treat it as protecting
secrecy, not as a tamper-proofing guarantee, unless you have verified the
integrity handling for your use.

> **Note on the release.** This module is still under active development and the
> encrypted value format has not been finalized, so values encrypted with one
> release may become unreadable after an upgrade until an upgrade path is
> provided. Keep this in mind before storing long-lived encrypted data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set the encryption key in `settings.php`.

There is **no configuration page** for this module — it is a code-facing service.
The only setup step is placing the encryption key in `settings.php`, described in
Installation.

## How to use it

The module provides a service other code calls. For example:

```php
// Get the encryption service.
$encryption_service = \Drupal::service('encryption');

// Encrypt and later decrypt a value.
$encrypted_value = $encryption_service->encrypt('big time secrets!');
$decrypted_value = $encryption_service->decrypt($encrypted_value);
```

There is also an `EncryptionTrait` you can add to a configuration form handler to
get `encrypt()` / `decrypt()` helpers — useful for storing a secret entered in a
settings form without exposing it in exported configuration.

Before any of this works, the encryption key must be set — see
[Installation](installation/index.md).
