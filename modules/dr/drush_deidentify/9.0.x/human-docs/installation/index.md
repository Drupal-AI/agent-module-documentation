# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Drush**, since the module is driven entirely from the command line.
- The **Faker** PHP library (`fakerphp/faker`), which the module's own
  `composer.json` pulls in automatically when you install it with Composer.
- **gzip** available on your `PATH` if you intend to use the `--gzip` option.

There are no other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_deidentify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Faker and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush_deidentify -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_deidentify -y
```

## Verify it worked

After enabling, run `drush list` and confirm that
`drush_deidentify:db-export` (alias `ice-export`) and
`drush_deidentify:db-clean` (alias `ice-clean`) appear. See the
[main guide](../index.md) for the full command workflow — and remember to
de-identify before sharing any exported dump.
