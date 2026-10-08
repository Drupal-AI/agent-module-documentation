# Installation

## Requirements

Advanced Datalayer needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`, and it requires
  `drupal/core: ^10 || ^11`).
- The **Token** module (`drupal/token`, `^1.0`) — tag values are token strings, so
  this is a hard dependency and is installed with it.
- Core's **Field** module (`field`) — on by default in a standard Drupal install; it
  backs the per‑entity datalayer field.

## Install with Composer

From the project root (Composer pulls in Token as a dependency):

```bash
composer require drupal/advanced_datalayer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_datalayer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_datalayer -y
```

## Important: enable a source of tags

The base module defines **no datalayer tags** — so on its own there is nothing to
push into the dataLayer. Choose how you'll get tags:

- **Quick start / examples:** enable the bundled example submodule, which ships
  ready‑made tags and groups (siteName, pageName, pageCategory, event, responseCode,
  gaClientID, …):

  ```bash
  drush en example_advanced_datalayer -y
  ```

- **Your own tags:** a developer writes `@AdvancedDatalayerTag` (and optionally
  `@AdvancedDatalayerGroup`) plugins in a custom module. See the agent docs at
  [`agent/plugins/tags-and-groups.md`](../agent/plugins/tags-and-groups.md).

## Optional: Context integration

A second submodule, **`context_advanced_datalayer`**, exposes the datalayer
configuration as a **Context** reaction, so you can drive datalayer output per route,
path, or role using the Context module:

```bash
drush en context_advanced_datalayer -y
```

## Next steps

With tags available, assign their values per page context — see
[Configuration](../configuration/index.md).
