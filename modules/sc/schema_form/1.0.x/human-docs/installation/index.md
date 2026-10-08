# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third-party PHP libraries to
install.

> **Heads up on release status:** at the time of writing this module is an alpha
> release, so pin your version and test upgrades carefully before relying on it in
> production.

## Install with Composer

From the project root:

```bash
composer require drupal/schema_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/schema_form -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en schema_form -y
```

Once enabled, the form classes it provides (such as
`Drupal\schema_form\SchemaConfigFromRouteForm`) are available to your custom
modules. There is no configuration UI — see the [main guide](../index.md) for how
to define a schema and route that generate a form.
