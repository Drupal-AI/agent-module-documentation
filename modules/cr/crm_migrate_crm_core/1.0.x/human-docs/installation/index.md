# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`) as the target site.
- The following modules, which Composer installs as dependencies:
  - **CRM** (`crm`) — migrations create `crm_contact` and `crm_relationship` entities.
  - **Migrate** (core `migrate`).
  - **Migrate Plus** (`migrate_plus`).
- **Read access to the Drupal 7 database** that contains the CRM Core and Relation
  tables.
- **Recommended:** the Migrate Tools module (with Drush) for running and managing the
  migrations from the command line.

## Install with Composer

From the project root:

```bash
composer require drupal/crm_migrate_crm_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update CRM, Migrate
Plus, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crm_migrate_crm_core -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crm_migrate_crm_core -y
```

## Connect the Drupal 7 source database

The migration reads directly from your old site's database, so you must register it as a
migrate source connection. In your `settings.php`, add a second database connection under
the `migrate` key pointing at the Drupal 7 database — for example:

```php
$databases['migrate']['default'] = [
  'database' => 'drupal7db',
  'username' => '…',
  'password' => '…',
  'host' => '…',
  'driver' => 'mysql',
];
```

(See the module's README or documentation for the exact source key and any
migrate_plus source-config alternative.) Read-only access is sufficient — the migration
does not write to the D7 database.

## Verify it worked

After enabling the module and connecting the source database, run
`drush migrate:status`. You should see the `crm_core_contact` and
`crm_core_relationship` migrations listed. If they do not appear, import the migration
config as shown on the [overview page](../index.md), then check status again. Next, set
the bundle mapping — see [Configuration](../configuration/index.md).
