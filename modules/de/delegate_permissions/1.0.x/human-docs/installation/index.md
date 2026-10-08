# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Config Filter** module (`config_filter`) — a hard dependency, used to
  reconcile delegated permissions during configuration import/export. Composer
  pulls it in automatically.

There are no PHP library or third‑party Composer requirements beyond Config
Filter.

## Install with Composer

From the project root:

```bash
composer require drupal/delegate_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Config Filter.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/delegate_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en delegate_permissions -y
```

This also enables the `config_filter` dependency if it is not already on.

## Verify it worked

- On **People → Permissions** (`/admin/people/permissions`), confirm you can see
  the **allow delegate permissions** permission and the extra **Not Delegable**
  column (visible to users holding `administer permissions`).
- A user granted `allow delegate permissions` should be able to open **People →
  Delegate permissions** (`/admin/people/delegate-permissions`).

Next, set up the role hierarchy and grants — see
[Configuration](../configuration/index.md).
