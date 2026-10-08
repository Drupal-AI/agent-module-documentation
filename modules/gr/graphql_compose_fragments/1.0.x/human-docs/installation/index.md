# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1** or later.
- The **GraphQL Compose** module (`graphql_compose`) — required dependency; there
  is nothing to generate fragments from without it.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_compose_fragments -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including GraphQL Compose if not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graphql_compose_fragments -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql_compose_fragments -y
```

## Verify it worked

Open the fragments settings (route `graphql_compose.fragments`) and generate
fragments for your schema. Confirm the generated fragments reflect your content
types and fields. If you enabled the schema exposure option, run the
`info { fragments { name content } }` query and confirm the fragments come back.
