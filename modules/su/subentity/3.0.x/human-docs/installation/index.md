# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush 12 or newer** — the module's Composer requirements pin `drush/drush >11`
  and conflict with anything below Drush 12, so the Drush integration is not
  optional in practice. You need Drush to generate subentity types.
- No other contributed-module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/subentity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies,
including pulling a compatible Drush version if needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/subentity -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en subentity -y
```

## Verify it worked

Confirm the admin overview is reachable at **`/admin/structure/subentities`** (you
need both the *Administer subentities* and *Administer site configuration*
permissions), and that the Drush generator is available:

```bash
drush generate subentity
```

If the generator prompts you for a subentity type, the framework is installed and
ready. See the [main guide](../index.md) for how to generate a type and reference
it from a parent entity.
