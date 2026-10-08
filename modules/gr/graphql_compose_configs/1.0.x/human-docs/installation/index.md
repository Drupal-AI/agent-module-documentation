# Installation

## Requirements

- **Drupal 10.2 or later** (`core_version_requirement: ^10.2||^11`).
- The **GraphQL Compose** module (`graphql_compose`) — required dependency.

> **Note:** this project is not covered by Drupal's security advisory policy at
> this version. Review it before relying on it in production — and see the exposure
> caution on the [Configuration](configuration/index.md) page.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_compose_configs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including GraphQL Compose if not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graphql_compose_configs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql_compose_configs -y
```

## Verify it worked

Go to `/admin/config/graphql/compose/configs`, add a configuration exposure for a
harmless config object (for example `system.site`, exposing only `name`), save it,
then run a GraphQL query for that type (e.g. `systemSite { name }`) and confirm the
value comes back.
