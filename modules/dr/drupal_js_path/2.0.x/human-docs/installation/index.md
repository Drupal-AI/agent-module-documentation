# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11 || ^12`) — the module covers a very wide range of cores.
- No module dependencies, no third‑party Composer packages, and no external
  library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drupal_js_path -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drupal_js_path -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drupal_js_path -y
```

## Verify it worked

Load a page on your site, open the browser's developer console, and call one of
the helper functions — for example:

```javascript
Drupal.path('entity.node.canonical', { node: 1 });
```

If the module is working you'll get the resolved path back (for example
`/node/1` or its alias). See [How to use it](../index.md#how-to-use-it) for the
full function signatures.
