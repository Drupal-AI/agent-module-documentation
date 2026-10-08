# Installation

## Requirements

- **Drupal 11 only** (`core_version_requirement: ^11`). The 3.x branch drops
  support for Drupal 10 — if you are on Drupal 10, use an earlier branch.

There are no third‑party Composer or PHP library requirements, and no dependent
modules.

## Install with Composer

From the project root:

```bash
composer require drupal/prelinker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prelinker -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prelinker -y
```

## A note on access to the admin pages

Prelinker's admin routes are guarded by a permission literally named
`administer`, which is **not** a permission any core module defines. In practice
that means only **user 1** (who bypasses permission checks) can reach the pages
unless another module on your site happens to declare that exact permission name.
If the pages appear inaccessible to a normal administrator, this is why — it is a
known quirk of the module, not a broken install.

## Verify it worked

Log in as user 1, go to **Configuration → System → Prelinker**
(`/admin/config/system/prelinker`), and confirm the overview page loads. From
there you can add your first preconnect or preload entry — see
[Configuration](../configuration/index.md).
