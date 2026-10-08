# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no module dependencies, no third‑party Composer packages, and no
front‑end library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/default_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/default_class -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en default_class -y
```

That is all — there is no configuration to do. The two preprocess hooks start
adding classes to blocks and the page element immediately.

## Verify it worked

Rebuild the cache (`drush cr`) and load a page. Inspect a block in your browser's
developer tools — it should now carry a `block` class, its plugin id, its provider,
and a `block--REGION` class for the region it sits in. Load a node page and inspect
the `<html>`/page element — it should carry `node-{id}` and `node-{type}` classes
(and the equivalent `user-*` / `term-*` classes on user and term pages).
