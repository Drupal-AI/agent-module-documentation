# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other Drupal modules are required.

There are no PHP library or extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tally -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tally -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Note on the release.** This documentation tracks the `1.x` development line, so
> pin the branch you intend to use (for example `drupal/tally:1.x-dev`) if you need
> a specific build.

## Enable the module

```bash
drush en tally -y
```

## Verify it worked

Tally has no admin settings page. It is working once enabled and you can add its
field to an entity type — go to **Manage fields** for a content type and confirm the
Tally field type is available to add (see the [main guide](../index.md)).
