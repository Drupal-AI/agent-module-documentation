# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies.
- No external Composer or JavaScript library dependencies — the module is
  self‑contained.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_placeholder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_placeholder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_placeholder -y
```

## Verify it worked

The module doesn't change anything on its own — you need to define a placeholder
set first. Once enabled, open its settings form (from the module's row on the
**Extend** page, or under **Configuration**) and follow
[Configuration](../configuration/index.md). After you save a set and point it at a
field, load a page containing that field and watch the placeholder text cycle.

> **Note on security coverage:** this project is *not* covered by Drupal's security
> advisory policy. That's common for small, young modules and isn't a red flag by
> itself, but factor it into your risk assessment before using it on a
> high‑exposure site.
