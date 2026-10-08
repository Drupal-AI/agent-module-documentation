# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: >=8.0`).
- **[Consumers](https://www.drupal.org/project/consumers)** 1.19 or newer
  (`drupal/consumers`), which Composer installs as a dependency.
- Core's **Image** and **JSON:API** modules (`image`, `jsonapi`), both part of
  Drupal core. Drupal enables them automatically as dependencies.

### Recommended

- **[JSON:API Extras](https://www.drupal.org/project/jsonapi_extras)** — only
  needed if you want to attach the `image_styles` field enhancer to an individual
  image field (to scope styles per field rather than per consumer). It is
  suggested, not required.

## Install with Composer

From the project root:

```bash
composer require drupal/consumer_image_styles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it pulls in Consumers.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/consumer_image_styles -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en consumer_image_styles -y
```

Drush enables Consumers, Image, and JSON:API automatically if they are not
already on. Enabling the module adds the **Image Styles** field to the consumer
entity — there is no further configuration step here. See the
[overview](../index.md) for how to attach styles to a consumer.

## Submodules

Consumer Image Styles ships no submodules.
