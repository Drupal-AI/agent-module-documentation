<!-- SPDX-License-Identifier: MIT -->
Dotenv wires the Symfony Dotenv component into Drupal so environment variables declared in a project-root `.env` file are parsed and exposed via `$_ENV` / `$_SERVER`, letting you keep credentials and per-environment config out of code.

---

The module is a thin integration layer around `symfony/dotenv`. It adds no Drupal config entity, settings form, permission, or configure route. Its value is delivered two ways: a `load.environment.php` bootstrap file (copied into your project and registered under Composer's `autoload.files`) that calls `Dotenv::bootEnv()` to read `.env` at request time, and a set of Drush/Console commands wired up in `drush.services.yml`. The headline command is `drush dotenv:init`, which scaffolds the whole integration for you — it creates `.env` (seeded with `APP_ENV` and your `settings.php` database credentials), a matching keyless `.env.example`, copies `load.environment.php` and adds it to `composer.json` autoload, and appends `.env` to `.gitignore`. Two Symfony console commands are also registered: `dotenv:dump` (compiles `.env` into an optimized `.env.local.php` so production does not re-parse the file every request) and `dotenv:debug` (shows which dotenv files were scanned and which variables were loaded). A `DotenvServiceProvider` sets the container parameters `dotenv.project_dir` (the Composer root, located via `webflo/drupal-finder`) and `dotenv.environment` (`$_ENV['APP_ENV']` or `prod`) that the console commands consume. Once loaded, variables are read anywhere with `$_ENV['NAME']` — typically in `settings.php` for database, mail, or API credentials.

---

- Keep database credentials out of `settings.php` by reading `$_ENV['DB_NAME']`, `$_ENV['DB_USER']`, `$_ENV['DB_PASSWORD']` from a `.env` file.
- Scaffold `.env`, `.env.example`, `load.environment.php`, and `.gitignore` entries in one step with `drush dotenv:init`.
- Store third-party API keys (Mandrill, Stripe, S3, etc.) in `.env` and reference them from config overrides in `settings.php`.
- Follow the Twelve-Factor App "config in the environment" principle on a Drupal site.
- Provide per-environment values (`APP_ENV=dev` vs `prod`) that switch behavior without code changes.
- Ship a committed `.env.example` documenting every required variable while keeping real secrets untracked.
- Compile `.env` to `.env.local.php` with `drush dotenv:dump` so production skips runtime parsing for performance.
- Debug which `.env` files are scanned and which variables are loaded with `drush dotenv:debug`.
- Set container parameters from environment variables inside a custom module's `ServiceProvider` (`$container->setParameter('mymod.secret', $_ENV['SOME_SECRET'])`).
- Override contrib module config (e.g. `$config['mandrill.settings']['mandrill_api_key'] = $_ENV['MANDRILL_API_KEY'];`) from the environment.
- Give each developer their own local `.env` while everyone shares the same committed code.
- Move secrets out of version control retroactively on an existing project.
- Supply CI/CD pipelines with build- or deploy-time variables through `.env`.
- Read environment variables in Drush by leveraging Drush's own env-var option support alongside dotenv.
- Configure reverse-proxy, trusted-host, or Redis connection settings per environment via `$_ENV`.
- Centralize mail transport (SMTP host/user/pass) configuration in `.env`.
- Use a single codebase across local, staging, and production with environment-specific `.env` files.
- Locate the Composer root reliably across project layouts using the bundled `webflo/drupal-finder`.
- Seed a brand-new site's `.env` automatically from the existing database connection in `settings.php`.
- Avoid hardcoding the site's hashing salt or other sensitive constants by sourcing them from the environment.
- Keep `.env` ignored by Git automatically so a secret is never accidentally committed.
- Bootstrap environment variables early (before Drupal kernel) via the autoloaded `load.environment.php`.
