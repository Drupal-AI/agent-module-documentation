<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The File Downloader field formatter & its markup

`Drupal\file_downloader\Plugin\Field\FieldFormatter\FileDownloaderFieldFormatter`
(id `file_downloader_formatter`, label "File Downloader") — a `FileFormatterBase` subclass for
`file` and `image` fields.

## Settings

- One setting: `download_options` (default `[]`) — an array of `download_option_config` entity ids.
- `settingsForm()` (`FileDownloaderFieldFormatter.php:37`) renders a **required** `checkboxes`
  element listing every existing Download Option Config; label shown as
  `"{label} ({extensions})"` when the option has an extension list.
- `settingsSummary()` shows the selected option labels.

Stored under config schema `field.formatter.settings.file_downloader_formatter`
(a `sequence` of option-id strings).

## Rendering

`viewElements()` loads the selected `download_option_config` entities and, per file item
(`getEntitiesToView()`), builds a list of download links (`getDownloadLinks`,
`FileDownloaderFieldFormatter.php:171`). For each option:

- Builds a `Url` to `download_option_config.download_path` with the option id + file id; **skips the
  option** if `$url->access()` is false (so users only see links they may use — this runs the same
  access chain as the route, see [../api/download-route.md](../api/download-route.md)).
- If the deliverable file exists (`$plugin->downloadFileExists($file)`) → a `#type => link` rendered
  with theme `file_download_link`.
- If it does not exist → a non-link `<span>` label rendered with theme `file_download_disabled`
  (for `image_style`, `downloadFileExists()` will attempt to build the derivative here, so a missing
  derivative is generated at display time, not at download time).

The per-item list is wrapped by theme `file_download_list` (an `item_list` with wrapper class
`download-options-list`). Cache tags/contexts from the file and the option config are attached.

## Theme hooks & templates (`file_downloader.module`, `hook_theme`)

| Theme hook | Template | Variables |
| --- | --- | --- |
| `file_download_link` | `templates/file-download-link.html.twig` | `content`, `file`, `downloadOptionConfig` |
| `file_download_disabled` | `templates/file-download-disabled.html.twig` | `content`, `file`, `downloadOptionConfig` |
| `file_download_list` | `templates/file-download-list.html.twig` | `content` |

All three shipped templates are minimal (they output `{{ content }}`), so override them in your theme
to control the download-link / disabled-label / list markup and wrapping. A `#disabled` flag is also
passed to each link element.
