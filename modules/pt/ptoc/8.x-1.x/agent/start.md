<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Table of Contents (ptoc) — agent index

Config-driven module that builds long pages from **nested Paragraphs** and renders an
**in-page table of contents** from that structure — one jump link per paragraph. Version
**8.x-1.4**, core `^8 || ^9 || ^10 || ^11`. Package `Paragraphs`. Author calls it "basically
a proof of concept." No config schema shipped, no permissions defined by the module, no
Drush, no plugins.

## What it installs
- Node type **`ptoc_page`** ("Page with sections") with `field_ptoc_sections`
  (entity_reference_revisions → paragraph, cardinality -1).
- Paragraph types **`ptoc_text`, `ptoc_container`, `ptoc_image`, `ptoc_links`** (each has
  `field_ptoc_title`; container/bundle references sub-paragraphs).
- View mode **`ptoc`** ("Table of Contents") for both `node` and `paragraph`.
- View **`ptoc`** with a **block display** (`views_block__ptoc_block_1`) that renders the
  current node in the `ptoc` view mode, keyed on the page's `nid` contextual argument
  (validated with `entity:node`, operation `view` → respects node access). Default block
  placed in `sidebar_first` (Bartik).

## The mechanism (there is no heading parsing)
`ptoc.module`:
- `ptoc_preprocess_paragraph()` — for the **default** view mode, sets
  `attributes['id'] = 'paragraph-' . $paragraph->id()` (numeric entity id → stable anchor
  target). For the `ptoc` view mode, sets `ptoc_link_text = key($content)` (first enabled
  field). If `ptoc.settings:debug` is on, adds class `ptoc-debug` + attaches
  `ptoc/ptoc-debug`.
- `ptoc_theme_suggestions_paragraph()` / `_node()` — swap in `ptoc_paragraph` /
  `ptoc_node` templates for the `ptoc` view mode. `ptoc_theme()` registers them
  (base hooks `paragraph` / `node`).
- `templates/ptoc-paragraph.html.twig` — emits
  `<a href="#paragraph-{{ paragraph.id.value }}">{{ link_text }}</a>` where `link_text` is
  the **rendered content render-array** of the first `ptoc`-mode field (or a translated
  `Paragraph @id` fallback), then renders the remaining fields (nested sub-paragraphs).
  `templates/ptoc-node.html.twig` wraps the node's `ptoc` output in `<nav>`.

Anchors are keyed on the **numeric paragraph id**, not heading text, so deep links survive
edits. The link label is a rendered field render-array, auto-escaped by Twig — no
regex/DOM/string-concat markup building.

## Configuration
- Route `ptoc.type_enable` → `/admin/structure/paragraphs_type/ptoc` (the `configure`
  link; local task under the Paragraphs types collection). Permission
  **`administer paragraphs types`**. Form `PtocConfigForm` (`src/Form/PtocConfigForm.php`):
  1. Toggle **debug** (`ptoc.settings:debug`).
  2. Per paragraph type: enable/disable the `ptoc` display mode (creates/updates
     `core.entity_view_display.paragraph.<bundle>.ptoc`); when enabled, pick which
     `field_*` components show in it. First enabled field = link text (visually-hidden
     label, `ptoc` view mode on reference fields).
- Only fields whose machine name starts with `field_` are toggled by the form.

## Typical setup
1. Enable module; place the **Table of Contents** block on the target pages.
2. Create a `ptoc_page` node, add paragraphs to Sections, save → sidebar ToC of jump links.
3. To add a ToC to another content type: re-use `field_ptoc_sections`, enable its `ptoc`
   display, configure the `ptoc` view mode fields, and widen the View filter/argument +
   block visibility to that bundle (or clone the View/block). See `README.md`.

## Files
- `ptoc.module` — preprocess + theme-suggestion + theme hooks (all the custom code).
- `src/Form/PtocConfigForm.php` — the admin config form.
- `templates/ptoc-paragraph.html.twig`, `templates/ptoc-node.html.twig` — ToC rendering.
- `config/install/*` — node type, paragraph types, fields, view modes, the `ptoc` View,
  `ptoc.settings.yml` (`debug: false`).
- `css/ptoc.css` — debug outline (`ptoc/ptoc-debug` library).
