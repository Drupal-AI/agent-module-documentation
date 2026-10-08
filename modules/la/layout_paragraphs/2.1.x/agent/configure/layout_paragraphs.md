# Configure Layout Paragraphs

## 1. Enable a paragraph type as a layout "section"

Layouts come from core **Layout Discovery**. A paragraph type becomes a section by enabling
its `layout_paragraphs` **Behavior** plugin (Paragraphs behaviors, at
`/admin/structure/paragraphs_type/{type}`). The behavior's settings form exposes:

| Setting | Meaning |
|---|---|
| `available_layouts` | Checkboxes of layout plugin ids (from `LayoutPluginManager::getLayoutOptions()`) the section may use. At least one is required. |

Config schema: `paragraphs.behavior.settings.layout_paragraphs` → `enabled` (bool),
`available_layouts` (sequence of layout id → label). A section paragraph stores its chosen
layout + layout plugin config; the `LayoutParagraphsSection` object reads it.

## 2. Add the widget to a paragraphs field (Manage form display)

On any `entity_reference_revisions` field targeting paragraphs, pick the **Layout Paragraphs**
widget (`id: layout_paragraphs`, `multiple_values: TRUE`). Widget settings
(`field.widget.settings.layout_paragraphs`, defaults shown):

| Key | Default | Meaning |
|---|---|---|
| `view_mode` | `default` | View mode used when rendering components |
| `preview_view_mode` | `default` | View mode for in-builder previews |
| `form_display_mode` | `default` | Form mode used to edit a component |
| `nesting_depth` | `0` | Max levels sections may nest (0 = no nesting) |
| `require_layouts` | `0` | If 1, all top-level components must be inside a section |
| `empty_message` | `''` | Placeholder shown when the field is empty |

## 3. Choose a formatter (Manage display)

- `layout_paragraphs` — renders paragraphs wrapped in their layouts (read-only front end).
  Settings: `view_mode`, `link`.
- `layout_paragraphs_builder` — **experimental** front-end/in-place editing builder.
  Settings add `preview_view_mode`, `form_display_mode`, `nesting_depth`, `require_layouts`,
  `empty_message`.

## 4. Module-wide settings forms

Routes require `administer site configuration`:

| Route | Path | Config object | Keys |
|---|---|---|---|
| `layout_paragraphs.label_settings` (the `configure` route) | `/admin/config/content/layout_paragraphs/labels` | `layout_paragraphs.settings` | `show_paragraph_labels` (0), `show_layout_labels` (0), `paragraph_behaviors_label` ('Behaviors'), `paragraph_behaviors_position` (-99), `empty_message` |
| `layout_paragraphs.section_settings` | `/admin/config/content/layout_paragraphs/sections` | `layout_paragraphs.settings` | section-related labels |
| `layout_paragraphs.modal_settings` | `/admin/config/content/layout_paragraphs/modal-settings` | `layout_paragraphs.modal_settings` | `width` ('90%'), `height` ('auto'), `autoresize` (true) |

Set via drush, e.g. `drush cset layout_paragraphs.settings show_layout_labels 1`. All are
config objects, so they export with `drush config:export`.

## The drag-and-drop builder (runtime)

The builder is the `layout_paragraphs_builder` render element. Its AJAX endpoints live under
`/layout-paragraphs-builder/...` (choose-component, insert, edit, duplicate, delete, reorder),
all guarded by the `_layout_paragraphs_builder_access` access check and operating on a
`LayoutParagraphsLayout` held in the private tempstore (`layout_paragraphs.tempstore_repository`).
Editors normally never touch these directly — they interact with the widget UI.
