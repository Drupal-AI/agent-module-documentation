# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- The PHP **`intl`** extension (`ext-intl`) must be available — the module uses
  it. Most DDEV and modern hosting images include it; confirm with
  `php -m | grep intl`.
- An **ActiveCampaign account** with API access, so you can obtain an API URL and
  token.

## Install with Composer

From the project root:

```bash
composer require drupal/active_campaign_api_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/active_campaign_api_integration -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en active_campaign_api_integration -y
```

Once enabled, continue to [Configuration](../configuration/index.md) to save your
ActiveCampaign credentials and start mapping forms.

> **Access note:** the module's admin routes are gated by a permission named
> `administrator`, which is actually a *role name* rather than a real permission.
> As a result the tools are reachable only by user 1 (the superuser) unless you
> adjust the module's routing to use a genuine permission. Keep this in mind if
> the dashboard appears empty or inaccessible for other administrators.
