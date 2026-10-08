# Sodium — manual setup guide

**Sodium** (`sodium`) adds a modern, Libsodium‑backed encryption method to the
[Encrypt](https://www.drupal.org/project/encrypt) module. Once it is installed,
any encryption profile on your site can use authenticated symmetric encryption —
via ParagonIE's well‑regarded Halite library — instead of the older
OpenSSL/mcrypt‑era methods. It is the sort of module you reach for when you need
to encrypt personal data, API credentials, webform answers, or other sensitive
values at rest with a current, audited cipher.

The whole module is a single plugin: an encryption method named **Sodium** that
shows up as a choice when you create an encryption profile. It only accepts Key
entities of type *Encryption*, and it insists on a **256‑bit (exactly 32‑byte)**
key — a proper key, not a passphrase. Encryption is authenticated, meaning
tampered ciphertext fails to decrypt rather than returning garbage, and all
secret material is wrapped so it never leaks into logs or stack traces.

There is nothing to configure in Sodium itself — no settings form, no
permissions, no config, no Drush commands. All the work happens in two other
modules' user interfaces: you create your key with the **Key** module and your
encryption profile with the **Encrypt** module, and simply pick "Sodium" as the
method. Because it is a developer/security building block rather than a
click‑and‑go feature, this guide covers how to get it in place; the day‑to‑day
setup of keys and profiles is described below and in the linked agent docs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — in particular
[`configure/setup.md`](../agent/configure/setup.md) has copy‑paste commands for
generating a key and building a profile.

## Contents

1. [Installation](installation/index.md) — the PHP and library requirements,
   installing with Composer, and enabling the module.

## Where it lives in the admin menu

Sodium adds no page of its own. You use it through the Key and Encrypt modules:

- **Configuration → System → Keys** (`/admin/config/system/keys`) — create the
  Encryption key.
- **Configuration → System → Encryption profiles**
  (`/admin/config/system/encryption/profiles`) — create a profile and choose
  **Sodium** as the encryption method.

## How to use it

The short version, once the module is enabled (see
[Installation](installation/index.md)):

1. **Generate a 32‑byte key.** It must be exactly 32 bytes (256 bits). The
   safest place to keep it is outside the database — a file outside the docroot,
   or better, an environment variable. See your project's `AGENTS.md` for the
   preferred DDEV env‑var + Key‑entity flow.
2. **Create a Key entity** at `/admin/config/system/keys/add` — *Key type*
   **Encryption**, *Key size* **256**, then a provider (File, Configuration, or
   an env/secrets provider). If you paste a base64 value, tick *Base64‑encoded*
   in the provider settings, otherwise the stored key will be the wrong length
   and Sodium will reject it.
3. **Create an encryption profile** at
   `/admin/config/system/encryption/profiles/add` — *Encryption method*
   **Sodium**, *Encryption key* = the key you just made.
4. **Test it** with the **Test** operation on the profiles list.

From there, any Encrypt‑aware module (Field Encryption, Webform encryption, and
so on) can use that profile. Note that Sodium's ciphertext is **raw binary**, so
if you store encrypted values yourself, keep them in a binary‑safe column or
base64‑encode them first — the integrating modules handle this for you. There is
no built‑in re‑encryption helper, so key rotation means creating a new key and
profile and re‑encrypting stored values with it; keep the old key until that pass
is finished, because authenticated ciphertext is unrecoverable without its key.
