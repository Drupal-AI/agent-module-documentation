# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Write permission for the web server user** on the
  `docroot/modules/module_manager_contrib` folder — Module Manager extracts and moves
  downloaded modules there.
- No third‑party module or PHP/JS library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/module_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/module_manager -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en module_manager -y
```

## Create the writable extraction folder

Module Manager needs a folder it can write to when it extracts downloaded modules.
Create it and give the web server user (for example `www-data`) ownership and write
permission:

```bash
mkdir -p /path/to/docroot/modules/module_manager_contrib
chown www-data:www-data /path/to/docroot/modules/module_manager_contrib
chmod 775 /path/to/docroot/modules/module_manager_contrib
```

Adjust the path and user to match your server. If this folder is missing or not
writable, installs will fail.

## Verify it worked

Log in as a fully‑trusted administrator with the **Administer modules** permission and
open the **Module Manager** screen from the admin menu. You should be able to search
Drupal.org modules. Before installing anything, re‑read the security caveats in the
[overview](../index.md) — this tool executes code and bypasses your deployment
pipeline, so it is best used on non‑production environments.
