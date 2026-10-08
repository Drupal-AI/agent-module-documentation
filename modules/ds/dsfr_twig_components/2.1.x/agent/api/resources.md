<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Resources: DSFR catalog and icon/pictogram JSON

`src/Twig/Resources.php` (service `dsfr_twig_components.resources`, but used via static calls) is
a static data catalog for the DSFR suite. It exposes **no Twig functions**; it is consumed by this
module's demo page and by sibling modules (e.g. DSFR Core).

## Static catalog methods

- `version()` — the supported DSFR version string (`'1.12.1'`).
- `colorLine()` — a single comma-separated string of the DSFR color names
  (`blue-ecume, blue-cumulus, green-archipel, ...`).
- `functionsReady()` — array of the operational components, each built by
  `buildItem(name, url, parent, type='dsfr', official=true)` → `{name, url, parent, type, official}`.
  `url` is the relative path under the official DSFR docs site; `parent` groups it
  (`edition`, `alert`, `form`, `collection`, `other`). Drives the demo page menus and the filter form.
- `iconsType()` — the full icon table, keyed by category (`building`, `business`, `system`, ...),
  each an ordered map of icon name → metadata (`[]`, or `{author: dsfr|remixicon}`,
  `{type: finance}`).
- `pictogramsType()` — the pictogram table, keyed by category (`buildings`, `digital`, `document`,
  ...) → pictogram names.

The source comments instruct maintainers to update the icon/pictogram lists here in PHP rather
than in the generated JSON.

## JSON generation (file writes)

- `iconsJson(string $directory)` → `convertJson(iconsType(), $directory)` (label `icons`).
- `pictogramsJson(string $directory)` → `convertJson(pictogramsType(), $directory, 'pictograms')`.
- `convertJson(array $items, string $directory, string $label='icons')`:
  1. Flattens the category → name map to `{category: [name, ...]}`.
  2. `json_encode(..., JSON_PRETTY_PRINT)`.
  3. Resolves the target as **`__DIR__ . $directory`** (relative to `src/Twig/`).
  4. If the directory does not exist, `mkdir()` it; if not writable, returns
     `["<dir> is not writable.", "error"]`; otherwise
     `file_put_contents($directory . $label . '.json', $json)` and returns
     `["File generated!", "success"]`.

Key points for callers/agents:

- The **content** written is the module's own hard-coded icon/pictogram tables — never
  request-derived.
- The **path** is whatever the caller passes. Neither this module's route/controller/form invokes
  `iconsJson`/`pictogramsJson`/`convertJson` — they are called only by sibling modules
  (DSFR Core calls them with a fixed relative path like `'/../../temp/'`), not from any HTTP
  request input in this module.
