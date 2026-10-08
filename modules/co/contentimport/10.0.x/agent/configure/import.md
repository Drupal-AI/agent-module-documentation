<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Running an import

## Where

Form at **`/admin/config/content/contentimport`** (route `contentimport.admin_settings`,
form `Drupal\contentimport\Form\ContentImport`, form id `contentimport`). Access requires the
core **`administer site configuration`** permission (the module ships no permission of its own).
Menu link: *Configuration › Content authoring › Content Import*.

## Form fields

1. **Select Content Type** (`contentimport_contenttype`) — the destination bundle (all node
   types are listed; `ContentImportController::getAllContentTypes()`).
2. **Select Import Type** (`contentimport_importtype`) — `1` = *Create New content*,
   `2` = *Update existing content*. Changing it (AJAX) offers a **sample CSV** download
   (header row of field machine names) for the chosen type.
3. **Import CSV File** (`file_upload`) — a `.csv` upload (validated to the `csv` extension).

Submitting queues a batch (`contentimport_import_node($file, $content_type, $import_type)`),
finishing at `/admin/content`.

## CSV rules

- **First row = destination field machine names.** Data rows follow.
- **Mandatory columns:** `title` and `langcode` (missing `langcode` ⇒ `en`). **Update** mode
  (`2`) additionally requires **`nodeid`** to locate the node to update (title + langcode +
  nodeid are all mandatory there).
- Optional `author` column = username; sets the node's author (falls back to current user).
- Field value formats depend on each field's type — see [../api/csv-format.md](../api/csv-format.md).

## Output & requirements

- A run writes a readable log to **`sites/default/files/contentimportlog.txt`** ("Check Log.."
  link on the form). The sample CSV is written to `sites/default/files/<content_type>.csv`.
- Give **write access to `sites/default/files/`** or the import/log/sample writes fail.
- Image imports read files from `public://<content_type>/images/` (upload them first, e.g. via
  IMCE).

## Configuration

There is effectively **no persistent configuration** to set — the module declares a
`contentimport.settings` editable config name but stores no meaningful settings and ships no
config schema. The "configuration" is the per-run form input.
