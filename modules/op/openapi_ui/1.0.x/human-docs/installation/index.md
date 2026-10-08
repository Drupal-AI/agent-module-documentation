# Installation

## Requirements

- **Drupal 10.1.3 or 11** (`core_version_requirement: ^10.1.3 || ^11`).
- No module dependencies and no third‑party PHP libraries — the base module is a
  self‑contained framework.
- **To actually render anything**, a renderer module:
  [OpenAPI UI Swagger](https://www.drupal.org/project/openapi_ui_swagger)
  (`openapi_ui_swagger`) and/or
  [OpenAPI UI ReDoc](https://www.drupal.org/project/openapi_ui_redoc)
  (`openapi_ui_redoc`).
- **Commonly paired with** the [OpenAPI](https://www.drupal.org/project/openapi)
  project to generate the spec for Drupal core and contrib APIs.

> **Release note:** the version documented here corresponds to the `8.x-1.0-rc5`
> release, which is a release candidate (`rc`) rather than a full stable release.

## Install with Composer

From the project root, install the framework and at least one renderer, for
example:

```bash
composer require drupal/openapi_ui drupal/openapi_ui_swagger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/openapi_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en openapi_ui openapi_ui_swagger -y
```

Enabling `openapi_ui` on its own registers the plugin type and render element but
**no renderers**, so nothing appears on screen until a renderer module (Swagger
or ReDoc) — or your own renderer plugin — is present. After adding a plugin, clear
caches so it is discovered:

```bash
drush cr
```

There are no submodules within `openapi_ui` itself and no configuration form; any
settings come from the renderer modules you install.
