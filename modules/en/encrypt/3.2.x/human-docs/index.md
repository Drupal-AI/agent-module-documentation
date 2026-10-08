# Encrypt — manual setup guide

**Encrypt** (`encrypt`) provides a framework for encrypting data in Drupal. It does
not encrypt anything on its own; instead it gives site builders and other modules a
reusable, two-way (reversible) **encryption API**. The centrepiece is the
**encryption profile** — a small configuration entity that pairs an **encryption
method** (the cipher or algorithm) with a **Key** entity from the
[Key](../../../key/1.22.x/human-docs/index.md) module (which holds the actual secret
material). Once you have created a profile, other modules — such as Encrypted Field,
Webform encrypt, or Real AES — reference it to encrypt and decrypt values.

Keeping the method and the secret separate is the whole point: the algorithm lives in
the encryption method plugin, while the key material lives in the Key module (an
environment variable, a file, a KMS, and so on) and is *never* stored inside the
profile itself.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to creating your first
encryption profile. If you are looking for terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

![The Encryption profiles list with an Add Encryption Profile button](images/profiles.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`). That page is organised into tabs:

- **List** — every encryption profile on the site, plus the **+ Add Encryption
  Profile** button.
- **Settings** — module-wide options for Encrypt.

Managing profiles requires the **`administer encrypt`** permission, which is
restricted to trusted roles.

## Contents

1. [Installation](installation/index.md) — install Encrypt with Composer, pull in its
   Key dependency, and enable the module.
2. [Configuration](configuration/index.md) — understand the profiles list and the
   encryption-method-plus-key model.
3. [Creating a profile](creating-a-profile/index.md) — create a Key, then bind an
   encryption method to it in a new encryption profile.
