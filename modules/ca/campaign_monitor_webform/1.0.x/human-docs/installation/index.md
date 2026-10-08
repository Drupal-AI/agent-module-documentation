# Installation

## Requirements

- **Drupal 8.8.3+, 9, or 10** (`core_version_requirement: ^8.8.3 || ^9 || ^10`).
- The **[Webform](https://www.drupal.org/project/webform)** module (`webform`).
- The **[Campaign Monitor REST Client](https://www.drupal.org/project/campaign_monitor_rest_client)**
  module (`campaign_monitor_rest_client`), which holds the API key and performs all
  the HTTPS calls to Campaign Monitor. Set your API key up there — see that module's
  configuration guide.

## Install with Composer

From the project root:

```bash
composer require drupal/campaign_monitor_webform -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the dependencies and updates any
shared ones as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/campaign_monitor_webform -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en campaign_monitor_webform -y
```

Drupal will enable `webform` and `campaign_monitor_rest_client` at the same time if
they aren't already on. Once everything is enabled, make sure the REST client's API
key is configured, then add the handler to a webform — see
[Configuration](../configuration/index.md).
