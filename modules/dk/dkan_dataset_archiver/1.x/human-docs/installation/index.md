# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **DKAN** site. This module depends on **dkan**, **dkan_common**,
  **dkan_metastore** and **dkan_metastore_search**, plus core **Datetime**,
  **Options** and **Views**.
- **Match the release to your DKAN version.** This **1.x** series targets **DKAN
  4** (where the submodule‑discovery issue is resolved). For older DKAN, use a
  different series: DKAN 2.x → dkan_dataset_archiver 1.0.x; DKAN 3 → 0.333.x.
- For the optional remote‑storage submodule: the **League Flysystem** and
  **flysystem‑aws‑s3‑v3** libraries, pulled in via Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_dataset_archiver -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_dataset_archiver -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dkan_dataset_archiver -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Archive Remote Storage** | `dkan_dataset_archiver_remote_storage` | Maintains or copies archives to remote storage. AWS is the supported target at present. |

Enable it if you want archives offloaded to remote storage:

```bash
drush en dkan_dataset_archiver_remote_storage -y
```

Keep the remote‑storage credentials out of committed configuration — store them in
environment variables or a secrets manager.

## Verify it worked

Publish a DKAN dataset that has resource files, then run cron
(`drush cron`). A copy of the dataset's resources should appear under
`files/dataset-archives/`, and the archive‑listing API endpoints under
`/api/1/archive/...` should return the new archive (subject to your permissions).
