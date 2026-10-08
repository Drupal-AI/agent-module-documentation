# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other Drupal modules are required.

> **Before you install — read the site-wide caveat.** This module's `info.yml`
> replaces core's Underscore library with Lodash for the whole site
> (`libraries-override: core/underscore: inspire_tree/lodash`). On a site with
> significant custom JavaScript that depends on `core/underscore`, verify this
> substitution is safe first. See the [overview](../index.md) for details.

## Install with Composer

From the project root:

```bash
composer require drupal/inspire_tree -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inspire_tree -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inspire_tree -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`); a settings form
appears at **Configuration → Services → Inspire Tree**
(`/admin/config/services/system/inspire-tree`). Because the module only provides
the library, the real test is whether the code you write to attach the
`inspire_tree` asset library renders a working tree — see the
[overview](../index.md).
