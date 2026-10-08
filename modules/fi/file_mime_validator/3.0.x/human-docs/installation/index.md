# Installation

## Requirements

File Mime Validator needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_mime_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_mime_validator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_mime_validator -y
```

## Verify it worked

The validation begins working as soon as the module is enabled — it inspects the
real MIME type of files uploaded to file fields and rejects mismatches, logging
the attempt. As a quick check, try uploading a file whose content does not match
its extension (for example an HTML file renamed to `.jpg`) and confirm it is
rejected.

Note that the settings form has a reachability caveat (it is gated behind a
non-existent `administer` permission, so only user 1 can open it) — see
[Configuration](../configuration/index.md) for how to configure the MIME mappings
in the meantime.
