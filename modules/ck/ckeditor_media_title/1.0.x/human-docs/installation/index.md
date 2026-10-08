# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **CKEditor 5** (`ckeditor5`) and core **Media** (`media`).
- A text format that uses **CKEditor 5** as its editor and has the **Media Embed**
  filter enabled — the feature only works there.
- No external libraries or APIs are required.

> **Heads‑up:** This project is *minimally maintained* and is **not covered by the
> Drupal security advisory policy**. Weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_media_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor_media_title -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_media_title -y
```

## Turn on the feature per text format

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a format that uses CKEditor 5 and the Media Embed filter (often *Full
   HTML* or a custom authoring format).
3. In the CKEditor 5 plugin settings, find **Media Image Title Override** and tick
   **Enable media image title override**.
4. Click **Save configuration**.

## Verify it worked

Edit a content field using that format, embed or select a media image, and confirm
a **"T"** button appears in the media's inline toolbar. Click it, set a title,
save the content, and check the rendered image carries your `title` attribute.
