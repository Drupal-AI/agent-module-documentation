# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node** (`node`) and **Block** (`block`) modules — both ship with Drupal
  and are enabled automatically as dependencies.
- A **DocCheck account** with basic-license credentials from
  [access.doccheck.com](https://access.doccheck.com/). These are supplied to the
  module per its `README.txt`; keep them secret and never commit them to version
  control.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/doccheck_basic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/doccheck_basic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en doccheck_basic -y
```

## Verify it worked

Visit `/doccheck-login` on your site — you should see the DocCheck login. You can
also place the **DocCheck Basic** block from **Structure → Block layout**. Follow
the module's `README.txt` to supply your DocCheck credentials, then confirm the
login flow works and that your HCP-only content is protected by Drupal's own access
controls (this module provides the login, not the content gate).
