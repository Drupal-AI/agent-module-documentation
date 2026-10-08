<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Timeline Block (`timeline_block`)

`src/Plugin/Block/TimelineBlock.php` — `class TimelineBlock extends BlockBase implements
ContainerFactoryPluginInterface`. Annotation: `@Block(id="timeline_block",
admin_label=@Translation("Timeline Block"))`. Injects `entity_type.manager` → `file` storage and
the `renderer` service.

## Configuration model
Stored as block plugin configuration (no config schema file ships):

| Config key | Source field | Type | Notes |
|---|---|---|---|
| `timeline_data` | `items_fieldset.items[]` | JSON string | Array of `{title, time, description, description_format, weight}` |
| `timeline_header` | `timeline_header[value]` | string (rich text) | Rendered above items |
| `timeline_header_format` | `timeline_header[format]` | string | Text-format machine name (default `basic_html`) |
| `timeline_layout` | `timeline_configuration.timeline_layout` | string `1`–`10` | Selects the Twig branch |

Per-item fields in `blockForm()`:
- `title` — `#type => textfield` (plain text).
- `time` — `#type => textfield` (plain text) — a date/phase label, free text (no date widget).
- `description` — `#type => text_format`, `#format` default `basic_html`.
- `weight` — `#type => number`, `#min => 1`, `#max => 120`, default = row index.
- `remove_single_item` — AJAX submit that marks the row inactive (`row_N => 'inactive'`).

Items are added by the `add_item` AJAX button (`addOne()` increments `num_items` and rebuilds); the
AJAX callback `addmoreCallback()` returns `$form['settings']['items_fieldset']`.

## Submit handling (`blockSubmit()`)
- Reads `items_fieldset.items`, `usort`s by numeric `weight`, and **discards any item whose
  description value is empty** (`trim(... ) === ''`).
- Flattens each item's `description` from the `text_format` structure into `description` (value) +
  `description_format` (format), then `json_encode`s the array into `timeline_data`.
- Stores `timeline_layout`, `timeline_header`, `timeline_header_format`.
- Runs embedded-image file lifecycle: newly-referenced images in descriptions/header are made
  permanent with usage tracked; images that were present before but no longer referenced are marked
  temporary (`array_diff` of old vs new fids).

## Rendering (`build()`)
- Header: `#type => processed_text` with `timeline_header_format`, `renderPlain()`-ed → passed as
  `#timeline_header`.
- Each item's description: `#type => processed_text` with its `description_format`,
  `renderPlain()`-ed. `title`, `time`, `weight` are passed through **as stored raw strings**.
- Render array `#theme => 'timeline_block'` with `#timeline_data`, `#timeline_settings`
  (`timeline_layout`), `#timeline_header`; attaches library `timeline_block/timeline_block`.

## Template & layouts
`templates/timeline-block.html.twig` branches on `timeline_settings.timeline_layout` (`'1'`…`'10'`)
and emits a different markup structure for each (alternating rails, cards, numbered steps, coloured
cards, an ordered `<ul>`, etc.). `timeline.description` is printed as-is (it is already rendered
markup); `timeline.time` and `timeline.title` are printed. Styling is `css/timeline.css`; no JS.

## Placement & access
- Place via **Structure → Block layout → Place block**, or as an inline/reusable block in Layout
  Builder. Gated by core **"administer blocks"** (or the relevant Layout Builder permissions). The
  module defines **no permissions of its own**.

## Theming / extension
Copy `templates/timeline-block.html.twig` into a theme to change any layout's markup or to attach a
custom JS library (e.g. a carousel). Available Twig variables: `timeline_data` (each with `time`,
`title`, `description`, `weight`), `timeline_settings.timeline_layout`, `timeline_header`.
