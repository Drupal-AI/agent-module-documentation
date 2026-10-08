# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- A **MySQL/MariaDB** database (the module reads table sizes from the server's
  `information_schema`).
- No other Drupal module, Composer, or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/database_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/database_dashboard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the information_schema connection (required)

To calculate table and index sizes, the module needs a database connection to the
server's `information_schema`. Add a `schema` connection to your `settings.php` (or
`settings.local.php`), reusing your database's host and credentials:

```php
$databases['schema']['default'] = [
  'host'      => 'mariadb',            // adapt to your DB host (e.g. 'db')
  'database'  => 'information_schema',
  'username'  => 'drupal',             // adapt
  'password'  => 'drupal',             // adapt
  'prefix'    => '',
  'port'      => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver'    => 'mysql',
];
```

Adjust the host, database credentials, and port to match your environment. Because
these are database credentials, keep them in `settings.php`/`settings.local.php`
(never in exported configuration or version control).

## Enable the module

```bash
drush en database_dashboard -y
```

## Set the permission

On **People → Permissions**, grant **`access database_dashboard`** only to trusted
administrator roles. The report exposes operational database details, so keep it
tight.

## Verify it worked

Log in as a user with the `access database_dashboard` permission and open **Reports
→ Database Dashboard** (`/admin/reports/database`). You should see the largest
tables by size and row count, plus cache‑table information. If the sizes are blank,
re‑check the `information_schema` connection you added to `settings.php`.
