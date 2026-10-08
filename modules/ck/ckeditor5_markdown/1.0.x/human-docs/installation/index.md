# Installation

## Requirements

- **Drupal 10.3 or higher, or Drupal 11 / 12**
  (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Drupal core's **CKEditor 5** module (`ckeditor5`) — a direct dependency,
  enabled with the module.
- The **marked** JavaScript library — this is *bundled into the module's compiled
  asset* (`js/build/markdownPaste.js`), so there is nothing extra to download or
  install.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_markdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_markdown -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_markdown -y
```

## Verify it worked

Edit a CKEditor 5 text format at **Configuration → Content authoring → Text
formats and editors**, drag the **Paste Markdown** button onto the toolbar, and
save. Then edit content, click the button, paste some Markdown (for example a
heading and a bullet list), and click **Insert** — it should appear as formatted
HTML, subject to the elements your text format allows.
