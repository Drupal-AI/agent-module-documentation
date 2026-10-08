# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Drupal core's **Image** module (`image`), which Drupal enables automatically as
  a dependency.
- An **Unsplash API application** (free to create) so you have an access key — see
  [Configuration](../configuration/index.md).

There are no other contributed‑module dependencies and no third‑party PHP
libraries to install. Note this branch is an alpha (`2.0.0-alpha2`), so test before
relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_unsplash -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_unsplash -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_unsplash -y
```

Core's Image module is enabled automatically if it is not already on.

## Verify it worked

The module is installed, but it cannot fetch photos until you give it Unsplash API
credentials. Continue to [Configuration](../configuration/index.md) to create an
Unsplash application, store the key securely, and connect the module.
