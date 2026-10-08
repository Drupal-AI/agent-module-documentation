# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contrib modules are required.
- The **Prism.js** JavaScript/CSS library for syntax highlighting. You can let
  the module load it from an external source, or download it and host it locally
  (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/text_file_viewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/text_file_viewer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

> **Note:** the release documented here is a beta (`1.1.0-beta1`) and the module
> is minimally maintained (maintenance fixes only). Test it before relying on it
> in production.

## Enable the module

```bash
drush en text_file_viewer -y
```

## Verify it worked

On a content type that has a file field, go to **Manage display**, and check
that **Text File Viewer** appears as a formatter option for that field. Then
open the module's configuration to pick the Prism library location and the file
extensions to highlight — see [Configuration](../configuration/index.md).
