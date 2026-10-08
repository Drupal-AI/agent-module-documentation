# OpenPGP Encryption — manual setup guide

**OpenPGP Encryption** (`openpgp_encryption`) adds an **OpenPGP** encryption method
to Drupal's [Encrypt](https://www.drupal.org/project/encrypt) module ecosystem.
Once enabled, "OpenPGP" becomes one of the encryption methods you can choose when
you build an *encryption profile* in Encrypt — so data that flows through Encrypt
(field values, submitted data, and anything else other modules encrypt via
Encrypt) can be protected with public‑key cryptography.

OpenPGP is **asymmetric**: you encrypt with a **public key** and decrypt with the
matching **private key**. This module supports two common patterns:

- **Encrypt and decrypt in one profile** — use a **private key** in the profile.
  A PGP private key block also contains the public-key material, so a single
  profile holding the private key can both encrypt and decrypt.
- **Encrypt-only with a public key** — put only the **public key** in a profile
  and use it to encrypt. Because a public key cannot decrypt, you then create a
  *second* profile that holds the **private key** and use that profile when you
  need to decrypt the data later in Drupal.

The keys themselves are handled through the Encrypt/Key framework (the
[Key](https://www.drupal.org/project/key) module), which is where the security
lives. Treat the **private key** as a highly sensitive secret: store it outside
the web root, prefer an environment-variable-backed or file-based Key provider,
and **never commit a private key to version control**. A public key is not
secret and can be stored more freely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Encrypt dependency.

This module has **no settings form of its own**. It simply registers the OpenPGP
method; all setup happens inside the **Key** and **Encrypt** modules, described in
"How to use it" below.

## Where it lives in the admin menu

OpenPGP Encryption adds no admin page of its own. You work with it through:

- **Configuration → System → Keys** (`/admin/config/system/keys`) — to store your
  PGP public and/or private keys as Key entities.
- **Configuration → System → Encryption profiles**
  (`/admin/config/system/encryption/profiles`) — to create an encryption profile
  that uses the **OpenPGP** method and points at one of those keys.

## How to use it

1. **Store your PGP key(s) as Key entities.** In the Key module, add a key for
   your PGP **public key** and, where you need to decrypt in Drupal, another for
   your **private key**. Choose a key provider that keeps the private key out of
   the database and out of version control (for example an environment variable
   or a file outside the web root).
2. **Create an encryption profile** in the Encrypt module. Choose **OpenPGP** as
   the encryption method and select the key to use:
   - For encrypt-and-decrypt in one profile, select the **private** key.
   - For encrypt-only, select the **public** key, and create a second profile
     using the **private** key for decryption.
3. **Use the profile** wherever Encrypt is consumed (by field-encryption modules
   or your own code) to protect the relevant data.

Encrypted output is a standard PGP message block (`-----BEGIN PGP MESSAGE-----`
… `-----END PGP MESSAGE-----`) that only the private-key holder can decrypt.
