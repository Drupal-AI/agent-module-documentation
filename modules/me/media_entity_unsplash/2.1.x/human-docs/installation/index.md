# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- Drupal core modules **Image** (`image`), **Media Library** (`media_library`),
  **Path** (`path`), and **User** (`user`), which Drupal enables automatically as
  dependencies.
- The **`unsplash/unsplash`** PHP SDK, pulled in automatically by Composer when you
  require the module.
- An **Unsplash API application** (free to create) so you have an Access Key and
  Secret Key — see [Configuration](../configuration/index.md).

There are no other contributed-module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_unsplash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed and install the `unsplash/unsplash` SDK the module requires.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_unsplash -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_unsplash -y
```

The core Image, Media Library, Path, and User modules are enabled automatically if
they are not already on. After installation an **Unsplash** media type is available
on your site.

## Verify it worked

The module is installed, but it cannot fetch photos until you give it Unsplash API
credentials. Continue to [Configuration](../configuration/index.md) to create an
Unsplash application and connect the module.
