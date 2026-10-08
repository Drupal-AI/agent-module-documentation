# Installation

Installing this module is a two‑step job: pull in the code with Composer, then
wire the custom driver into a database connection in `settings.php`. You do
**not** enable it through the Drupal modules UI — the driver is activated purely
by the connection settings.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **MySQL** driver module (`mysql`) — this driver extends it.
- A MySQL/MariaDB database (the driver wraps the standard MySQL driver).
- PHP must have write access to wherever you point the log file.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mysql_query_logger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer with `ddev` when you run from your host
> machine — `ddev composer require drupal/mysql_query_logger -W`. Inside the
> container (`ddev ssh`) run it without the prefix.

## Activate the driver in settings.php

There is no `drush en` step. Instead, edit your `settings.php` (usually near the
end) and repoint the database connection at the logging driver. Adjust the
`autoload` and `output` paths to match where the module actually lives in your
project:

```php
// Record all database activity through the logging driver.
$databases['default']['default']['driver'] = 'mysql_query_logger';
$databases['default']['default']['namespace'] = 'Drupal\\mysql_query_logger\\Driver\\Database\\mysql_query_logger';
$databases['default']['default']['autoload'] = 'web/modules/contrib/mysql_query_logger/src/Driver/Database/mysql_query_logger/Connection.php';
// Absolute or relative path for the log output file.
$databases['default']['default']['output'] = '/absolute/path/mysql_query_logger.log';

require_once DRUPAL_ROOT . '/core/modules/mysql/src/Driver/Database/mysql/Connection.php';
require_once DRUPAL_ROOT . '/modules/contrib/mysql_query_logger/src/Driver/Database/mysql_query_logger/Connection.php';
```

If you omit the `output` key, the log defaults to `/tmp/mysql_query_logger.txt`.
Make sure the log file is writable by the web server user, for example:

```bash
touch /absolute/path/mysql_query_logger.log
chmod 664 /absolute/path/mysql_query_logger.log
```

> **Keep it out of the docroot.** Never point `output` at a web‑accessible path —
> the log can contain password hashes, session identifiers, and other secrets.
> Use a location outside your public files directory.

## Verify it worked

Load a few pages of your site, then open the log file. You should see one line
per database operation, each with a timestamp, operation type, duration, and a
JSON dump of the query and its arguments.

## Turning it off

Remove or comment out the custom `driver`/`namespace`/`autoload`/`output` lines
(and the two `require_once` lines) so the connection returns to the standard
`mysql` driver, then delete the log file. Switch back to the standard driver
before running config import/export or other Drush utilities, and before
deploying to production.
