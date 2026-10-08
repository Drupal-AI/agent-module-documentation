# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- A free or paid **ipstack.com account** and its **API access key**.
- Outbound HTTPS access from your server to ipstack.com.

There are no module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/ipstack -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ipstack -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ipstack -y
```

## Verify it worked

Go to **Configuration → System → IPstack** (`/admin/config/system/ipstack`). If the
settings form loads, the module is installed. It will not return geolocation data
until you add your access key — see [Configuration](../configuration/index.md).
