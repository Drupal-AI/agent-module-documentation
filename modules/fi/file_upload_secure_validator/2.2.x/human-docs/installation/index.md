# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **`fileinfo` PHP extension** (`ext-fileinfo`). FUSV uses it to sniff a
  file's real content. If it is missing, the module fails safe — the validator
  service simply isn't registered (so nothing breaks), and the **Status Report**
  flags the extension as required. Most Drupal hosting has `fileinfo` enabled by
  default.

There are no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/file_upload_secure_validator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_upload_secure_validator -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_upload_secure_validator -y
```

Or enable **File Upload Secure Validator** from **Extend** (`/admin/modules`).

## Confirm the fileinfo extension

After enabling, check **Reports → Status report**
(`/admin/reports/status`) to confirm the `fileinfo` extension is available. If it
is missing, uploads are *not* content‑checked until you enable the extension on
your PHP install and rebuild the container.

## Next steps

Validation is now active on every upload with no further setup. Review the
default MIME type equivalence groups and add your own if a legitimate file type
gets blocked — see [Configuration](../configuration/index.md).
