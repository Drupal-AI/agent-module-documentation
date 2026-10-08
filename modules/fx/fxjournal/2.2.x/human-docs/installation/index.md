# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core modules **Field** (`field`), **Text** (`text`), **Datetime**
  (`datetime`), and **Options** (`options`) — Drupal enables these automatically
  as dependencies.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/fxjournal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fxjournal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fxjournal -y
```

## Verify it worked

Grant the Forex Journal permissions at **People → Permissions** to the roles that
should keep a journal. Then create a **Forex Journal Account** and a **Forex
Journal Symbol**, log a **Forex Journal Record**, and visit
**`/user/{user}/fxjournal/dashboard`** for that user to confirm the trade appears
on the dashboard.
