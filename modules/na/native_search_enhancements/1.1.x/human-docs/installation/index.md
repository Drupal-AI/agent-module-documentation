# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Node** (`node`), **Search** (`search`), and **Taxonomy** (`taxonomy`)
  modules — all part of a standard install and enabled automatically as
  dependencies.
- You should already be using core's **Search** module with content indexing set
  up; this module enhances that native search, and does **not** work with Search
  API or external search backends.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/native_search_enhancements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/native_search_enhancements -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en native_search_enhancements -y
```

## Grant the permission

The settings are gated by the **`administer native search enhancements`**
permission. Under **People → Permissions**, grant it to the roles that should be
able to manage these enhancements (administrators have it by default).

## Verify it worked

As a user with that permission, open the module's settings (see
[Configuration](../configuration/index.md)). After adjusting exclusions or
ranking, run a search and confirm the results reflect your changes. Because this
is a testing‑stage release not covered by Drupal's security advisory policy,
validate it on a non‑production environment first.
