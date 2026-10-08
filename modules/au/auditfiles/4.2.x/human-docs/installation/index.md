# Installation

## Requirements

- **Drupal 10.3+ or 11.1+** (`core_version_requirement: ^10.3 || ^11.1`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **File** module enabled — the only dependency, and Drupal enables it
  automatically.

There are no third-party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/auditfiles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auditfiles -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auditfiles -y
```

There are no submodules. The reports appear under **Reports → Audit Files** and the
settings form under **Configuration → System → Audit Files**.

## Grant the permissions

Nobody can reach the reports or settings until you assign the module's two
permissions at **People → Permissions** (`/admin/people/permissions`), or from the
command line:

```bash
drush role:perm:add site_maintainer 'access audit files reports'
drush role:perm:add administrator 'configure audit files reports'
```

See [Configuration](../configuration/index.md) for exactly what each permission
gates and what the reports do.

## Verify it worked

Visit `/admin/reports/auditfiles`. You should see the Audit Files landing page
linking to the seven reports.
