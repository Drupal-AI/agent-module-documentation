# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer.**
- Core's **Field UI** (`field_ui`) and **Media** (`media`) modules.
- The **Key** module (`key`), used to store your Scribit.pro API token securely.
- A **Scribit.pro account**, from which you obtain your Scribit ID and an API token.

There are no extra third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/scribit_pro -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scribit_pro -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scribit_pro -y
```

## Verify it worked

Go to **Configuration → System → Scribit Pro** (`/admin/config/system/scribit-pro`).
You should see the settings form asking for a Scribit ID and an API-token Key. The
module does nothing until it is configured — follow
[Configuration](../configuration/index.md) to enter your credentials and set up a
Remote Video media type.
