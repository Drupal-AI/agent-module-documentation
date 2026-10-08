# Installation

## Requirements

Migrate Tools needs **Drupal 9.1+, 10, or 11** and **PHP 8.0 or newer**. Its only
hard dependency is a module that already ships with Drupal core:

- **Migrate** (`migrate`) — core's Migrate API, which defines and executes
  migrations. Migrate Tools enables it automatically.

Two things are strongly recommended and listed as suggestions:

- **Drush** (`drush/drush`, `^11 || ^12 || ^13`) — the command line is the primary
  way to run migrations, so you almost certainly want Drush installed.
- **Migrate Plus** (`drupal/migrate_plus`, `^5 || ^6`) — provides the `migration`
  and `migration_group` configuration entities. **The admin UI under Structure →
  Migrations only appears when Migrate Plus is enabled.** Without it, Migrate Tools
  still works, but only through Drush.

## What defines the migrations

Migrate Tools is a *runner*, not an authoring tool. It does not create migrations
of its own — it runs the migrations already defined on your site. Those come from:

- **Migrate Plus** configuration entities (migration groups and migrations you
  create as config), or
- A **custom or contrib module** that ships migration plugins in code.

Keep this in mind as you read on: an empty **Migration groups** page is normal on a
fresh install. It fills up once you (or another module) define migrations.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update related packages as
needed. To get the admin UI as well, require Migrate Plus at the same time:

```bash
composer require drupal/migrate_tools drupal/migrate_plus -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migrate_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_tools -y
```

This also enables core's **Migrate** module. To turn on the admin UI, enable
Migrate Plus too:

```bash
drush en migrate_tools migrate_plus -y
```

## Verify it worked

Log in as an administrator. Running `drush migrate:status` (alias `drush ms`)
should complete without error — on a site with no migrations defined yet it simply
reports that there are no migrations. If you enabled Migrate Plus, you can also go
to **Structure → Migrations** (`/admin/structure/migrate`) and see the **Migration
groups** page. Next, review the [Configuration](../configuration/index.md) page for
the UI and Drush workflows.
