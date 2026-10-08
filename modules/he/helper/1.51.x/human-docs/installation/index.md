# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **File** module (`file`) — the only Drupal module dependency, enabled
  automatically as a dependency.
- Two Composer libraries, pulled in automatically when you require the module:
  - **`davereid/drupal-environment`** (`^1.0`)
  - **`webflo/drupal-finder`** (`^1.3`)

## Install with Composer

From the project root:

```bash
composer require drupal/helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and here it also pulls in the two required libraries
above. Installing via Composer is the supported way to satisfy those
dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en helper -y
```

Enabling the module makes its services, form element, blocks, Twig helpers and
Drush commands available. There is **no configuration form and no permissions**;
the optional behavior "helpers" are off until you add their keys to the
`helper.settings` config object (see the
[`agent/`](../agent/start.md) docs).

## Verify it worked

Confirm the bundled Drush commands are registered:

```bash
drush list | grep -E 'schema-version|install-profile:switch'
```

You should see commands such as `module:schema-version:get` and
`install-profile:switch`.
