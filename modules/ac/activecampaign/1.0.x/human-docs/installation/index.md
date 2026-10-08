# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).
- An **ActiveCampaign account** with API access (you'll need the account's API
  URL and an API key).
- The **Webform** module if you plan to use the `activecampaign_webform`
  submodule.

There are no third-party Composer or PHP library requirements for the base
module. This is a release candidate (1.0.0-rc1), so test before production.

## Install with Composer

From the project root:

```bash
composer require drupal/activecampaign -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/activecampaign -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en activecampaign -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **ActiveCampaign Dashboard** | `activecampaign_dashboard` | An in-Drupal dashboard view of your ActiveCampaign data. |
| **ActiveCampaign Webform** | `activecampaign_webform` | Sends Webform submissions into ActiveCampaign. Requires the Webform module. |

For example:

```bash
drush en activecampaign_dashboard -y
```

Each submodule requires the base ActiveCampaign module. After enabling, continue
to [Configuration](../configuration/index.md) to connect your account.
