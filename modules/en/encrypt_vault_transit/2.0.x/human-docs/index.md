# Encrypt - Vault Transit — manual setup guide

**Encrypt - Vault Transit** (`encrypt_vault_transit`) adds **HashiCorp Vault's
Transit secrets engine** as an encryption method for the
[Encrypt](https://www.drupal.org/project/encrypt) module. Vault's Transit engine
is "encryption as a service": your site sends data to Vault to be encrypted or
decrypted, and the encryption key stays inside Vault rather than on the Drupal
server. It is part of the *Vault for Drupal* suite and depends on the
**Encrypt**, **Key**, and **Vault** modules.

The security model is similar to a hosted key service: because the key lives in
Vault, a compromise of the Drupal database or filesystem alone does not expose
it. What you must protect instead is the **connection to Vault** — the Vault
address and the token the site authenticates with. The connection and token are
handled through the **Vault** and **Key** modules; store the token securely
(env‑backed, via a Key provider) and always talk to Vault over **HTTPS**.

This module has **no admin form of its own**. You configure the Vault connection
and token through the Vault and Key modules, then create an Encryption Profile
that uses the Vault Transit method. See [Installation](installation/index.md) and
["How to use it"](#how-to-use-it) below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Encrypt /
   Key / Vault dependencies, and enable it.

There is **no dedicated configuration page** for this module — the Vault
connection lives in the Vault module and the encryption method is set up on the
Encrypt module's forms, described below.

## Where it lives in the admin menu

- The **Vault** module provides the connection settings (Vault address and
  authentication token, stored via the Key module).
- **Configuration → System → Encryption profiles**
  (`/admin/config/system/encryption/profiles`) — where you create the profile
  that uses the Vault Transit method.

## How to use it

1. **Set up Vault** with the Transit secrets engine enabled and a key created in
   it, and note the Vault address and an access token.
2. **Configure the connection** through the Vault module, storing the token
   securely via the Key module (an env‑backed secret provider).
3. **Create an Encryption Profile** at *Configuration → System → Encryption
   profiles* and choose the **Vault Transit** encryption method.
4. Use that profile wherever the Encrypt framework is consumed.

> **Secret handling.** The Vault token is a secret — never commit it. With DDEV,
> store it as an environment variable
> (`ddev dotenv set .ddev/.env --vault-token=<value>`, then `ddev restart`) and
> reference it through a Key env provider. Always use HTTPS to reach Vault so the
> token and the data in transit are protected.
