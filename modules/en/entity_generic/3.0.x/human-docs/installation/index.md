# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Entity API** module (`entity`) — this is a dependency.
  Composer pulls it in with the `-W` flag below.
- No third-party library requirements.

> **Heads up:** the maintainers describe this module's features as experimental and
> not for production use. Install it in a development environment to explore, not on
> a live site you depend on.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_generic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Entity API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_generic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_generic -y
```

This also enables the `entity` module if it isn't already on.

## Verify it worked

There's no admin page to check. Once enabled, the module's base classes, traits,
and helpers are available to your custom code — see the parent [guide](../index.md)
for how it's meant to be used.
