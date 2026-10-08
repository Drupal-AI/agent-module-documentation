# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Interface Translation** (`locale`) and **Toolbar** (`toolbar`)
  modules — Drupal enables these automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/l10n_quick_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/l10n_quick_links -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en l10n_quick_links -y
```

## Grant the permission

Because the on‑page widget is gated behind its own permission, go to **People →
Permissions** (`/admin/people/permissions`) and grant **use localization quick
links ui** to the roles that translate content. Keep **Administer languages**
(which unlocks the settings form) restricted to trusted administrators.

## Verify it worked

Log in as a user with the widget permission, open any page, and look for a
**Translate page** button in the toolbar. Clicking it should reveal the quick‑links
widget with its search box at the bottom of the viewport.
