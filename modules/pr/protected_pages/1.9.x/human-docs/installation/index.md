# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Path Alias** (`path_alias`) module — enabled on virtually every site, and
  pulled in automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/protected_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/protected_pages -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protected_pages -y
```

Enabling the module protects nothing on its own — it just makes the admin UI
available. You then add protected paths and set passwords; see
[Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → System → Protected Pages**
(`/admin/config/system/protected_pages`). You should see the (initially empty) list
of protected pages, with an **Add protected page** action.
