# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP newer than 8.3** (`php: >8.3`).
- Two PHP extensions: **OpenSSL** (`ext-openssl`) — used to encrypt the editor
  deep‑link meta tag — and **JSON** (`ext-json`). These are standard on most
  hosts.
- Core's **Node** module (`node`), which Drupal enables automatically as a
  dependency.
- A **Silktide account and API key** (not a code dependency, but the integration
  does nothing useful without it).

## Install with Composer

From the project root:

```bash
composer require drupal/silktide -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/silktide -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en silktide -y
```

After enabling, go to the settings form and enter your Silktide API key — the
integration stays inert until a key is present (see
[Configuration](../configuration/index.md)).

## Submodules

Silktide ships no submodules.
