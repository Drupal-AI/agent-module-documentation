# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **Migrate Plus** (`migrate_plus`) — a required contrib dependency that provides
  the migration configuration entities this module drives. Composer pulls it in
  automatically with the command below.
- Core's **Migrate** module (enabled as part of the migration stack).
- Access to your site's `settings.php`, and the connection details for the
  external database you want to import from.

There are no additional PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_content_migration_via_cron -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Migrate Plus — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_content_migration_via_cron -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_content_migration_via_cron -y
```

Enabling this module also enables Migrate Plus if it is not already on.

## Register your source database

The module imports from an external database, which you declare in `settings.php`
under the `migrate` connection key. For example:

```php
$databases['migrate']['default'] = [
  'database'  => 'source_db',
  'username'  => 'root',
  'password'  => '',
  'prefix'    => '',
  'host'      => '127.0.0.1',
  'port'      => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver'    => 'mysql',
];
```

This is a trusted connection you control; the module never takes a database or URL
from user input.

Next, tell cron which migrations to run and how often — see
[Configuration](../configuration/index.md).

## Verify it worked

After adding your schedule (next page) and running cron
(`drush cron`), check **Reports → Recent log messages**
(`/admin/reports/dblog`) and the migration's status. Nodes from your source table
should begin appearing on the site as each migration's interval comes due.
