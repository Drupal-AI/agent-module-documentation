# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Breakpoint** module (`breakpoint`), which this module depends on —
  Drupal enables it automatically as a dependency.
- No third-party Composer or PHP library requirements.
- A theme that declares breakpoints in a `*.breakpoints.yml` file, so there is
  something meaningful to expose.

## Install with Composer

From the project root:

```bash
composer require drupal/breakpoint_js_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/breakpoint_js_settings -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en breakpoint_js_settings -y
```

This also enables core Breakpoint if it is not already on. After enabling, define
the values to expose on the settings form at **Configuration → System →
Breakpoint JS** (`/admin/config/system/breakpoint_js`) — see
[Configuration](../configuration/index.md).
