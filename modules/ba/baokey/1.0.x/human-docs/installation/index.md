# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Key** module (`key`) — BaoKey plugs into it as a key provider. It is
  pulled in automatically when you require this module with Composer.
- A reachable **OpenBAO or HashiCorp Vault** server with a **KV v2** secrets
  engine, and a **Vault token** that can read the secrets you want.

## Install with Composer

From the project root:

```bash
composer require drupal/baokey -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the Key dependency
along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/baokey -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en baokey -y
```

Drupal enables the Key module at the same time if it is not already on. There is
no admin settings page — configuration lives in `settings.php` and on each Key
entity. See [Configuration](../configuration/index.md).
