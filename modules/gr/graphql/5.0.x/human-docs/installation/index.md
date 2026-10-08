# Installation

## Requirements

GraphQL has a few hard requirements:

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4 || ^11`).
- **PHP 8.1 or newer**.
- The **Typed Data** module (`typed_data`), which Composer pulls in and Drupal
  enables as a dependency.
- The **`webonyx/graphql-php`** PHP library (`^15.32.3`) — the underlying GraphQL
  server/executor. Composer installs this automatically; you do not download it
  yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed, including `typed_data` and `webonyx/graphql-php`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graphql -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graphql -y
```

This enables the framework: the settings screen, the plugin types, and the query
engine. It does **not** create any endpoint yet — there are no servers and no
schema until you add them.

## Submodules — enable only what you need

GraphQL ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GraphQL Composable** | `graphql_composable` | A working example schema (id `composable_example`) with a `createArticle` mutation. Enable this first if you want to see a real, queryable endpoint immediately and learn the architecture by example. |
| **GraphQL File Validate** | `graphql_file_validate` | Adds file-upload validation you can use in GraphQL mutations that accept uploaded files. |

For example, to enable the learning/example schema:

```bash
drush en graphql_composable -y
```

Both submodules require the base GraphQL module, which is already present once
you have installed it above.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → GraphQL**
(`/admin/config/graphql`). You should see the GraphQL **Servers** listing. On a
fresh install it is empty — that is expected. Create a server (see
[Configuration](../configuration/index.md)) and, after `drush cr`, its endpoint
becomes live at the path you chose.
