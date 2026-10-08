# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Locale** module (`locale`) and **Filter** module (`filter`) — the only
  two dependencies, both part of core.
- The `enshrined/svg-sanitizer` PHP library, which Composer installs with the module
  and which sanitizes SVGs before output. No other third-party libraries are needed.

## Install with Composer

From the project root:

```bash
composer require drupal/svg_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the `enshrined/svg-sanitizer` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/svg_embed -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en svg_embed -y
```

Enabling the module makes the filter available, but nothing happens until you enable
the **SVG Embed** filter on a text format — see the [main guide](../index.md).

## Keep the sanitizer current

SVG Embed's safety against SVG-based XSS depends on the `enshrined/svg-sanitizer`
library it bundles. Keep it up to date as part of your normal Composer maintenance so
that the sanitization stays effective.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit a text format. With the module enabled,
**SVG Embed** should appear in the list of filters you can turn on.
