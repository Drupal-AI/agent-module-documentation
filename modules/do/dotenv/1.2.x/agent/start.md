<!-- SPDX-License-Identifier: MIT -->
# Dotenv — agent index

Integrates `symfony/dotenv` with Drupal: variables in a project-root `.env` become available in
`$_ENV` / `$_SERVER`. **No** Drupal config, settings form, configure route, permission, or plugin
type. Everything it adds is a bootstrap file (`load.environment.php`) plus Drush/Console commands.

- **Set up `.env` integration, read variables, `settings.php` usage** → [configure/setup.md](configure/setup.md)
- **Drush/Console commands: `dotenv:init`, `dotenv:dump`, `dotenv:debug`** → [drush/commands.md](drush/commands.md)

Key facts:
- `drush dotenv:init` scaffolds `.env` + `.env.example` + `load.environment.php` (autoloaded via
  `composer.json`) + `.gitignore` entry, seeding DB creds from `settings.php`.
- Once loaded, read values with `$_ENV['NAME']` (e.g. in `settings.php`).
- Container params (set by `DotenvServiceProvider`): `dotenv.project_dir` (Composer root) and
  `dotenv.environment` (`$_ENV['APP_ENV'] ?? 'prod'`).
- On production run `dotenv:dump` after `.env` changes to compile `.env.local.php` (avoids per-request parsing).
