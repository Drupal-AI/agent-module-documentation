# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **System** module (always present).
- A valid **DaData API key** — free or paid, from
  [dadata.ru](https://dadata.ru/).
- No additional contrib modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/dadata_integration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dadata_integration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dadata_integration -y
```

## Verify it worked

Go to **Configuration → Web services → DaData Integration**
(`/admin/config/services/dadata`) and confirm the settings form loads. Enter your
API key and add the fields you want to enhance — see
[Configuration](../configuration/index.md).
