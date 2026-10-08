# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module (`views`), which Drupal enables automatically as a
  dependency (it is on for virtually every site already).

There are no third-party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/views_aggregator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_aggregator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_aggregator -y
```

There is no configuration form and no permissions. Once enabled, the **"Table with
aggregation options"** style becomes available in the Format section of any View —
see the [overview](../index.md) for how to use it.

## Submodule — optional extra functions

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Views Aggregator Plus — More functions** | `views_aggregator_more_functions` | Three additional aggregation functions: Group sequence number, Range difference, and Percentage. It also serves as a worked example of adding your own functions via the module's hook. |

Enable it only if you need those extras:

```bash
drush en views_aggregator_more_functions -y
```

It requires the base Views Aggregator Plus module, which is already present once you
have installed it above.
