# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **File Hash** module (`filehash`) — this is a hard dependency, and it is the
  module that actually computes the file signatures Filehash Report reads. Install
  it too (see below).

There are no third‑party PHP library requirements.

## Install with Composer

From the project root, require both the dependency and this module:

```bash
composer require drupal/filehash drupal/filehash_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filehash_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en filehash filehash_report -y
```

## Grant the report permission

Filehash Report provides its own permission controlling who can view the
duplicates report. Because a file listing can reveal what has been uploaded to the
site, grant it only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`), then save.

## Generate hashes, then view the report

The report needs File Hash to have computed hashes first:

1. Visit **`/admin/config/media/filehash`**, select a hash algorithm such as
   **SHA‑256**, and click **Save**.
2. Visit **`/admin/config/media/filehash/generate`** and click **Generate** to
   hash the files already on the site.
3. Visit **`/admin/config/media/filehash/duplicates`** — the Filehash Report page.

## Verify it worked

If **`/admin/config/media/filehash/duplicates`** loads and lists any files that
share a hash (or reports that none were found), the module is working. If the page
is empty and you expected duplicates, re‑check that a hash algorithm is selected
and that the **Generate** batch has completed.
