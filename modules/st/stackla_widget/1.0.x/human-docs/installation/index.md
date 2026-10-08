# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The `guzzlehttp/guzzle` HTTP client library, used by the module's Stackla API
  SDK. Composer pulls it in automatically when you require the module.
- No other module dependencies.

You will also need a **Stackla (Nosto) account** with a stack shortname and OAuth2
credentials (client ID and secret) to authorise the connection — see
[Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/stackla_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/stackla_widget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stackla_widget -y
```

Or enable **Stackla Widget** from the Extend page (`/admin/modules`).

## Verify it worked

Go to **Configuration → Web services → Stackla Widget → Settings**
(`/admin/config/services/stackla_widget/settings`). If the settings form loads, the
module is installed — continue to [Configuration](../configuration/index.md) to
enter your Stackla credentials and run the OAuth2 authorise flow.
