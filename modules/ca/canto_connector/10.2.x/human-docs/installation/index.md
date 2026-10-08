# Installation

## Requirements

- **Drupal 9.3 or 10** (`core_version_requirement: ^9.3 || ^10`).
- Core **Editor** (`editor`) — enabled automatically as a dependency. The module ships a
  CKEditor 5 plugin.
- A **Canto (Canto Flight) account** and the ability for editors to log in / authorise via
  OAuth in the browser.
- No third‑party Composer or PHP library requirements.

## Install with Composer

Note that the **project (Composer) name is `canto_connector`** while the **module machine
name is `connector_canto`** — the two differ, so watch which you use where.

From the project root:

```bash
composer require drupal/canto_connector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/canto_connector -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its **machine name**, `connector_canto`:

```bash
drush en connector_canto -y
```

Installing the module also sets up the database table that stores per‑user Canto OAuth
tokens.

## Verify it worked

Go to **Configuration → Search and metadata → Canto Connector**
(`/admin/config/search/connector_canto`) and confirm the settings form loads. Then continue
to [Configuration](../configuration/index.md) to pick your Canto region and connect an
editor account before testing the CKEditor picker.
