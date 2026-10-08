# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7||^9||^10||^11`).
- **Drush**, since fixtures are listed, loaded, and purged with Drush commands.
- No third‑party Composer or PHP library requirements.

Because loading fixtures **deletes all existing content first**, install and use
this module only in development, test, and CI environments — never on production.

## Install with Composer

From the project root:

```bash
composer require drupal/content_fixtures -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you only need it for local development you may prefer to
require it as a dev dependency (`composer require --dev drupal/content_fixtures`) so
it isn't installed on production.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_fixtures -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_fixtures -y
```

## Optional — the example submodule

The project ships a `content_fixtures_example` submodule that demonstrates the
fixture pattern. Enable it to study a working example before writing your own:

```bash
drush en content_fixtures_example -y
```

## Verify it worked

Confirm the Drush commands are available:

```bash
drush list | grep content-fixtures
```

You should see `content-fixtures:list`, `content-fixtures:load`, and
`content-fixtures:purge`. Run `drush content-fixtures:list` to see any registered
fixtures (including the example's, if you enabled that submodule).
