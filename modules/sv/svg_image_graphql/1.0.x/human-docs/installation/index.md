# Installation

## Requirements

SVG Image GraphQL is an integration layer, so most of the requirements are the
two modules it bridges:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **SVG Image** (`svg_image`) — the module that adds SVG support to image fields.
- **GraphQL version 3.x** (`graphql`) — this module targets the 3.x branch
  specifically, not GraphQL 4.

There are no additional PHP libraries to install. Composer will pull in the two
module dependencies for you when you use the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_image_graphql -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update the
`svg_image` and `graphql` dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_image_graphql -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_image_graphql -y
```

Enabling it also ensures `svg_image` and `graphql` are on. Once enabled, SVG image
field data is available through your GraphQL schema — there is no configuration
step for this module itself.
