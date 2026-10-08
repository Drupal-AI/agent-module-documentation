# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **Zoho Bigin account** and a registered Zoho OAuth application to obtain API
  credentials.

There are no additional module dependencies and no third-party Composer or PHP
library requirements listed.

> **Note:** This release is an alpha (`1.0.1-alpha2`). Test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/bigin_crm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bigin_crm -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bigin_crm -y
```

After enabling, continue to [Configuration](../configuration/index.md) to store your
Zoho Bigin OAuth credentials securely and connect the CRM.
