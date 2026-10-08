<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EPT Views (ept_views) — agent index

One module in the **Extra Paragraph Types (EPT)** family. It ships a single Paragraphs bundle,
`ept_views`, that lets an editor embed an **existing Views display** into a page assembled from
paragraphs. The module has essentially **no PHP logic** — only one `hook_help()`; everything it does
is **configuration**: it installs the paragraph type, four fields, and a form/view display. The view
itself is chosen and rendered by the `viewsreference` module — `field_ept_views_view` is a
`viewsreference` field with a `viewsreference_autocomplete` widget and a `viewsreference_formatter`.
`ept_core` supplies the shared design-settings widget (`field_ept_settings`).

Mechanism: on install `config/install/*` creates the `ept_views` paragraph type and its fields. An
editor adds an "EPT Views" paragraph on a host entity that has a paragraphs field, autocompletes a
view + display into `field_ept_views_view`, optionally fills a title/intro and the design settings,
and saves. At render, `templates/paragraph--ept-views--default.html.twig` prints the fields and the
`viewsreference_formatter` executes and builds the chosen display. The formatter runs the view query
and hands back a Views core `#type => view` render element, whose pre-render
(`Drupal\views\Element\View::preRenderViewElement`) re-checks the display's **access plugin against
the current viewer** before emitting markup — so the embedded view keeps its own access control.

- Depends on: `ept_core:ept_core`, `paragraphs:paragraphs`, `viewsreference:viewsreference` (all
  required). Installed config also pulls in `views`, `text`, and `field_group`.
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Paragraph Types`. Version `2.0.0`.
- **No** settings page / `configure` route, **no** permissions, **no** drush, **no** plugin types,
  **no** config schema of its own, **no** routes/controllers/forms. The only service is the autowired
  hook class `Drupal\ept_views\Hook\EptViewsHooks`.
- All "configuration" is the shipped paragraph type + fields + form/view display (edit on the
  paragraph type's *Manage form display* / *Manage display*), plus the per-field `viewsreference`
  settings that decide which views are embeddable and which per-placement options appear.

## What you'd do → where

- **Change which views an editor may embed, the enabled per-view options, the autocomplete widget,
  the tabs, or add the paragraph to a host entity** → [configure/paragraph-type.md](configure/paragraph-type.md)
- **The four fields, their machine names, types, widgets and formatters** → [fields/fields.md](fields/fields.md)

## Key facts (real machine names)

- Paragraph type (bundle) id: `ept_views` (`paragraphs.paragraphs_type.ept_views`), label "EPT Views".
- Fields on the bundle: `field_ept_title` (`text_long`), `field_ept_text` (`text_long`),
  `field_ept_views_view` (`viewsreference`, **required**, cardinality 1, `target_type: view`),
  `field_ept_settings` (`ept_settings`, from ept_core).
- Field storage shipped here: `field.storage.paragraph.field_ept_views_view` (type `viewsreference`,
  module `viewsreference`). The `field_ept_title` / `field_ept_text` / `field_ept_settings` storages
  come from ept_core.
- viewsreference instance settings (`field.field.paragraph.ept_views.field_ept_views_view`):
  `handler: default:view`, `plugin_types: {block: block}`, `preselect_views: {}`,
  `enabled_settings: {}`.
- Form display (`paragraph.ept_views.default`) widgets: `field_ept_views_view` →
  `viewsreference_autocomplete` (`match_operator: CONTAINS`, `match_limit: 10`, `size: 60`);
  `field_ept_settings` → `ept_settings_default`; `field_ept_title` / `field_ept_text` →
  `text_textarea`. Fields sit in `field_group` tabs: `group_tabs` → `group_content` (title, text,
  view) + `group_settings` (settings).
- View display (`paragraph.ept_views.default`) formatters: `field_ept_views_view` →
  `viewsreference_formatter` (setting `plugin_types: [block]`); `field_ept_settings` →
  `ept_settings_default`; `field_ept_title` / `field_ept_text` → `text_default`.
- Library: `ept_views/ept_views` — attaches `css/ept-views.css` (single rule hiding
  `.viewsreference--view-title`).
- Template: `templates/paragraph--ept-views--default.html.twig` (theme suggestion
  `paragraph--ept-views--default`).
- Hook: `hook_help()` for route `help.page.ept_views`, via `EptViewsHooks::help`
  (OOP `#[Hook('help')]` + `#[LegacyHook]` shim in `ept_views.module`).
