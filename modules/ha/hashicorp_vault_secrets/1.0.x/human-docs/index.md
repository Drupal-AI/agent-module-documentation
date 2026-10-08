# Hashicorp Vault Secrets Key Integration — manual setup guide

**Hashicorp Vault Secrets Key Integration** (`hashicorp_vault_secrets`) lets
Drupal fetch secret values from **HashiCorp Vault** instead of storing them in
Drupal's own configuration or state. It does this by adding a new **key provider**
to the [Key](https://www.drupal.org/project/key) module: when you create a Key
entity and choose this provider, the Key resolves its value from a Vault KV
(key/value) secrets engine at runtime. The sensitive material stays in Vault —
your centralised secrets store — and Drupal reads it only when it needs it.

That makes it a natural fit for teams already running HashiCorp Vault (including
HashiCorp Cloud) who want one place to manage encryption keys, API tokens, and
other credentials, and then consume them from Drupal for encryption,
authentication, and other security-critical operations.

Because this module is the bridge to your secret store, treat its own connection
details as secrets too: the Vault **address** and **auth token** should come from
the environment (never committed to code or config), and traffic to Vault should
always use HTTPS. The [Configuration](configuration/index.md) page walks through
this carefully.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside the Key module.
2. [Configuration](configuration/index.md) — connecting to Vault and creating a
   Key that reads from it, with the secret-handling rules you must follow.

## Where it lives in the admin menu

This module has no standalone settings page of its own. You configure it through
the **Key** module at **Configuration → System → Keys**
(`/admin/config/system/keys`): when you add a Key you select **HashiCorp Vault**
as the key provider and enter the Vault connection details there. See
[Configuration](configuration/index.md).
