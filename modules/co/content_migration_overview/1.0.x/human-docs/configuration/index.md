# Configuration

Content Migration Overview validates content that has been migrated from an older
site, so it needs to know how to connect to that **source** database. There are two
ways to provide the connection, and you only need one of them.

## Option 1 — Define the connection in `settings.php`

In addition to your normal `default` database connection, add a second connection
keyed **`migrate`** in `settings.php`, pointing at the source (old-site) database.
This is the same convention the core Migrate framework uses. For example:

```php
$databases['migrate']['default'] = [
  'database' => 'old_site_db',
  'username' => 'db_user',
  'password' => 'db_password',
  'host' => 'localhost',
  'driver' => 'mysql',
];
```

Storing credentials in `settings.php` is the right choice when you manage
connections in code and want them out of the database and the UI.

## Option 2 — Enter the connection in the admin UI

If you'd rather configure the source connection through the site:

1. Log in as an administrator.
2. Go to **Configuration → System → Migrate Database Credentials**, or navigate
   directly to `/admin/config/system/migrate-database-credentials`.
3. Fill in the source database's connection details (database name, username,
   password, host, and driver) and save.

## Run the migration summary

With the source connection in place, run the statistics command from your project
root:

```bash
drush migration:stat
```

or the shorter alias:

```bash
drush mstat
```

The command validates the migrated content data and prints a summary showing the
**total**, **passed**, and **failed** counts, along with the path to a generated
report file you can open for the details.

> **Using DDEV?** Run the command with the `ddev` prefix from your host —
> `ddev drush mstat` — or without the prefix inside `ddev ssh`.
