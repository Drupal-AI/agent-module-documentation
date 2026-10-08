# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`drupal/key`) — used to store the API access credentials.
- An **Engaging Networks account** with REST API access enabled.

> **Heads up:** on Drupal.org this project is currently marked *Unsupported /
> no further development*, though it is covered by the security advisory policy.
> Weigh the maintenance status before adopting it on a new site. Only the REST API
> service is currently supported.

## Install with Composer

From the project root:

```bash
composer require drupal/engaging_networks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Key
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/engaging_networks -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en engaging_networks -y
```

This also enables the Key module if it is not already on.

## Verify it worked

Confirm the module is enabled on the **Extend** page (`/admin/modules`), then
visit **Configuration → Engaging Networks → REST API**
(`/admin/config/engaging-networks/settings/rest-api`) and confirm the settings
form loads. From there, continue to [Configuration](../configuration/index.md) to
enter your API credentials.
