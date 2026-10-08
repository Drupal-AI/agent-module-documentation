# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Interface Translation** (`locale`) module (which in turn needs
  **Language**). If you don't have interface translation enabled, this module has
  nothing to clean up.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/l10n_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/l10n_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en l10n_tools -y
```

## Grant the permission

Go to **People → Permissions** and grant **access l10n_tools form** only to trusted
administrators — this form deletes translation data.

## Verify it worked

Visit **Configuration → Regional and language → L10n Tools**. You should see the
cleanup interface with its tabs. **Before running any cleanup, take a database
backup** — see [Configuration](../configuration/index.md) for what each tab does.
