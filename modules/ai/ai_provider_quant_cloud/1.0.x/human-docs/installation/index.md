# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **[AI module](https://www.drupal.org/project/ai)** (`ai`) — this provider is
  a plugin for it.
- The **[Key module](https://www.drupal.org/project/key)** (`key`) to hold the
  OAuth client credentials securely.
- A **Quant Cloud** account (QuantCDN / QuantGov) with OAuth client credentials for
  its Dashboard API.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_provider_quant_cloud -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update the AI
and Key modules as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_provider_quant_cloud -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_provider_quant_cloud -y
```

Enabling it also enables the AI and Key modules if they are not on yet. The module
ships no submodules.

Continue to [Configuration](../configuration/index.md) to add your OAuth
credentials.
