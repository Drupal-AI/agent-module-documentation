# Installation

## Requirements

Microsoft Entra ID SSO Login needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **User** module (`user`), which is always present.

There are no other module dependencies and no third‑party library requirements.
You will also need an application registered in your **Azure / Microsoft Entra ID**
tenant to obtain the credentials used in configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_entra_id -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_entra_id -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_entra_id -y
```

## Next step

Nothing happens until you register an Azure application and enter its Client ID,
Tenant ID, and Client Secret — continue to
[Configuration](../configuration/index.md).
