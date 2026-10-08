# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Interface Translation / Locale** module (`locale`) — the only
  dependency, enabled automatically as a dependency.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/potx -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/potx -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en potx -y
```

Drupal enables the **Locale** module automatically as a dependency.

There is **no configuration form and no submodules**. potx exposes an **Extract**
tab in the admin UI and a `drush potx` command — see
[How to use it](../index.md#how-to-use-it). Access to the web form is governed by
core's **Translate interface** permission.

## Verify it worked

Visit **Configuration → Regional → User interface translation**
(`/admin/config/regional/translate`) and confirm an **Extract** tab appears. Or,
from the command line, run `drush potx single` inside a module folder and check
that a `general.pot` file is produced.
