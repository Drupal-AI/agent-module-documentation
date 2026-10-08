# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **GraphQL** module (`graphql`) — required dependency.
- The **Address** module (`address`) — required dependency.

Composer will pull both dependencies in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_address -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including GraphQL and Address if not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graphql_address -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql graphql_address -y
```

(Address will be enabled as a dependency if it isn't already.)

## Verify it worked

On your GraphQL server's edit page, confirm the **"GraphQL Address"
SchemaExtension** is available and can be enabled. Once you've wired an address
field to the `graphql_address_field_values` DataProducer and added it to a Type,
run a test query from GraphQL Explorer (or your client) and confirm the address
sub‑fields — country, locality, postal code, etc. — come back.
