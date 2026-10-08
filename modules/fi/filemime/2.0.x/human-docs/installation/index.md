# Installation

## Requirements

- **Drupal 11.2 or later, or Drupal 12** (`core_version_requirement: ^11.2 || ^12`).
  This is a deliberately tight requirement — File MIME 2.0.x does **not** run on
  Drupal 11.1 or earlier.
- Core's **File** module (`file`), a declared dependency, enabled by default on
  most sites.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/filemime -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filemime -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filemime -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Media → File MIME**
(`/admin/config/media/filemime`). If the settings form loads, the module is
installed. From here you can extend or override the MIME‑type mapping — see
[Configuration](../configuration/index.md).

> **Reverting:** disabling File MIME restores Drupal's built‑in extension‑to‑MIME
> mapping.
