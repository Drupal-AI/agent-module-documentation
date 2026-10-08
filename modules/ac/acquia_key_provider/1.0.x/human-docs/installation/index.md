# Installation

## Requirements

- **Drupal 10.4+ or 11.1+** (`core_version_requirement: ^10.4 || ^11.1`).
- The **Key** module (`key`) — Drupal enables it automatically as a dependency.
- An **Acquia-hosted site** with secrets stored in the platform's secret storage —
  that is where this provider reads values from.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_key_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
update shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_key_provider -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_key_provider -y
```

This also enables the Key module if it is not already on.

## Verify it worked

Go to **Configuration → System → Keys** (`/admin/config/system/keys`), click **Add
key**, and confirm that an **Acquia** provider now appears in the *Key provider*
list. Configuring an actual Key is covered in
[Configuration](../configuration/index.md).
