# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other modules or third-party libraries are required.

Because tokens are bearer credentials, plan to serve the site over **HTTPS** — a
token sent over plain HTTP can be sniffed in transit.

## Install with Composer

From the project root:

```bash
composer require drupal/access_token_auth -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_token_auth -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_token_auth -y
```

Once enabled, visit the settings form, grant the permissions carefully, and
generate a token — see [Configuration](../configuration/index.md).
