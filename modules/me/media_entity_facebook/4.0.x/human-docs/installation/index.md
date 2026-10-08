# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Media** module (`media`) — it is a required dependency and Drupal
  enables it automatically.
- No third-party Composer or PHP library requirements.

Nothing else is needed for the default **Embedded Posts** mode. Only the
optional **oEmbed API** mode needs a reviewed Facebook app and its
credentials — see [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_facebook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_facebook -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_facebook -y
```

This makes the **Facebook** media source available. The module ships no media
type of its own, so the next step is to create one and select the Facebook
source — continue to [Configuration](../configuration/index.md).
