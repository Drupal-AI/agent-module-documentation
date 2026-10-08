# Installation

## Requirements

JSON LD Schema API needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **`spatie/schema-org`** PHP library (`^3.0`) — the fluent Schema.org `Type`
  builder your plugins return. Composer installs it automatically when you require
  the module.

There are no other Drupal module dependencies.

## Install with Composer

Install via Composer so the `spatie/schema-org` library is pulled in for you:

```bash
composer require drupal/json_ld_schema -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the required
`spatie/schema-org` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/json_ld_schema -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_ld_schema -y
```

There's nothing to configure. Enabling the module gives you the two plugin types
(`JsonLdSource` for site‑wide data, `JsonLdEntity` for per‑entity data) — but no
structured data is emitted until you write your own plugins in a custom module. See
the [main guide](../index.md#how-to-use-it) for the plugin workflow, and the
sibling [`agent/`](../agent/start.md) docs for the plugin interfaces and copy‑paste
examples.
