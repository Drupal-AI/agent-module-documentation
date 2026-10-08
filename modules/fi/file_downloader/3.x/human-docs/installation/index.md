# Installation

## Requirements

File Downloader needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency.

There are no third‑party Composer or PHP library requirements. If you plan to
use the **Image Style** download plugin, core's Image module should be enabled as
well.

## Install with Composer

From the project root:

```bash
composer require drupal/file_downloader -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_downloader -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_downloader -y
```

## Verify it worked

Edit a file or image field's display under **Structure → Content types →
*(type)* → Manage display**. The **File downloader** formatter should now appear
in the format dropdown. Next, set up your download options in
[Configuration](../configuration/index.md).
