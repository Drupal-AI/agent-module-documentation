# Encrypt — manual setup guide

**Encrypt** (`encrypt`) provides an API for **two-way (reversible) encryption** in
Drupal. It doesn't encrypt anything on its own — it's the framework other modules
build on to protect sensitive data at rest. The central idea is an **encryption
profile**: a reusable configuration entity that pairs an **encryption method**
(the cipher/algorithm, supplied by an add-on module) with a **key** (managed by the
required **Key** module). Other modules then call Encrypt's service to encrypt and
decrypt values using a named profile.

This design keeps secrets where they belong. The cipher lives in the encryption
method plugin, and the actual secret key material lives in the Key module — an
environment variable, a file, a KMS, and so on — so the profile *references* a key
but never stores it. That makes profiles safe to export as configuration and deploy
across environments. Encrypt is a common dependency of modules such as Real AES,
Encrypted Field / Field Encrypt, and Webform encrypt.

Two things are required to actually encrypt: the **Key** module (a hard dependency)
and **at least one module that provides an encryption method** — Encrypt ships none
itself. The maintainers recommend **Real AES** for most sites. As of this 3.3
release the module requires Drupal 10.3+ or 11.

> **Security caveat:** The **Administer encryption settings** permission
> (`administer encrypt`) is powerful — besides changing settings, it lets a user
> decrypt arbitrary text with any encryption profile through the profile *Test*
> form. Grant it only to fully trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable Encrypt
   and Key, and add an encryption method module.
2. [Configuration](configuration/index.md) — create a key, build an encryption
   profile, test it, and adjust the module settings.

## Where it lives in the admin menu

Encryption profiles are managed at **Configuration → System → Encryption profiles**
(`/admin/config/system/encryption/profiles`, route
`entity.encryption_profile.collection`). Keys are managed by the Key module at
**Configuration → System → Keys** (`/admin/config/system/keys`). Module-wide
settings sit at `/admin/config/system/encryption/profiles/settings`. All of these
require the `administer encrypt` permission (keys use Key's own permission).
