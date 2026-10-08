# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- The base **GraphQL** module (`drupal/graphql` ^5) and core's **Node** module —
  both are pulled in / enabled as dependencies.
- The `doctrine/inflector` PHP library (^2), used to pluralise/singularise query
  names. Composer installs it for you.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_compose -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `drupal/graphql`,
`doctrine/inflector` and any shared dependencies it needs to update.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graphql_compose -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql_compose -y
```

Enabling the base module also enables `graphql` and `node` if they are not already
on, and creates the default GraphQL Compose server (endpoint `/graphql`).

## Submodules — enable only what you need

The base module exposes nodes. To add more of your site to the schema, enable one
or more submodules with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Users | `graphql_compose_users` | The user entity type in the schema |
| Menus | `graphql_compose_menus` | Menus and their links |
| Routes | `graphql_compose_routes` | Resolve content by URL/path, plus redirects and breadcrumbs |
| Views | `graphql_compose_views` | Expose configured Views as filterable GraphQL queries |
| Edges | `graphql_compose_edges` | Relay-style cursor (connection) pagination on entity queries |
| Blocks | `graphql_compose_blocks` | Block content |
| Comments | `graphql_compose_comments` | Comments |
| ECK | `graphql_compose_eck` | Entity Construction Kit entities |
| Image Style | `graphql_compose_image_style` | Derivative image styles |
| Metatags | `graphql_compose_metatags` | Metatag data |
| Layout Builder | `graphql_compose_layout_builder` | Layout Builder layouts |
| Layout Paragraphs | `graphql_compose_layout_paragraphs` | Layout Paragraphs layouts |
| Layouts | `graphql_compose_layouts` | Layout regions/components |

For example, to add users and cursor pagination:

```bash
drush en graphql_compose_users graphql_compose_edges -y
```

Each submodule registers itself as a schema "provider" on the server
automatically as soon as it is enabled — no extra wiring needed.

## Next step

Nothing is exposed yet. Open the server's **Schema** tab to enable the entity
types, bundles and fields you want in your API — see
[Configuration](../configuration/index.md).
