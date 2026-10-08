# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Migrate** module (`migrate`), enabled as a dependency. In practice you
  will also use the migration tools you normally rely on (for example Migrate
  Plus and Migrate Tools) to define and run migrations.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/make_array_associative -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/make_array_associative -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en make_array_associative -y
```

## Verify it worked

There's no admin page to check. Once enabled, the `make_array_associative`
process plugin is available to any migration on the site — reference it in a
migration's `process` section as shown in the [overview](../index.md#how-to-use-it),
run the migration, and confirm the array has been re-keyed as expected.
