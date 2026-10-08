# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other Drupal modules and no third‑party Composer or PHP libraries are
  required — it's a self‑contained, lightweight integration.

## Install with Composer

From the project root:

```bash
composer require drupal/html5history -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html5history -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html5history -y
```

## Verify it worked

There's nothing to see in the admin UI — this module only exposes a JavaScript
integration. To confirm it's working, use it from your own front‑end or AJAX code
(driving `pushState`/`replaceState` or hooking into those events) and check that the
URL updates without a full page reload. The module's documentation describes the
available hooks.
