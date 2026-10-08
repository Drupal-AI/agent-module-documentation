# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: ^8.0`).
- Your content must be translatable for the module to do anything, so you will
  normally have core's multilingual modules (**Language** and **Content
  Translation**) enabled — but this module lists no hard module dependencies of
  its own.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_change_default_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_change_default_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_change_default_language -y
```

There are no submodules and nothing to configure. Once enabled, the
`ecdl:cdl` and `ecdl:dlet` Drush commands and the
`entity_change_default_language` service are available. See [How to use
it](../index.md#how-to-use-it) in the overview.

## Verify it worked

Run `drush list --filter=ecdl` (or `drush ecdl:cdl --help`) and confirm the
commands are listed. Then try a single change on a test entity before running
anything across a whole entity type.
