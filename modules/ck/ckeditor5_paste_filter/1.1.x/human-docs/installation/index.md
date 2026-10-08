# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) — the only dependency, and Drupal
  enables it automatically. (CKEditor 5 is the default rich‑text editor on modern
  Drupal.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_paste_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_paste_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_paste_filter -y
```

This module ships **no submodules**. Note that enabling it does **not** start
filtering anything on its own — the paste filter is a no‑op until you turn it on
for a specific text format (see the
[overview](../index.md#how-to-use-it)).

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit a format that uses CKEditor 5. Under
**CKEditor 5 plugin settings**, you should now see a **Paste filter** vertical
tab. Enable **Filter pasted content**, save, then paste some Word or Google Docs
content into that editor and confirm the extra styling and wrapper tags are
stripped out.
