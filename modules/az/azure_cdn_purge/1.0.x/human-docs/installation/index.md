# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Purge** module (`purge`) — this is a hard dependency; Azure CDN Purger is a
  purger plugin that runs inside Purge's queue/processor framework.
- An **Azure CDN** profile/endpoint in front of your site, plus credentials that are
  allowed to call its purge API.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_cdn_purge -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Purge (if not already present) and
updates shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_cdn_purge -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_cdn_purge -y
```

This also enables Purge if it wasn't already on. After enabling, you still need to
configure the Azure credentials and add the purger inside Purge — see
[Configuration](../configuration/index.md).
