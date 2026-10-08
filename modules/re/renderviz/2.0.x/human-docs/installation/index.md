# Installation

## Requirements

- **Drupal core 11.2 or newer** (`core_version_requirement: ^11.2 || ^12`).
- No modules outside of Drupal core are required.

There are no third‑party Composer or PHP library requirements. This is a
development tool — install it in your local or staging environment, not on
production.

## Install with Composer

From the project root:

```bash
composer require drupal/renderviz -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you manage dev-only tools separately, consider
requiring it with `--dev`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/renderviz -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en renderviz -y
```

There is no configuration step — the module has no settings.

## Verify it worked

With RenderViz enabled in your development environment, browse the site and
confirm the cacheability visualization is available. When you finish debugging,
disable and uninstall it so internal cache detail is not surfaced on a live site:

```bash
drush pmu renderviz -y
```
