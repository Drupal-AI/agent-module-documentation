# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node** module (`node`) — enabled on any standard site, and the only
  dependency.
- No third‑party Composer or PHP library requirements.

Note this project is **not covered by Drupal's security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/confirm_unpublish -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/confirm_unpublish -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en confirm_unpublish -y
```

Out of the box the confirmation dialog applies to **all** content types.

## Verify it worked

Edit a published node, clear the **Published** checkbox, and save. You should be
shown a confirmation dialog before the node is actually unpublished. To adjust the
message, enable logging, or exclude content types, see
[Configuration](../configuration/index.md).
