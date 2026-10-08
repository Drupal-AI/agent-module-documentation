# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Metatag** module (`drupal/metatag`).
- **GraphQL 3.x** — specifically `drupal/graphql:^3`, which provides the
  **`graphql_core`** submodule this module depends on.

> **Critical compatibility note.** This module works **only** on the GraphQL 3.x
> branch. It uses the 3.x plugin/annotation API and depends on `graphql_core`, which
> **does not exist in GraphQL 4.x or 5.x**. If your site has `drupal/graphql` 4 or 5
> installed, `drush en graphql_metatag` will fail because `graphql_core` can't be found,
> and there is no 4.x/5.x code path in the module. On GraphQL 4/5 you must build your
> own data producer around `metatag.manager` instead.

## Install with Composer

Because of the version pin, install it alongside GraphQL 3.x and Metatag explicitly:

```bash
composer require 'drupal/graphql:^3' drupal/metatag drupal/graphql_metatag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require 'drupal/graphql:^3' drupal/metatag drupal/graphql_metatag -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable GraphQL core, Metatag, and this module together:

```bash
drush en graphql_core metatag graphql_metatag -y
```

There is nothing to configure afterward — the module has no settings, permissions, or
Drush commands. Its GraphQL fields become available immediately; see the
[overview](../index.md#how-to-use-it) for how to query them.
