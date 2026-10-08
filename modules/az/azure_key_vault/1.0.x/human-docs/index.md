# Azure Key Vault — manual setup guide

**Azure Key Vault** (`azure_key_vault`) lets Drupal fetch its secrets — API keys,
passwords, certificates — from a **Microsoft Azure Key Vault** at runtime instead of
storing them inside the site's configuration or files. Your sensitive values live in
the vault, and Drupal reads them over TLS when it needs them.

It ships a submodule, **Azure Key Vault Key Provider**
(`azure_key_vault_key_provider`), that plugs into the contributed **Key** module. With
it enabled, a Key entity's value can be sourced straight from your Azure Key Vault, so
any module that already reads its credentials through a Key entity (many AI, payment
and API modules do) transparently gets them from the vault. It runs on Drupal 10.3+
and 11 and sits in the Security package.

This is a genuinely good secrets‑management pattern — secrets stay in the vault rather
than committed to config. There is one bootstrapping detail to handle honestly: the
module itself has to authenticate to Azure to open the vault, using a **service
principal** (client ID + secret) or a **managed identity**. That bootstrap credential
is the key that unlocks all the others, so it must be stored securely — and where your
hosting supports it, prefer **managed identity**, which means no secret is stored at
all. See [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its Key‑provider submodule.
2. [Configuration](configuration/index.md) — connect to the vault and create a
   vault‑backed Key.

## Where it lives in the admin menu

The vault connection is configured at the module's admin form (route `azvault.admin`).
Once the **Key Provider** submodule is on, you create vault‑backed keys from the Key
module's UI at **Configuration → System → Keys** (`/admin/config/system/keys`).
