# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other contrib modules and no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/queue_unique -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/queue_unique -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en queue_unique -y
```

Enabling creates the module's `queue_unique` database table. There's nothing to
configure in the UI — you opt a queue into uniqueness from `settings.php`, a
`services.yml`, or code, as described in
[How to use it](../index.md#how-to-use-it) on the overview page.

> **Note:** the module includes an update hook that migrates any pre-existing
> `queue_unique` table data into the current schema, so it's safe to update in
> place.
