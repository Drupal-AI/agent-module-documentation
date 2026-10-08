# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- The **POTX** module (`drupal/potx`, Translation Template Extractor) — a hard
  dependency; the command loads `potx.inc` / `potx.local.inc` at runtime.
- **Drush `^13`** to run the command.
- **At least one unlocked, translatable language** configured on the site,
  otherwise the command errors out.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/drush_pet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in POTX and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/drush_pet -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush_pet -y
```

This also enables POTX if it isn't already on. Because PET exists purely to add a
developer Drush command — and it writes into your project's source tree — keep it
to **development / local** environments, not production.

## Verify it worked

Confirm Drush can see the command:

```bash
drush help potx:extract-translations
```

If the help text appears (listing the `--type`, `--group` and `--language`
options), PET is installed and ready. For a real run, point it at a project that
contains translatable strings and check for a new
`translations/<project>.<lang>.po` file inside that project's directory.
