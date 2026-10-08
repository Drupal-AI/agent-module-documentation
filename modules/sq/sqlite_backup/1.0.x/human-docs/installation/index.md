# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The site must be using the **SQLite database driver** — the module only works on
  SQLite‑backed sites and does nothing on MySQL/PostgreSQL.
- No other module dependencies or PHP libraries.

> This is an **alpha** release; test it before relying on it in anything you can't
> afford to lose.

## Install with Composer

From the project root:

```bash
composer require drupal/sqlite_backup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sqlite_backup -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sqlite_backup -y
```

## Verify it worked

Open the module's **backup overview page** in the admin area. You should be able to
create a new SQLite backup and see it listed, ready to restore. Grant the backup /
restore permission (at **People → Permissions**) only to trusted administrators.
