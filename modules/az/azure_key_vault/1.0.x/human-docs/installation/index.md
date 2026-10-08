# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- An **Azure Key Vault** instance, plus a way for the site to authenticate to it — a
  **service principal** (app registration with a client ID and secret) or a **managed
  identity** on the host that runs Drupal.
- The contributed **Key** module — required if you want to use the
  `azure_key_vault_key_provider` submodule (the usual reason to install this module).

## Install with Composer

From the project root:

```bash
composer require drupal/azure_key_vault -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_key_vault -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

If you'll use the Key provider and don't yet have the Key module:

```bash
composer require drupal/key -W
```

## Enable the module

Enable the base module:

```bash
drush en azure_key_vault -y
```

## Submodule — the Key provider

To make vault secrets available as Key entities, also enable the submodule:

```bash
drush en azure_key_vault_key_provider -y
```

This is the piece that adds an "Azure Key Vault" provider option to the Key module.
After enabling, configure the vault connection and create a key — see
[Configuration](../configuration/index.md).
