# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **ActiveCampaign account** with API access (API URL + key).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/activecampaign_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/activecampaign_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en activecampaign_api -y
```

After enabling, grant the **Manage ActiveCampaign API settings**
(`manage activecampaign_api settings`) permission to the administrators who
should provide the credentials, then continue to
[Configuration](../configuration/index.md).
