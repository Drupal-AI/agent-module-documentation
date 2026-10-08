# Installation

## Requirements

Search and Replace needs:

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement:
  ^8.7.7||^9||^10||^11`).

There are no other module dependencies, no PHP extension requirements, and no
third‑party libraries.

> **A note on security coverage:** this project is **not** covered by Drupal's
> security advisory policy, and its own documentation asks you to use it with
> extreme caution because it performs bulk, potentially irreversible content
> changes. Restrict it to trusted administrators and always back up first.

## Install with Composer

From the project root:

```bash
composer require drupal/snr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/snr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en snr -y
```

## Optional: enable the safe/preview submodule

Search and Replace ships one submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Search and Replace (safe)** | `snr_safe` | A safer preview mode so you can see what a replacement would do before it is applied. Recommended when you want to inspect the effect first. |

Enable it alongside the base module:

```bash
drush en snr_safe -y
```

## Before you run anything

Because replacements act directly on the database and can be irreversible, take a
full database backup (or use `snr_safe` to preview) and test your search/replace
on a small scope before applying it site‑wide.
