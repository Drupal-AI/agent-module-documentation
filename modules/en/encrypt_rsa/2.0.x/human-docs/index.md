# Encrypt RSA — manual setup guide

**Encrypt RSA** (`encrypt_rsa`) adds an **RSA (public‑key) encryption method** to
the [Encrypt](https://www.drupal.org/project/encrypt) module. It uses the
well‑maintained **phpseclib** crypto library and stores its key pairs through the
**Key Asymmetric** module (`key_asymmetric`), so private keys live in proper Key
providers rather than scattered through configuration.

Asymmetric cryptography is the point of this module. With ordinary symmetric
encryption the same key both encrypts and decrypts, which means anyone who can
read that key can read your data. RSA splits the two: you encrypt with a **public
key** that can be stored anywhere, and only the matching **private key** can
decrypt. That lets you, for example, encrypt data on the site while keeping the
ability to decrypt it confined to a separate, better‑protected environment.
Because RSA itself can only encrypt small amounts of data, the module uses an
"envelope" technique (via OpenSSL / phpseclib) — a random symmetric key encrypts
the data and RSA encrypts that key. In practice, use RSA here for **small
payloads or key‑wrapping**, not for bulk data.

This module has **no admin form of its own** and no configuration route. You set
it up through the Encrypt and Key modules' own pages: create an RSA key pair as
Key entities, then create an Encryption Profile that uses one of the RSA methods
this module provides (for example *Public OpenSSL Seal*). It has no
access‑control role — it only provides an encryption method.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Encrypt /
   Key Asymmetric dependencies, and enable it.

There is **no dedicated configuration page** for this module — you set it up on
the Key and Encrypt module forms, described below.

## Where it lives in the admin menu

Everything is configured under the **Key** and **Encrypt** admin sections:

- **Configuration → System → Keys** (`/admin/config/system/keys`) — where you add
  the RSA public and private keys.
- **Configuration → System → Encryption profiles**
  (`/admin/config/system/encryption/profiles`) — where you create the profile
  that uses an RSA method.

## How to use it

1. **Create an RSA key pair.** The recommended approach is a public/private RSA
   key pair protected by a passphrase.
2. **Register the keys** at *Configuration → System → Keys*. Store the **private
   key** in a secure Key provider — an environment/secret provider, never
   committed to version control — and keep it in the environment that is meant to
   decrypt. The public key can be stored more freely.
3. **Create an Encryption Profile** at *Configuration → System → Encryption
   profiles* and choose an RSA method such as **Public OpenSSL Seal**.
4. Use that profile wherever the Encrypt framework is consumed (encrypted fields,
   Webform submissions, custom code, and so on).

> **Secret handling.** The private key is the only thing standing between an
> attacker and your plaintext — protect it as a secret. The module stores PEM key
> material through whichever Key provider you choose for the Key entity (file,
> configuration, or environment), so pick a provider that keeps the private key
> out of version control. Note that this module cannot generate keys for you —
> create the RSA key pair with the `openssl` CLI (see the README) and paste the
> PEM in. The *Private OpenSSL Seal* method has no admin field for a private-key
> passphrase, so most setups either use a passphrase-free private key or use a
> `Public *` (encrypt-only) method and keep the private key in a separate,
> better-protected environment. Consult the module's README for platform-specific
> guidance, since the achievable security depends on the underlying
> OpenSSL/phpseclib build.
