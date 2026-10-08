# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No other contrib modules and no third-party PHP libraries are required.
- **A development or staging environment.** This module must never be enabled in
  production — see the warning below.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_debug -W
```

The Composer package name (`drupal/symfony_debug`) matches the module's machine
name (`symfony_debug`). The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_debug -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

You may prefer to require it as a development-only dependency (`--dev`) so it is
never installed on a production build in the first place.

## Enable the module

```bash
drush en symfony_debug -y
```

The Symfony debug error handler takes over immediately — there is no
configuration to do. Trigger an error and you will see the detailed Symfony
error page.

## A production warning you must not skip

The debug error page shows **full stack traces, file paths, code excerpts, and
request/environment context**. On a publicly reachable site that is an
information-disclosure hole — a code and infrastructure map for an attacker.
**Never enable this module in production.** Use it only in development or
staging, disable it when you are done, and confirm it is off before deploying.
As an extra safeguard, keep Drupal's production error-display setting configured
to hide errors from users.
