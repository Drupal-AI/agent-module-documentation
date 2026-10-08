# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **CKEditor 5** editor (`ckeditor5`) — the module is a CKEditor 5 plugin.
- A text format that uses CKEditor 5 with embedded media (the media embed filter),
  since the resizer acts on embedded media images.
- No third‑party Composer or PHP library requirements.

> **Heads‑up:** This project is *minimally maintained* and is **not covered by the
> Drupal security advisory policy**. Weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_media_resizer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_media_resizer -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_media_resizer -y
```

## Verify it worked

The module does nothing until you add its button and enable its filter on a text
format — see [Configuration](../configuration/index.md). After that, edit content
that uses the format, embed a media image, select it, and confirm the resize
handles appear and the front‑end page reflects the size you set.
