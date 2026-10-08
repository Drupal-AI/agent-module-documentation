# Auth Encrypt — manual setup guide

**Auth Encrypt** (`auth_encrypt`) provides encryption and decryption of
authentication credentials so that credential data is not handled or stored in
plaintext. It sits in the Security package and its job is narrow: encrypt a credential
on the way in, decrypt it when it is needed again.

This is a building-block module rather than a point-and-click feature. There is no
settings screen and no menu item — it exists to keep credential data out of plaintext
where other code would otherwise store or transmit it. It has no dependencies and no
access-control role. Note that the current release is an early **beta**.

The one thing to understand clearly is that **the module is only as strong as its key
management**. Encryption protects nothing if the encryption key is easy to reach: a
leaked key makes the ciphertext trivially reversible. Before you rely on this for
anything sensitive, review how the key is generated, where it is stored, and how it is
protected — the key must live **outside the codebase and the database** (in an
environment variable or a proper key store), be rotated, and never be written to logs.
Also review the encryption algorithm it uses so you know it meets your needs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

Auth Encrypt is used by other code to encrypt and decrypt credential values; it does
not add a UI you interact with directly. The important operational work is
**key handling**:

- Keep the encryption key **out of version control and out of the database**. Store it
  in an environment variable — for example with DDEV's dotenv helper — or in a
  dedicated key store rather than in exported configuration:

  ```bash
  ddev dotenv set .ddev/.env --auth-encrypt-key=your-generated-key
  ddev restart
  ```

  (Keep `.ddev/.env` out of version control.) The
  [Key](https://www.drupal.org/project/key) module's env provider is a good way to
  make an env-held key available to Drupal without persisting the value in the
  database.

- **Rotate** the key periodically and **never log** it. A leaked key defeats the
  encryption entirely.

- **Review the algorithm and key handling** in the module's code before trusting it
  with genuinely sensitive credentials.
