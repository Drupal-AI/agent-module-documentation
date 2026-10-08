# Installation

## Requirements

Development Mode is self-contained. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, and no third-party Composer or PHP libraries.

One practical requirement is worth calling out: for the smoothest behaviour your
**`settings.php` should be writable** when you enable the module, so it can append
its include cleanly. If it is not writable, the module falls back to editing
`sites/default/services.yml` — which involves temporarily changing the
permissions on `sites/default`. See the warnings below.

## Install with Composer

From the project root:

```bash
composer require drupal/dev_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dev_mode -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dev_mode -y
```

As soon as it is enabled the site is in development mode: Twig debugging on,
caches off, verbose errors, no aggregation, and no-cache meta tags on every page.

> **Never enable this on a production site.** It sets error reporting to *verbose*
> (which prints backtraces to visitors), turns off page and render caching, and
> writes to `settings.php`. If `settings.php` is not writable it will `chmod`
> `sites/default` to `0777` while it edits `services.yml`, then set it to `0555`.

## Turning it off

Uninstall the module to reverse everything cleanly:

```bash
drush pmu dev_mode -y
```

The module restores your original performance and logging settings from the state
snapshot it saved at install time, removes the include from `settings.php`, and
undoes any `services.yml` fallback edits. After uninstalling, double-check the
permissions on `sites/default` in case the fallback path left them at `0555`.

There are no submodules.
