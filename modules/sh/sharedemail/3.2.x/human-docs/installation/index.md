# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **User** module (part of every standard install), enabled automatically as
  a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sharedemail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sharedemail -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sharedemail -y
```

You can also enable it from **Extend** (`/admin/modules`).

## What happens next

As soon as the module is enabled it swaps core's email-uniqueness check for its own —
but nobody can actually share an address until you grant the **Create shared email
account** permission to a role. Head to [Configuration](../configuration/index.md) to
set the allowlist, adjust the warning message, and assign the permissions. To turn
the behaviour off again, simply disable the module; it only alters the `mail` field's
constraint.
