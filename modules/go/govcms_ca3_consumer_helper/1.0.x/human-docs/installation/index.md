# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** (`media`) and **Link** (`link`) modules — hard dependencies that
  Drupal enables for you.
- Access to the **CA3** (Content API) service whose media you intend to embed.

## Install with Composer

From the project root:

```bash
composer require drupal/govcms_ca3_consumer_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/govcms_ca3_consumer_helper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en govcms_ca3_consumer_helper -y
```

Enabling the module also turns on the Media and Link modules if they are not
already on, registers CA3 as an oEmbed provider, and sets up the CA3 media fields.

## Verify it worked

Check that CA3 media fields are present in your media configuration and that you can
embed CA3 media through Drupal's standard media workflow (a media field or the media
library). Because the module configures everything on install, there is no settings
form to visit afterwards.
