# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **IMCE** module (`imce`) — this module extends it, so IMCE must be installed
  with at least one profile.
- Core's **File** (`file`) and **User** (`user`) modules — part of a standard
  install and enabled automatically as dependencies.
- The **private file system** configured, since download tracking works only for
  files stored in `private://` (see the [overview](../index.md)).

There are no third‑party Composer or PHP library requirements.

> **Note:** This project is **not covered by Drupal's security advisory policy**.
> Weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/imce_download_tracker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including IMCE if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imce_download_tracker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce_download_tracker -y
```

This also enables IMCE if it is not already on, and creates the database table
that holds the download statistics.

## Configure IMCE permissions

Go to **Configuration → Media → IMCE** (`/admin/config/media/imce`), edit the
profiles whose users should see the statistics, and add the **Access download
statistics** permission. Save.

## Verify it worked

Make sure a tracked file lives in the private file system, then open IMCE and
download it. A **Downloads: X** badge should appear next to the file name, and the
**Download Statistics** button should open the details modal. You can also run
`drush imce-download-tracker:stats --top=10` to confirm counts are being recorded.
