# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Qtools Common** module (`qtools_common`) — a hard dependency, pulled in
  automatically by Composer.
- Optional, for deeper PHP profiling: the **Tideways xhprof** PHP extension
  (recommended) or the **Blackfire.io** PHP extension. These are server-level PHP
  extensions you install yourself; the module integrates with them once they are
  present.

> **Note:** this project is not covered by Drupal's security advisory policy. It is
> a developer tool — install it in development/staging rather than exposing profiling
> output to ordinary visitors on production.

## Install with Composer

From the project root:

```bash
composer require drupal/qtools_profiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and brings in **Qtools Common** automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/qtools_profiler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en qtools_profiler -y
```

This also enables **Qtools Common** if it is not already on.

## Optional: enable a PHP profiler

For PHP-level profiling, install the relevant PHP extension on the server:

- **Tideways xhprof** (recommended) — install the `tideways_xhprof` PHP extension.
- **Blackfire.io** — install the Blackfire PHP extension (only worth it if you
  already use Blackfire).

Once the extension is loaded by PHP, the module can use it. Configuration details
for the profiler live in the project's **`README.md`** (the module has no standard
Drupal settings form).

## Optional: the Chrome extension

To send profiling output to your browser's developer toolbar instead of into the
page — useful for profiling on a live site without disturbing visitors — install the
Chrome extension that ships with the module.

## Verify it worked

1. Confirm the module is enabled: `drush pm:list --status=enabled | grep qtools_profiler`.
2. Browse a page on your site as a developer and confirm the profiler output (time,
   memory, database queries) appears for the request and any AJAX calls.
