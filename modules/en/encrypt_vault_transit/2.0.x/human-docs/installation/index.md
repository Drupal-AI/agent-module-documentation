# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Encrypt** module (`drupal/encrypt`) — the encryption framework this
  module plugs into.
- The **Key** module (`drupal/key`) — stores the Vault access token securely.
- The **Vault** module (`drupal/vault`) — manages the connection to your Vault
  server.
- A reachable **HashiCorp Vault** server with the **Transit** secrets engine
  enabled and a key created in it.

## Install with Composer

From the project root:

```bash
composer require drupal/encrypt_vault_transit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Encrypt,
Key, and Vault dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/encrypt_vault_transit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en encrypt_vault_transit -y
```

This also enables Encrypt, Key, and Vault if they are not already on.

## Verify it worked

Confirm `encrypt_vault_transit`, `encrypt`, `key`, and `vault` are enabled on the
**Extend** page (`/admin/modules`). Then check that the **Vault Transit**
encryption method appears when you create an Encryption Profile. From there,
follow the setup flow in the [main guide](../index.md#how-to-use-it).
