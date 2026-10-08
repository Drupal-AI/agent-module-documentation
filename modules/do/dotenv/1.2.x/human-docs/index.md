# Dotenv — manual setup guide

**Dotenv** (`dotenv`) wires the Symfony Dotenv component into Drupal, so that
environment variables you declare in a project‑root `.env` file are parsed and
made available through PHP's `$_ENV` (and `$_SERVER`) superglobals. That lets you
keep database credentials, API keys, and other per‑environment settings **out of
your code** and out of version control — the Twelve‑Factor "config in the
environment" approach.

This is a thin, developer‑oriented integration. It adds no configuration entity,
settings form, permission, or admin page. Instead it delivers its value two ways:
a small `load.environment.php` bootstrap file that reads your `.env` early on every
request, and a set of Drush/Console commands that scaffold and manage the whole
setup for you.

The headline command, `drush dotenv:init`, does the wiring in one step — it creates
`.env` (seeded with your existing database credentials), a matching keyless
`.env.example` to commit as documentation, copies in the bootstrap file and
registers it with Composer, and adds `.env` to `.gitignore` so a secret is never
committed by accident. Two more commands help in production and debugging.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — Dotenv has no admin UI, no settings form, and no permissions. You work
with it entirely from the command line (Drush) and from your `.env` and
`settings.php` files.

## How to use it

### 1. Scaffold the integration (recommended)

After enabling the module, run:

```bash
drush dotenv:init
```

This does everything needed:

1. Creates `<project-root>/.env` with `APP_ENV` and your current database
   credentials (`DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST`, `DB_PORT`, and so
   on, read from your active database connection).
2. Creates `<project-root>/.env.example` with the same keys but **no values** —
   commit this so teammates know which variables to set.
3. Copies `load.environment.php` to the project root, adds it to `composer.json`
   under `autoload.files`, and runs `composer dump-autoload`.
4. Appends `.env` to `.gitignore`.
5. Appends `$databases['default']['default'][...] = $_ENV[...];` lines to
   `settings.php` so the site reads its DB credentials from the environment.

The command aborts without making changes if `.env` or `.env.example` already
exists, or if it can't find `settings.php`. It also accepts flags to skip parts of
the job — `--no-database-settings`, `--no-add-loader`, `--no-add-gitignore`.

### 2. Read variables in your code

Once the bootstrap file is loaded, read any variable from `$_ENV`. The most common
place is `settings.php`:

```php
$databases['default']['default'] = [
  'database' => $_ENV['DB_NAME'],
  'username' => $_ENV['DB_USER'],
  'password' => $_ENV['DB_PASSWORD'] ?? '',
  'host'     => $_ENV['DB_HOST'] ?? 'localhost',
  // …
];

// Override a contrib module's config from the environment:
$config['mandrill.settings']['mandrill_api_key'] = $_ENV['MANDRILL_API_KEY'];
```

You can also read `$_ENV` from a custom module's `ServiceProvider` to set a
container parameter.

### 3. Set up manually (if you prefer)

If you'd rather not use `dotenv:init`, copy `load.environment.php` from the
module's `files/` directory to your project root, add it to `composer.json`:

```json
"autoload": { "files": ["load.environment.php"] }
```

run `composer dump-autoload`, and create a `.env` containing at least
`APP_ENV=prod`. Note the bundled loader expects `.env` **one level above**
`DRUPAL_ROOT`.

### 4. On production: compile and debug

`.env` is parsed on **every request** unless you compile it. After any change to
`.env` on production, run:

```bash
drush dotenv:dump prod
```

This writes an optimised `.env.local.php` so PHP no longer re‑parses `.env` each
request. To troubleshoot which files were scanned and which variables loaded:

```bash
drush dotenv:debug
```
