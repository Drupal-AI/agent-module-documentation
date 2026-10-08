<!-- SPDX-License-Identifier: MIT -->
# Drush / Console commands

Registered in `drush.services.yml`. One native Drush command plus two Symfony Console commands.

## `drush dotenv:init`

Class `Drupal\dotenv\Commands\DotenvInitCommand`. Scaffolds the full `.env` integration for the project
(see `configure/setup.md` for exactly what it writes). Interactive prompts fill any option left unset.

Options (all default `TRUE`):
- `--database-settings` — write DB credentials into `.env`/`.env.example` and append
  `$databases[...] = $_ENV[...];` lines to `settings.php`.
- `--add-loader` — copy `load.environment.php` to the Composer root, add it to `composer.json`
  `autoload.files`, and run `composer dump-autoload`.
- `--add-gitignore` — append `.env` to `.gitignore`.

Aborts without changes if `.env` or `.env.example` already exists, or `settings.php` is not found.

```bash
drush dotenv:init                                  # interactive
drush dotenv:init --no-database-settings           # skip DB creds, still add loader + gitignore
```

## `dotenv:dump` (Symfony `DotenvDumpCommand`)

Compiles the `.env` (and `.env.local`, `.env.<env>`, …) files at `%dotenv.project_dir%` into an
optimized `.env.local.php`, so PHP does not re-parse `.env` on every request. Run it on production
**every time `.env` changes**. Argument is the target environment (defaults to `%dotenv.environment%`).

```bash
drush dotenv:dump prod
```

## `dotenv:debug` (Symfony `DebugCommand`)

Prints the dotenv files that were scanned (relative to `%dotenv.project_dir%`) and the variables that
were loaded for the current environment. Use it to troubleshoot why a variable is or isn't set.

```bash
drush dotenv:debug
```

Container parameters `dotenv.project_dir` (Composer root) and `dotenv.environment`
(`$_ENV['APP_ENV'] ?? 'prod'`) are supplied to the two console commands by `DotenvServiceProvider`.
