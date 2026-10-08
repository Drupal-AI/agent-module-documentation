# Installation

## Requirements

- **Drupal 10.4.5 or 11.1** and newer within those branches
  (`core_version_requirement: ^10.4.5 || ^11.1`).
- **PHP 8.1, 8.2, 8.3, or 8.4** (`php: ~8.1.0 || ~8.2.0 || ~8.3.0 || ~8.4.0`).
- Core's **File** module (`file`) — enabled automatically as a dependency.
- The **Swagger UI JavaScript library** (see below). It is not shipped in the
  rendered output; the minimum supported version is **3.32.2** (the first with the
  needed security fixes).

## Install with Composer

From the project root:

```bash
composer require drupal/swagger_ui_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/swagger_ui_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en swagger_ui_formatter -y
```

## Provide the Swagger UI library

The module finds the Swagger UI assets at runtime through a swappable *library
discovery* service. There are two ways to satisfy it — pick one:

### Option A — Downloaded library (the default)

Place a prebuilt Swagger UI distribution under your web root so that the folder is
named exactly `swagger-ui` and the files sit in its `dist/` subfolder — i.e.
`web/libraries/swagger-ui/dist/swagger-ui-bundle.js` exists.

- **Manually:** download a Swagger UI release, rename the extracted folder to
  `swagger-ui`, and put it at `[web root]/libraries/swagger-ui`.
- **With Composer (asset-packagist):** require `npm-asset/swagger-ui-dist` with a
  `web/libraries/{$name}` installer path, or use the module's `drupal-scaffold`
  file-mapping to scaffold the dist files into `web/libraries/swagger-ui/dist`.

### Option B — Use the assets bundled in the module

The module also bundles the npm `swagger-ui-dist` assets. To use them, alias the
discovery service to the bundled implementation in your site's `services.yml`
(for example `sites/default/services.yml`):

```yml
services:
  swagger_ui_formatter.swagger_ui_library_discovery:
    alias: swagger_ui_formatter.swagger_ui_library_discovery.bundled
```

Rebuild the cache after editing `services.yml`.

## Verify it worked

Go to **Reports → Status report**. The module reports the detected Swagger UI
**version** and install **path** (or an error explaining what is missing). If you
plan to use OAuth2 flows in "Try it out" with a newer library (5.29.0+), make sure
`dist/oauth2-redirect.js` is present — the status report warns if it is missing.

Once the library is detected, continue to
[Configuration](../configuration/index.md) to apply the formatter to a field.
