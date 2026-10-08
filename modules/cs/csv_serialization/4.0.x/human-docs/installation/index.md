# Installation

## Requirements

Serialization (CSV) is a small format provider that leans on one external library:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`) — enabled automatically as a
  dependency.
- The **`league/csv`** PHP library (`^9.16`), which does the actual CSV building
  and parsing. Composer installs it for you when you require the module below —
  this is why you should install via Composer rather than downloading the module
  by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/csv_serialization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — and, importantly, pulls in the required `league/csv`
library at the same time.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/csv_serialization -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en csv_serialization -y
```

Enabling the module also enables core's Serialization dependency if it isn't
already on. There is no configuration and no settings form — once enabled, `csv`
is registered as a serialization format (mapped to the `text/csv` MIME type) and
becomes available to the REST and Views layers. See the main guide's
[How to use it](../index.md#how-to-use-it) section for how to actually produce a
CSV export.

## Submodules

Serialization (CSV) ships **no submodules** — there is nothing extra to enable.
