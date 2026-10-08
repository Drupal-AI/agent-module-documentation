# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) — pulled in automatically as a dependency.
- **Optional:** the **CSP** module (`drupal/csp`). If present, the module adds your
  allowed Data & Insights hosts to the `frame-src` Content-Security-Policy directive so
  the embeds are not blocked. It is not required.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_tyler_data_insights -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_tyler_data_insights -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_tyler_data_insights -y
```

## Next steps

Create a media type using the **Tyler Data & Insights** source, and list the Data &
Insights domains you embed from — see [How to use it](../index.md#how-to-use-it) and
[Configuration](../configuration/index.md).
