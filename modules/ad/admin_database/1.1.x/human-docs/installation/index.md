# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). There is no Drupal 11
  release of this module.
- No third‑party Composer or PHP library requirements.

Before you install, please read the security warning in the
[overview](../index.md) — this module embeds the Adminer database tool as
web‑accessible files that sit outside Drupal's permission system. Only install it if
you understand and accept that risk (ideally on a local or firewalled environment).

## Install with Composer

From the project root:

```bash
composer require drupal/admin_database -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_database -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_database -y
```

On enable, the module copies its tokenised Adminer file into its `assets/`
directory and stores the token in Drupal state.

## After enabling

1. Go to **People → Permissions** (`/admin/people/permissions`) and grant
   **administer database** to a fully trusted administrator role only.
2. Visit `/admin/admin-db` to open the embedded tool.
3. Strongly consider adding a web‑server rule to deny direct requests to the
   module's `assets/` directory, as described in the overview's security warning.
