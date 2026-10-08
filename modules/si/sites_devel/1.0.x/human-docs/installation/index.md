# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- The **Sites** module (`sites`), the **Devel** module (`devel`), and the **Block
  plugin view builder** module (`block_plugin_view_builder`) — all hard
  dependencies.
- The **Redirect** module is a suggested (optional) companion for richer output.

There are no third‑party PHP library requirements. This is a development‑only
module — install it in development environments, not production.

## Install with Composer

From the project root — typically as a dev requirement:

```bash
composer require drupal/sites_devel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Sites, Devel and
Block plugin view builder as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sites_devel -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sites_devel -y
```

Enabling the module is the entire setup — there is no configuration form. The
"Sites devel debug" block starts rendering on every page immediately.

## Verify it worked

Load any page in your development environment. The **"Sites devel debug"** block
should appear, showing the request's site candidates, the active site, the route
and the negotiated language.

> **Do not enable this on production.** When Sites development mode is on, the debug
> block and Devel dumper output are exposed to all visitors. Keep this module to
> local and development environments and disable or remove it before deploying.
