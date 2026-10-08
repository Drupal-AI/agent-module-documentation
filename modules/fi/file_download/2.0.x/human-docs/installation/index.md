# Installation

## Requirements

File Download needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **File** and **Image** modules to have file/image fields to attach the
  formatters to (File is part of standard installs). There are no contrib
  dependencies and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/file_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_download -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_download -y
```

## The download-counter submodule (optional)

File Download ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **File Download Counter** | `file_download_counter` | Logs how many times each file is downloaded, adds a Views field for the count, and provides a "Popular content" block. Enable it only if you want download statistics. |

Enable it with:

```bash
drush en file_download_counter -y
```

It requires the base File Download module, which is already present once you have
installed it above.

## Grant the download permission

The download route is protected by the **access file download** permission. After
enabling the module, go to **People → Permissions**
(`/admin/people/permissions`) and grant *access file download* to the roles that
should be allowed to download files (for example *Authenticated user*, or
*Anonymous user* for public downloads). Without this permission the download links
will not work for that role.

## Next steps

Nothing downloads automatically — you still have to choose the File Download
formatter on the fields you want. Head to
[Configuration](../configuration/index.md) to set the formatter on a field's
*Manage display*.
