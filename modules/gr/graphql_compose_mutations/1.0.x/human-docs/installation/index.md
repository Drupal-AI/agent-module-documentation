# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **GraphQL** module (`graphql`) — required dependency.
- The **GraphQL Compose** module (`graphql_compose`) — required dependency.

Composer will pull both dependencies in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_compose_mutations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including GraphQL and GraphQL Compose if not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graphql_compose_mutations -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql graphql_compose graphql_compose_mutations -y
```

## After enabling — lock it down first

Enabling the module exposes create/update/delete mutations. **Before you rely on
it**, review the security section in the [guide index](../index.md): confirm that
only safe fields and bundles are mutable, that the mutating roles hold the right
Drupal entity permissions and nothing more, and that your GraphQL endpoint is
authenticated and restricted (persisted queries, no arbitrary queries in
production).

## Verify it worked

Run the `operationsByEntityType(entity_type: "node")` query to confirm the
available create/update/delete operations per bundle appear. Then, as a user with
the appropriate entity permission, run a `genericMutation` (see the guide index)
against a **test** bundle and confirm the entity is created — and that a user
*without* the permission is correctly refused.
