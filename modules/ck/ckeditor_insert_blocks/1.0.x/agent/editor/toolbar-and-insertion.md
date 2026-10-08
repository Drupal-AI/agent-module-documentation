<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editor: the toolbar button, the per-format block list, and insertion

## Enabling it
The plugin lives on a **text format's CKEditor 5 toolbar**, not on a global settings page (there is
no `configure` route). At `admin/config/content/formats/manage/<format>`, drag the **Insert Block**
item (id `InsertBlocks`) into the active toolbar. A settings vertical-tab appears.

## The per-format block list — the real access control
`InsertBlockSettings::buildConfigurationForm()` renders a **checkboxes** element `blocks`, options
from `listBlocks()`:
- `getDefinitions()` = `blockManager->getFilteredDefinitions('block_ui', availableContexts)` then
  `getSortedDefinitions()`, dropping `_block_ui_hidden` definitions — i.e. the same set the block
  layout UI shows (custom module blocks, views blocks `views_block:*`, content blocks
  `block_content:*`, etc.).
- Each option label is `admin_label - category`.
- **Leaving all boxes unchecked is not "none" — it means "offer every block."** `getDynamicPluginConfig()`
  starts `$blocks = listBlocks()` and only narrows to the checked subset when `array_filter($configuration['blocks'])`
  is non-empty. Curate the list per format unless you intend to expose everything.

`getDynamicPluginConfig()` ships to the CKEditor 5 JS (via drupalSettings, JSON-encoded):
- `blocks`: `{ plugin_id: "Admin label - Category", … }`
- `url_block_content`: the resolved `/get-block-content` path.

## The insert flow (JS: `js/ckeditor5_plugins/insert_blocks/`)
- `index.js` composes `InsertBlockEditing` + `InsertBlocksUI` under plugin name `insertBlocks`.
- `insert_blocks.js` builds the dropdown from `config.get('blocks')`. On pick (`_onExecute`):
  1. inserts a temporary `<div class="loading insert-block" data-block-id="ID">Loading… label</div>`;
  2. `fetch(url_block_content + '/' + blockId)`, reads `response.text()`;
  3. replaces the loader with `<div class="insert-block" data-block-id="ID">FETCHED_HTML</div>`;
  4. opens a **balloon** (`insert_blocks-view.js`) with two text inputs — **Add class** and
     **Add Library** — whose submit runs `InsertBlockCommand` to set `htmlDivAttributes`
     (prepend the class, set `data-library`).
- `insert_blocks-edit.js` registers an `insertBlocks` schema object and up/down-cast for
  `div.insert-blocks`; `htmlSupport` is configured (in `insert_blocks.js`) to allow `div` with
  `class`, `data-block-id`, `data-library`.

## What ends up in the field
The **stored** body contains the fetched block HTML inline **and** the `data-block-id` marker. On
save it passes through the format's other filters (`filter_html` etc.), so the allowed-HTML policy
still applies to the captured markup. Whether that stored snapshot is later re-rendered live depends
on the `insert_block` filter — see `../config/filter-and-rendering.md`.

## Optional client-side refresh
Per the project page, a theme can load an `insert-block-ajax` library that scans
`.insert-block[data-block-id]` and re-fetches content client-side. (This repo ships the editor
library `insert-block` and admin CSS `admin.insert-block`; treat the ajax library as project-page
guidance rather than a shipped asset here.)
