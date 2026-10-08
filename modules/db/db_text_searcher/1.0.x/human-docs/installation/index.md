# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Embed** module (`embed`) — this is a required dependency. Composer pulls it
  in automatically with the command below.
- **Drush**, since the module's functionality is delivered as Drush command(s).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/db_text_searcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Embed
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/db_text_searcher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en db_text_searcher -y
```

Enabling Database Text Searcher will also enable Embed if it isn't already on.

## Verify it worked

From your project root, run `drush list` and confirm the Database Text Searcher
command appears in the list. You can then run it against a known value to check
that matches come back with their table, column, and primary key.
