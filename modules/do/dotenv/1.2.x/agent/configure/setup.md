<!-- SPDX-License-Identifier: MIT -->
# Set up .env integration and read variables

Dotenv has **no configure route** (`configure: null`) and no Drupal settings. "Configuration" means
wiring the `.env` file into the project bootstrap. Two ways: automatic (Drush) or manual.

## Automatic (recommended)

```bash
drush dotenv:init
```

This (see `drush/commands.md` for options):
1. Creates `<composer-root>/.env` with `APP_ENV=<getenv APP_ENV or prod>` and the DB credentials read
   from `Database::getConnectionInfo()` mapped to keys `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`,
   `DB_PORT`, `DB_DRIVER`, `DB_PREFIX`, `DB_COLLATION`.
2. Creates `<composer-root>/.env.example` with the same keys but **no values**.
3. Copies `load.environment.php` to the Composer root and adds it to `composer.json` `autoload.files`,
   then runs `composer dump-autoload`.
4. Appends `.env` to `.gitignore`.
5. Appends `$databases['default']['default']['<key>'] = $_ENV['<DB_KEY>'];` lines to `settings.php`.

It aborts (warning, no changes) if `.env` or `.env.example` already exists, or if `settings.php` is missing.

## Manual

Copy `files/load.environment.php` to the project root, add it to `composer.json`:

```json
"autoload": { "files": ["load.environment.php"] }
```

Run `composer dump-autoload`. Create a `.env` containing at least:

```
APP_ENV=prod
```

`load.environment.php` calls `(new Dotenv())->usePutenv()->bootEnv(DRUPAL_ROOT . '/../.env', 'dev', ['test'], TRUE);`
— note the default environment is `dev` and it expects `.env` **one level above** `DRUPAL_ROOT`.

## Reading variables

After the file is loaded, values are in the `$_ENV` superglobal. Typical `settings.php` usage:

```php
$databases['default']['default'] = [
  'database' => $_ENV['DB_NAME'],
  'username' => $_ENV['DB_USER'],
  'password' => $_ENV['DB_PASSWORD'] ?? '',
  'host'     => $_ENV['DB_HOST'] ?? 'localhost',
  'port'     => $_ENV['DB_PORT'] ?? 3306,
  'driver'   => 'mysql',
  'namespace'=> 'Drupal\\mysql\\Driver\\Database\\mysql',
];

$config['mandrill.settings']['mandrill_api_key'] = $_ENV['MANDRILL_API_KEY'];
```

Or from a module `ServiceProvider::register()`:

```php
$container->setParameter('yourmodule.some_secret', $_ENV['SOME_SECRET']);
```

## Container parameters

`DotenvServiceProvider::alter()` sets, if not already present:
- `dotenv.project_dir` → the Composer root (found via `webflo/drupal-finder`).
- `dotenv.environment` → `$_ENV['APP_ENV'] ?? 'prod'`.

These feed the `dotenv:dump` / `dotenv:debug` console commands.

## Production note

`.env` is parsed on **every request** unless compiled. After any `.env` change on production run
`drush dotenv:dump` to write an optimized `.env.local.php`.
