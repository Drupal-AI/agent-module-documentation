# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No dependencies beyond Drupal core, and no third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/health_check_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/health_check_url -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en health_check_url -y
```

The module ships no submodules.

## Verify it worked

Visit the endpoint in your browser at `/health` — for example
`https://example.com/health`. You should get a plain‑text response (by default a
Unix timestamp). Then open **Configuration → Development → Health Check URL
settings** (`/admin/config/development/health`) to customize the response — see
[Configuration](../configuration/index.md).

> **Changing the path?** The endpoint path lives in a route that is built from
> configuration. When you change it on the settings form, the module rebuilds the
> router for you. If you ever change the path directly in configuration (for
> example with Drush), run `drush cr` afterwards so the new path is served.
