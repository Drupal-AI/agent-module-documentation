# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: ^8.1`).
- **GraphQL Compose** (`drupal/graphql_compose ^2 || ^3`) — the module extends its
  schema. Its **Routes** submodule (`graphql_compose_routes`) is also required and
  is enabled as a dependency.
- Core's **Node** module (`node`) and the contrib **Token** module
  (`drupal/token`) — both required and enabled as dependencies.
- A working **decoupled / headless** front end that talks to your GraphQL Compose
  endpoint, if you want to consume previews end to end.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_compose_preview -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in GraphQL Compose, Token, and their
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql_compose_preview -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql_compose_preview -y
```

Drupal enables GraphQL Compose, its Routes submodule, Node, and Token alongside it
if they are not already on.

## After enabling

The module ships no submodules and no config form. To make previews work you need
to grant the **View preview entities** permission, point the module at your
front‑end URL (via the `GRAPHQL_COMPOSE_PREVIEW_URL` environment variable or a
formatter setting), and optionally add a preview formatter to your content type's
display. See the [main guide](../index.md) for the full walkthrough.
