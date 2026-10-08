# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- A **Bitly account** with a registered OAuth application, so you have a client
  ID and client secret to authorize the site (see
  [Configuration](../configuration/index.md)).

There are no additional Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bitly_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bitly_links -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bitly_links -y
```

Once enabled, the admin pages appear under `/admin/bitly_links`. The module cannot
shorten anything until you authorize a Bitly app — continue to
[Configuration](../configuration/index.md).
