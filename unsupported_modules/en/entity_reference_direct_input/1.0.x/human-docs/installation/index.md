# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No third‑party Composer packages or PHP libraries.

> **Heads up:** this project's own page notes it is an unsupported successor to
> [Alter Entity Autocomplete](https://www.drupal.org/project/alter_entity_autocomplete),
> and it is **not covered** by Drupal's security advisory policy. Weigh that
> before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_direct_input -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_reference_direct_input -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_direct_input -y
```

## Verify it worked

The module does nothing until you enable at least one entity type on its
settings page — see [Configuration](../configuration/index.md). Once you have,
open any autocomplete entity-reference field for an enabled type and paste an
entity ID or URL: a resolved suggestion (formatted as "Label — /alias (id: N)")
should appear at the top of the autocomplete list.
