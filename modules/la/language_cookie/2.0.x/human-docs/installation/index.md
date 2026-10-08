# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Language** module (`language`) — the site must be multilingual for the
  cookie to do anything. On a single-language site the module resolves to the
  default language and sets nothing.
- Core's **Path Alias** module (`path_alias`), used by the path-based conditions.

Both dependencies are part of Drupal core and are enabled automatically as
dependencies. There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/language_cookie -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/language_cookie -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en language_cookie -y
```

Enabling the module makes the **Cookie** detection method available, but it does
nothing until you enable and order it — see
[Configuration](../configuration/index.md).

## Uninstalling

When you uninstall the module it cleanly removes the Cookie method from each
language type's enabled negotiation, so your detection settings are left tidy.
