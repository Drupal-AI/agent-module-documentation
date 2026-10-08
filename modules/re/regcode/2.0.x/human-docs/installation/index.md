# Installation

## Requirements

Registration codes needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`) enabled — the code list is built as a View.
  Drupal enables it automatically as a dependency, and it is part of a standard
  install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/regcode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/regcode -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en regcode -y
```

## Grant the permission

Give the **Administer registration codes** permission to the roles that should be
able to generate and manage codes, at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

As a user with the **Administer registration codes** permission, go to
**Configuration → People** and confirm you can reach the code-management pages
(**Manage codes**, **Create codes**, **Settings**). Then head to
[Configuration](../configuration/index.md) to set the code behavior and generate
your first batch.
