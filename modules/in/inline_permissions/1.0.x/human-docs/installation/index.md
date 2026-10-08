# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No contributed modules and no external libraries. The module builds on core's
  Access Policy API, which is part of Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/inline_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inline_permissions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inline_permissions -y
```

## A word on access before you begin

The ability to grant per‑user permissions is controlled by the core **Administer
permissions** permission. Anyone with that permission can hand out any permission
to any account — so confirm it is granted only to your most trusted
administrators before you start using this module. See
[Configuration](../configuration/index.md) for the full model.

## Verify it worked

Log in as a user with the **Administer permissions** permission and edit any user
account at **People → *(a user)* → Edit**. You should now see a control on that
form for assigning permissions directly to the account. If it does not appear,
double‑check that your role holds **Administer permissions**.
