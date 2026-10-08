# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Migrate** module (this is a Migrate process plugin). You'll typically
  also use Migrate Plus / Migrate Tools to author and run migrations, though those
  are not hard dependencies of this module.
- No third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_field_lookup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_field_lookup -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_field_lookup -y
```

## Verify it worked

There is no admin page. Once enabled, the process plugin is available to your
migration definitions — reference it as a process step, as described in the parent
[guide](../index.md).
