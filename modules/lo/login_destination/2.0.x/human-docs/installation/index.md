# Installation

## Requirements

- **Drupal 8.7.10, 9, 10, or 11** (`core_version_requirement: ^8.7.10 || ^9 || ^10 || ^11`).
- Core's **Path Alias** (`path_alias`) module — enabled on virtually every site, and
  pulled in automatically as a dependency.

There are no third-party Composer or PHP library requirements. Note this is a
**beta** release.

## Install with Composer

From the project root:

```bash
composer require drupal/login_destination -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/login_destination -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en login_destination -y
```

Enabling the module does nothing on its own — it just makes the admin UI available.
You then create at least one rule; see [Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → People → Login destinations**
(`/admin/config/people/login-destination`). You should see the (initially empty)
list of rules with an **Add login destination** action.
