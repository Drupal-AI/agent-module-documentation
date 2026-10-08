<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Append File Info (append_file_info) — agent index

Adds the **extension + human-readable size** (and a MIME-icon CSS class) to links pointing at
**local managed files**. Two independent mechanisms share one formatter service:

1. A **text-format filter** `append_file_info_filter` — scans rendered HTML `<a>` links, resolves
   each to a `file` entity, appends the info + wraps it in a mime-icon `<span>`.
2. A **`file_link` theme override** — swaps core's `template_preprocess_file_link` preprocessor so
   themed file-field links get the same treatment without a filter.

Core requirement `^10.3 || ^11`. License GPL-2.0-or-later. Installed version 2.0.1. No declared
module dependencies in `.info.yml`, but it uses core **`file`** (`FileInterface`, `IconMimeTypes`)
and, for the filter, core **`filter`**. No permissions of its own, no Drush, no entities.

## Solution docs

- **The filter: how links are matched, resolved, and decorated** →
  [filters/append-file-info-filter.md](filters/append-file-info-filter.md)
- **The `file_link` theme override** → [theming/file-link.md](theming/file-link.md)
- **Settings form, config object, schema, the `display` setting** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- Service `append_file_info.file_info_formatter` → `FileInfoFormatter` (`src/FileInfoFormatter.php`,
  `final class`), ctor arg `@file_system`. Method `getExtraLinkText(FileInterface $file, string
  $display = 'both'): string` returns e.g. `" (PDF, 2.4 MB)"`. Extension via
  `Html::escape(strtoupper(...))`; size via `ByteSizeMarkup::create($file->getSize())`; handles
  `TAR.GZ` / `TAR.BZ2`.
- Filter plugin `AppendFileInfoFilter` (`src/Plugin/Filter/`, id `append_file_info_filter`,
  `TYPE_TRANSFORM_REVERSIBLE`, one setting `display=both`). `process()` uses `Html::load()` /
  `Html::serialize()`, `getFileFromPath()` resolves public/private stream paths or `file/{fid}`,
  and rejects non-`LocalStream` files. Skips links whose class matches `no-file-info` and links
  containing an `<img>`. Adds per-file cacheability.
- Theme hooks in `src/Hook/ThemeHooks.php` (OOP `#[Hook('theme_registry_alter')]`), legacy
  wrappers in `append_file_info.module`. `preprocessFileLink()` rebuilds the `file_link` link with
  the appended text, mime classes, and a `config:append_file_info.settings` cache tag.
- Help hook in `src/Hook/HelpHooks.php`. Settings form `AppendFileInfoSettingsForm`
  (`ConfigFormBase`) at route `append_file_info.settings`
  (`/admin/config/content/append-file-info`, permission `administer site configuration`), menu
  link under `system.admin_config_content`.
- Config: object `append_file_info.settings` (`display`) + per-filter
  `filter_settings.append_file_info_filter` (`display`); schema in
  `config/schema/append_file_info.schema.yml`.
- `hook_install()` resets the theme registry; `hook_update_8101()` strips a stale filter
  `settings.title`.
