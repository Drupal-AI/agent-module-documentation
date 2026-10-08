# Real AES — manual setup guide

**Real AES** (`real_aes`) adds a strong, production‑grade **"Authenticated AES"**
encryption method to the [Encrypt](https://www.drupal.org/project/encrypt)
module. On its own, Encrypt provides the *framework* for encryption profiles but
ships no serious encryption method; Real AES fills that gap. It registers a
single encryption method plugin that performs **AES‑256 in CBC mode with an HMAC
for authentication**, delegating the actual cryptography to the well‑audited
[Defuse PHP‑Encryption](https://github.com/defuse/php-encryption) library.

"Authenticated" is the important word: the ciphertext's integrity is verified
*before* any decryption happens, which defeats a class of ciphertext‑tampering
attacks that plain CBC is vulnerable to. Real AES needs a **256‑bit key** managed
through the [Key](https://www.drupal.org/project/key) module (from a file, an
environment variable, or an off‑site key manager such as Lockr), referenced by an
Encrypt encryption profile. Once such a profile exists, any module that encrypts
through Encrypt — field encryption, stored API credentials, webform data, and so
on — transparently uses this method.

Real AES is a **library/plugin module with no UI or settings of its own**. You
never configure Real AES directly; you configure a standard Encrypt *encryption
profile* and choose "Authenticated AES (Real AES)" as its method. The module does
add a requirements check that warns you if the Defuse library isn't installed.
Its dependencies are the **Encrypt** module (`^3.0`) and the
**`defuse/php-encryption`** Composer library (`^2.0`), and in practice you'll also
use the **Key** module to hold the key.

This guide is written for a **human** getting the encryption stack set up. If you
want a terse, token‑cheap reference for an AI coding agent — including the plugin
details and how to encrypt/decrypt in code through a profile — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Defuse library) and enable it alongside Encrypt and Key.

## Where it lives in the admin menu

Real AES has no admin page of its own. You work with it entirely through the
Encrypt and Key modules' pages:

- **Keys** live at **Configuration → System → Keys**
  (`/admin/config/system/keys`).
- **Encryption profiles** live at **Configuration → System → Encryption
  profiles** (`/admin/config/system/encryption/profiles`), and it's there that
  "Authenticated AES (Real AES)" appears as an encryption method choice.

## How to use it

1. Enable `real_aes`, `encrypt`, and `key`.
2. Generate a random **256‑bit** key and store it securely — for example, write
   raw random bytes to a file outside the web root
   (`dd if=/dev/urandom bs=32 count=1 > /path/secret.key`).
3. Create a **Key** at `/admin/config/system/keys/add`: key type **Encryption**,
   key size **256**, and a provider such as **File** (stored outside the web
   root) or an off‑site manager. Avoid the *Configuration* provider outside of
   local development — it stores the key too openly for production.
4. Create an **encryption profile** at
   `/admin/config/system/encryption/profiles/add`: choose encryption method
   **Authenticated AES (Real AES)** and select the key from step 3.
5. **Test** the profile via **Operations → Test** on the profiles list.

From then on, point any Encrypt‑based feature at that profile. To rotate keys,
create a new profile with a new key and re‑encrypt the data. Because integrity is
checked before decryption, tampered ciphertext throws an error rather than
returning bad data.
