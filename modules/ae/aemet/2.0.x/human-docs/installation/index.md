# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- A **free AEMET OpenData API key** — request one from AEMET's OpenData portal.
  You do not need it to install the module, but you do need it before the module
  can fetch any forecasts.

There are no additional module dependencies and no third-party PHP libraries to
install; the module uses Drupal's built-in HTTP client to reach AEMET.

## Install with Composer

From the project root:

```bash
composer require drupal/aemet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aemet -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aemet -y
```

## Next step

Once enabled, the module does nothing visible until you enter your API key and
place the forecast block. Continue to
[Configuration](../configuration/index.md).
