# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The contributed **Typed Data** (`typed_data`) module.

There are no PHP library requirements. Composer will pull in Typed Data with the
`-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_template -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as Typed Data.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_template -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_template -y
```

## Verify it worked

After enabling, define a builder and a template blueprint through the module's
admin UI (see [Configuration](../configuration/index.md)), then walk the build flow
to create an entity from the template.

This is a pre‑release module and is not covered by Drupal's security advisory
policy — review it against your own requirements before using it in production.
