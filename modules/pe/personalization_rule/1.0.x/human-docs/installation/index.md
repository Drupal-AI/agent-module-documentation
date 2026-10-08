# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Block** (`block`), **User** (`user`), and **Path Alias**
  (`path_alias`) modules. These are dependencies and Drupal enables them
  automatically when you turn on Personalization Rule.
- No third‑party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/personalization_rule -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/personalization_rule -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en personalization_rule -y
```

Enabling this module also enables its core dependencies (Block, User, Path Alias)
if they are not already on.

## Verify it worked

Log in as an administrator and open the module's rule management interface from
the admin menu. You should be able to start a new rule and see the visual builder
with its conditions and actions. Then head to
[Configuration](../configuration/index.md) to build your first rule.
