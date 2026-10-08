<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unstructured (unstructured) — agent index

Drupal client for **Unstructured.io** — parses PDFs, Office documents, emails and images into
structured elements, then into field values. Package *AI Tools*. Core `^10.2 || ^11`.
Depends on **`key`** (`drupal/key ^1.18`). License GPL-2.0-or-later. Version `2.0.0-rc2`.
Configure at `/admin/config/unstructured/settings` (`administer site configuration`).

## What it provides (from source)

- **One service** `unstructured.api` → `Drupal\unstructured\UnstructuredApi`. `structure($file, $options)`
  POSTs a Drupal `File` entity as multipart to `general/v0/general` and returns the decoded element
  array. See [api/service.md](api/service.md).
- **Three formatter services** (`FormatterInterface::format(array $results, $split)`):
  `unstructured.text_formatter`, `unstructured.markdown_formatter`, `unstructured.html_formatter`.
  Turn the element array into plain text / markdown / HTML; extract inline images and render tables.
  See [api/formatters.md](api/formatters.md).
- **Four AI Automator plugins** (`#[AiAutomatorType]`, extend `ai_automators` `ExternalBase`) —
  `FileToText` (text_long), `FileToString` (string_long), `FileToTable` (tablefield),
  `FileToImage` (image). See [plugins/automators.md](plugins/automators.md).
- **One settings form** `UnstructuredConfigForm` (config `unstructured.settings`: `api_key`, `host`).
  See [config/settings.md](config/settings.md).

## Not provided

No permissions of its own, no Drush commands, no entities, no config schema/install defaults, no
hooks. The only route is the admin settings form. `ai:ai_automators` is a **test/soft** dependency —
the four Automator plugins only load when `ai_automators` is present; the `unstructured.api` service
and the formatters work without it.
