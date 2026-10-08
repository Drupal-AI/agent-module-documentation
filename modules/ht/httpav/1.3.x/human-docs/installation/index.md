# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11.0`).
- No additional contrib module dependencies and no PHP library requirements.
- **A separate HTTP scanning service** that you run or subscribe to — this is a
  prerequisite the module relies on but does not include. It must accept a file
  over HTTP (`multipart/form-data`) and return a JSON verdict with an `infected`
  flag. See [How to use it](../index.md#how-to-use-it).

## Install with Composer

From the project root:

```bash
composer require drupal/httpav -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/httpav -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en httpav -y
```

## Verify it worked

With the module enabled and pointed at a working scanning endpoint over HTTPS,
try uploading a harmless file through any file or image field — it should be
accepted as normal. Then test with the standard EICAR antivirus test file: the
scanner should report it infected and Drupal should refuse to save it, showing a
validation error on the upload. If a clean upload is unexpectedly blocked, check
that your scanning endpoint is reachable and returning the expected JSON verdict.
