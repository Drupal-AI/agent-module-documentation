<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Downloader (file_downloader) — agent index

Exposes **configurable download options for file/image fields** through a **field formatter** and a
**plugin system**. You create one or more `download_option_config` config entities (each picks a
*download-option plugin* and an optional file-extension allowlist), then select them in the settings
of the **File Downloader** field formatter (`file_downloader_formatter`). When the field renders, it
emits one download link per enabled option (as an unordered list) — each link points at the route
`download/{download_option_config}/{file}`. The controller loads the option's plugin and streams the
file via a `BinaryFileResponse`.

Two download-option plugins ship in-box: **`original_file`** (serves the stored file unchanged) and
**`image_style`** (serves an image-style derivative of the file, generating it on first display via
the formatter). New options are added by writing a `DownloadOption` plugin. Every download is gated
at the route by a per-option permission (`use {id} download option link`), the option's extension
allowlist, and the file entity's own `view` access — so grant the per-option permission to the roles
that should be able to download. Based on the older `file_download` module but supporting multiple
options per field.

- Depends on: `drupal:file` (core File module).
- Core: `^9 || ^10 || ^11`. Package: `Custom`.
- Configure route: **`entity.download_option_config.collection`** (admin UI at
  `/admin/config/media/download_options`, under *Configuration → Media*).
- Provides permissions (one static + a dynamic per-option permission). No drush commands.
- Provides config schema. Defines one plugin type: **`DownloadOption`**
  (manager `plugin.manager.download_option`).

## What you'd do → where

- **Create a download option / set its plugin + allowed extensions, and attach options to a field
  formatter** → [configure/download-options.md](configure/download-options.md)
- **Understand or call the download route, its access chain, and how files are streamed** →
  [api/download-route.md](api/download-route.md)
- **Write a custom download-option plugin (or understand `original_file` / `image_style`)** →
  [plugins/download-option.md](plugins/download-option.md)
- **Use / theme the File Downloader field formatter and its link markup** →
  [fields/formatter.md](fields/formatter.md)
- **Who can download / which permissions to grant** → [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Route: `download_option_config.download_path` (`/download/{download_option_config}/{file}`) —
  controller `Drupal\file_downloader\Controller\DownloadOptionPluginController` (`downloadFile`,
  access callback `access`). Entity-admin routes: `entity.download_option_config.collection` /
  `.add_form` / `.edit_form` / `.delete_form` / `.canonical` (base path
  `/admin/config/media/download_options`).
- Config entity type: `download_option_config` (`Drupal\file_downloader\Entity\DownloadOptionConfig`),
  `admin_permission = administer site configuration`, config prefix `download_option_config`,
  config_export keys: `id`, `label`, `uuid`, `plugin_id`, `extensions`, `settings`.
- Field formatter: `file_downloader_formatter` (label "File Downloader"), field types `file` + `image`,
  setting key `download_options` (array of `download_option_config` ids).
- Plugin type: `DownloadOption` — manager service `plugin.manager.download_option`
  (`DownloadOptionPluginManager`, dir `Plugin/DownloadOption`, interface
  `DownloadOptionPluginInterface`, base `DownloadOptionPluginBase`, annotation
  `Drupal\file_downloader\Annotation\DownloadOption`, alter hook `download_option`).
- Bundled plugin ids: `original_file`, `image_style` (the latter has a config key `image_style`).
- Permissions: static `administer download_option configuration`; dynamic (one per option config)
  `use {id} download option link` (callback `DownloadOptionConfigPermissions`).
- Theme hooks: `file_download_link`, `file_download_disabled`, `file_download_list`
  (templates `file-download-link.html.twig`, `file-download-disabled.html.twig`,
  `file-download-list.html.twig`).
- Config schema types: `file_downloader.download_option_config.*`, `file_downloader.download_option.*`,
  `file_downloader.download_option.image_style`, `field.formatter.settings.file_downloader_formatter`.
