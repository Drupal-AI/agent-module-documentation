# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

Localization server is a suite of modules that builds a community
translation‑management platform. It is a substantial piece of software rather than
a lightweight add‑on, so install it on a site you intend to dedicate to hosting
translations. The Drupal 10/11 version is an active port of the long‑standing
Drupal 7 platform.

## Install with Composer

From the project root:

```bash
composer require drupal/l10n_server -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/l10n_server -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en l10n_server -y
```

The project ships as a suite; enable the additional components you need (for
example the connectors that import source strings) using `drush en` as you build
out your server.

## Verify it worked

After enabling, the localization server's admin screens become available in the
admin menu. From there you can begin defining projects, importing source strings,
and enabling the languages your community will translate into — see "How to use it"
in the [overview](../index.md).
