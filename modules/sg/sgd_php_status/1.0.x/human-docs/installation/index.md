# Installation

## Requirements

Site Guardian PHP Status is deliberately lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).

There are no dependent modules, no third-party Composer packages, and no PHP
library requirements. It pairs naturally with the rest of the *Site Guardian*
monitoring framework, but it does not require it — the PHP details it adds show up
on the core Status report either way.

## Install with Composer

From the project root:

```bash
composer require drupal/sgd_php_status -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sgd_php_status -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sgd_php_status -y
```

That's all it takes. There is no required configuration.

## Verify it worked

Log in as an administrator and go to **Reports → Status report**
(`/admin/reports/status`). You should see the additional PHP information the module
contributes among the report entries.
