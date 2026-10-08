# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Key** module (`key`) — a required dependency, used to store the NVA API
  credential securely rather than in plain configuration.
- The **`stinis87/nva`** PHP client library, which the module uses to talk to the
  NVA/Cristin API. It is pulled in through Composer when you install the module.
- Outbound HTTPS access to the NVA/Cristin API (see the egress note in
  [How to use it](../index.md#how-to-use-it)).

## Install with Composer

From the project root:

```bash
composer require drupal/nva -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `stinis87/nva`
client, the Key module, and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nva -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nva -y
```

Drupal will enable the Key module first if it is not already on. If Key is not yet
installed, add it with `ddev composer require drupal/key` and `ddev drush en key -y`.

## Verify it worked

Confirm the module is enabled and that its blocks (for example **NVA List
Publications**) appear in **Structure → Block layout** when you place a block.
After storing the API credential as a Key (see
[How to use it](../index.md#how-to-use-it)), place a publications block for a known
author and confirm data is returned.
