# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Smartsheet account** and a valid **API access token** (see
  [Configuration](../configuration/index.md) for how to generate one). The module
  cannot do anything without it.
- No additional contrib-module dependencies. The module talks to the API over HTTP
  using Guzzle, which Drupal core already provides.

## Install with Composer

From the project root:

```bash
composer require drupal/smartsheet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smartsheet -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smartsheet -y
```

## Next step

Before the `smartsheet.client` service or the form integration will work, you must
supply a Smartsheet access token. Continue to
[Configuration](../configuration/index.md).
