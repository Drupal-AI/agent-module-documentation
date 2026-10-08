# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **File** module (`file`) — a hard dependency, since the module manages
  file status and file‑usage records. Drupal enables it automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/form_file_usage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_file_usage -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_file_usage -y
```

Enabling the module makes its tracking available, but nothing changes until you
apply it to a form — either by adding `#track_file_usage` / `#file_usage_config`
to an element, or by calling the `form_file_usage.manager` service (see "How to
use it" in the [main guide](../index.md)).

## Verify it worked

Add `'#track_file_usage' => TRUE` to a `managed_file` or `text_format` element in a
custom config form, upload a file, and save. Then confirm the file is marked
**permanent** and has a record in the `file_usage` table (for example, check the
file's status in the Files admin listing, or query `file_usage`). Removing the file
and saving again should release its usage, and cron should later reclaim it if
nothing else references it.
