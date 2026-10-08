# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- No third‑party module or PHP library dependencies beyond Drupal core (it builds
  on the core User module).

## Install with Composer

From the project root:

```bash
composer require drupal/edit_own_user_account_permission -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/edit_own_user_account_permission -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en edit_own_user_account_permission -y
```

## Configure the permission

This module adds no settings form — it adds one permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant or withhold **"Edit own
user account"** for each role, as described in the
[overview](../index.md#where-it-lives-in-the-admin-menu--and-the-permission-model).

## Verify it worked

Confirm it's enabled:

```bash
drush pm:list --status=enabled | grep edit_own_user_account_permission
```

Then test with a **non‑administrator** account: with the permission withheld, that
user should no longer be able to reach their own account edit form; with it
granted, they can. Test on a throwaway account first, and confirm that password
reset and email change still behave the way you intend.
