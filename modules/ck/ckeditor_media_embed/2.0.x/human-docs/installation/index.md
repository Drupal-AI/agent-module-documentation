# Installation

## Requirements

- **Drupal 10.3, or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only module
  dependency.
- **Outbound network access and write access to `libraries/`** on the server, because
  the required CKEditor plugin JavaScript is downloaded (not bundled). See "Download
  the plugin JavaScript" below.

There are no additional Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_media_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_media_embed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_media_embed -y
```

## Download the plugin JavaScript

The CKEditor 5 media‑embed JavaScript is **not shipped** with the module — until you
download it, the toolbar button will not function, and the Status Report and a dblog
message will warn you it is missing. Fetch it with the module's Drush command:

```bash
drush ckeditor_media_embed:install
```

This downloads the plugin build for your site's CKEditor version into
`libraries/ckeditor5/plugins/` and records the installed version in config. Run it once,
right after enabling the module.

After a core update that bumps CKEditor 5 to a new version, the Status Report may show a
*"Mixed versions"* warning; refresh the plugin to match with:

```bash
drush ckeditor_media_embed:update
```

Both commands reach out to the npm registry / GitHub, so they need outbound network
access. In an air‑gapped environment, place the built `media-embed` plugin directory in
`libraries/ckeditor5/plugins/` manually instead.

You can confirm the state at any time on the Status Report
(`/admin/reports/status` → *CKEditor Media Embed plugin*).

## Next steps

Installing the module and its JavaScript is only the groundwork. To actually let
authors embed media you still need to add the toolbar button and enable the render
filter on a text format, and (optionally) choose an oEmbed provider — all covered in
[Configuration](../configuration/index.md).
