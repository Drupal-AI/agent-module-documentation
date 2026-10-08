# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other Drupal module dependencies and no PHP library requirements.
- The front‑end **jsTree** library (and optionally **jsoneditor**). By default
  these load from a CDN (cdnjs), so nothing is required to get started — but you
  can self‑host them if your site must avoid external CDNs (see below).

## Install with Composer

From the project root:

```bash
composer require drupal/hierarchy_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hierarchy_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hierarchy_manager -y
```

Enabling the module changes nothing until you configure a display profile and
enable a setup plugin — see [Configuration](../configuration/index.md).

## Optional: self‑host the JavaScript libraries

By default the module loads **jsTree 3.3.15** and **jsoneditor 9.9.2** from a
cdnjs CDN. To serve them locally instead, place local copies under:

```
/libraries/jquery.jstree/3.3.15/
/libraries/jsoneditor/9.9.2/
```

When those directories exist, the module uses the local files instead of the CDN.
