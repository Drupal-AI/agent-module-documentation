# Installation

Installing this module takes an extra step compared with most CKEditor plugins:
after enabling it you must run a Drush command that downloads the CKEditor
*markdown-gfm* JavaScript plugin into your site's `/libraries` directory.

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal core's **CKEditor 5** module (`ckeditor5`) — a direct dependency,
  enabled with the module.
- **Drush**, to run the asset-download command.
- Write access to the site's `/libraries` directory (the command mirrors the
  plugin into `/libraries/ckeditor5/plugins/markdown-gfm`).

There are no PHP library requirements. The CKEditor plugin itself is fetched by
the Drush command below rather than via Composer/npm on the host.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_markdown_editor -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_markdown_editor -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_markdown_editor -y
```

## Download the editor plugin assets

Now fetch the third-party CKEditor plugin. This command downloads the plugin
tarball from the npm registry over verified TLS and extracts it into
`/libraries`, then clears caches:

```bash
drush ckeditor5_markdown_editor:install
```

After a later CKEditor core upgrade, refresh the assets so their version matches:

```bash
drush ckeditor5_markdown_editor:update
```

Both commands are CLI-only and meant to be run by an administrator; the download
URL is derived from Drupal's own libraries/config, not from any request input.

## Verify it worked

Open **Reports → Status report** (`/admin/reports/status`). If the plugin files
are present and their version matches CKEditor core, there will be no
markdown-plugin warning. Then go to **Configuration → Content authoring → Text
formats and editors**, edit a CKEditor 5 format, and confirm a **Markdown output**
checkbox appears in the editor settings. Tick it, save, and check that content in
that format is stored as Markdown.

> **Rendering note:** This module only changes the editor's *output*. To turn the
> stored Markdown back into HTML on display, add a filter like `markdown_easy` or a
> formatter like `markdown_field_formatter`.
