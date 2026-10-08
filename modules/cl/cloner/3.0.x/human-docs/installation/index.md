# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1** or newer.
- No other modules are required — Cloner depends only on Drupal core.

Note that the 3.0.x branch is an alpha release (`3.0.0-alpha2`) and the project
is minimally maintained, so review it before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/cloner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloner -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloner -y
```

## Submodules

Cloner ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Cloner Examples** | `cloner_examples` | Worked example Cloner and ClonerForm plugins you can read and copy when writing your own. Handy while learning; you would not normally leave it enabled in production. |

Enable it while developing:

```bash
drush en cloner_examples -y
```

## Verify it worked

Because Cloner adds no UI on its own, there is nothing to click after enabling
it. Confirm the module is active with `drush pm:list --type=module --status=enabled | grep cloner`,
then head to the module's `docs/` folder (or the enabled examples submodule) to
start writing the clone plugins your project needs.
