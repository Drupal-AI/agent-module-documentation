# Installation

## Requirements

- **Drupal 10.2, 11 or 12** (`core_version_requirement: ^10.2 || ^11 || ^12`).
- Module dependencies, all resolved for you by Composer/Drush:
  - **Devel** (`devel`) and **Entity Clone** (`entity_clone`) — the developer
    tools.
  - **Drutopia Core** (`drutopia_core`), **Drutopia Search** (`drutopia_search`)
    and the broader Drutopia content feature set.
  - Core **Node** (`node`), **User** (`user`) and **Search API** (`search_api`).

There are no PHP library requirements.

> **Dev/staging only.** This module brings in Devel and Entity Clone, which are
> powerful and should not be enabled on production. Install it on development or
> staging environments, and uninstall it before deploying.

## Install with Composer

From the project root — a `--dev` requirement is appropriate since this is a
development-only toolkit:

```bash
composer require --dev drupal/drutopia_dev -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer
pull in Devel, Entity Clone, Drutopia Core and the rest of the stack. (If your
workflow doesn't use `require --dev`, plain `composer require drupal/drutopia_dev
-W` also works — just be sure not to enable it on production.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/drutopia_dev -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drutopia_dev -y
```

Enabling it also enables Devel, Entity Clone and the Drutopia feature bundle.

## Verify it worked

- Confirm **Devel** and **Entity Clone** appear as enabled at **Extend**
  (`/admin/modules`).
- Confirm the Drutopia content features (article, blog, event, etc.) are present
  under **Structure → Content types** (`/admin/structure/types`).
- Remember to uninstall Drutopia Dev (and its dev tools) before deploying to
  production.
