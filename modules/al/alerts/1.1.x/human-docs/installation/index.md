# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Link** (`link`), **Taxonomy** (`taxonomy`) and **Views** (`views`)
  modules.
- Two contrib modules: **Add Content by Bundle**
  (`add_content_by_bundle`) — for the bundle-scoped "add alert" link — and
  **Color Field** (`color_field`) — for per-severity banner colors. Composer's
  `-W` flag pulls these in.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alerts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the contrib
dependencies (Add Content by Bundle, Color Field) and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/alerts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alerts -y
```

Enabling imports the alert content type, the `alert_severity` vocabulary (seeded
with Emergency / Warning / Notice), and the `alerts` view in one step.

## Optional: Olivero styling and dismissal

The project ships one submodule, **`alerts_olivero`**, which adds banner styling
for the Olivero theme plus the JavaScript that remembers dismissed banners in the
browser's `localStorage`. Enable it if your front end uses Olivero:

```bash
drush en alerts_olivero -y
```

## Next steps

Once enabled, create alerts and place the alerts view block — see
[How to use it](../index.md#how-to-use-it) in the overview.
