<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Text (ebt_text) — agent index

Ships a ready-made **Text block type**: a `block_content` bundle `ebt_text` carrying a required
WYSIWYG **`body`** (`text_with_summary`) plus the family's shared design field
**`field_ebt_settings`** (`ebt_settings`, from `ebt_core`). Everything ships as `config/install` — the
module is *pure configuration plus two Twig wrappers*: it has **no `src/`, no `.module`, no routes,
no services, no permissions, no drush, no plugin types, and no own config schema**. The block's edit
form is split by `field_group` into a **Content** tab (`info` + `body`) and a **Settings** tab
(`field_ebt_settings`, edited with `ebt_core`'s base widget `ebt_settings_default`). At render the two
templates (`block--block-content--ebt-text.html.twig`, `block--inline-block--ebt-text.html.twig`) wrap
the body in `.ebt-block > .ebt-container`, print an optional `<h2>{{ label }}</h2>`, drop
`field_ebt_settings` from the printed content, and emit `{{ styles|raw }}` — the inline `<style>` block
that `ebt_core`'s `hook_preprocess_block` (`EbtCoreHooks::preprocessBlock` → `ebt_core.generate_css`)
builds from the design options.

It is one of the **Extra Block Types** family (`ebt_core:ebt_core`): many one-component-per-module block
types over a shared core that owns the `ebt_settings` field type, the design/background widget, the
CSS-variable machinery, and the theme-hook registration. Components here are **block content types**
(placeable in a region, droppable into a **Layout Builder** section, referenceable from a field) — that
is the difference from the EPT family (paragraph types). Unlike heavier siblings (e.g. `ebt_slideshow`)
this module uses **no paragraphs and defines no widget of its own**; the body is plain rich text, so
the whole component is the shipped block type, its two fields, the two displays, and the two templates.

- Depends on: `ebt_core:ebt_core` (info.yml). The shipped form/view display config also require
  `field_group` and `text` — both must be enabled for install to succeed even though they are **not**
  listed in `ebt_text.info.yml`.
- Composer: `drupal/ebt_core ^2.0`. No external (non-Drupal) library, no PHP version constraint.
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Block Types`. Version `2.0.0`.
- No settings page / `configure` route. No permissions, no drush, no plugin types, no own config schema.

## What you'd do → where

- **Place a text block, and understand the block type, its fields, the two displays, the templates and
  where the inline styles come from** → [configure/block-type.md](configure/block-type.md)
- **The two fields in detail — the WYSIWYG `body` and the `ebt_settings` design options (every option
  key, defaults, validation, how the body is filtered)** → [fields/structure.md](fields/structure.md)

## Key facts (real machine names)

- Block content type: `ebt_text` (label "EBT Text", `revision: 1`, description "Adds Text block type
  with WYSIWYG editor"). Config: `block_content.type.ebt_text`.
- Fields on the bundle:
  - `body` — field type `text_with_summary`, **required** (config `required: true`, also enforced by
    `ebt_text_update_9101`). Form widget `text_textarea_with_summary` (rows 9, summary hidden). View
    formatter `text_default` (label hidden) → output runs through the chosen **text format**
    (`check_markup`). Storage `field.storage.block_content.body` (core `text` module).
  - `field_ebt_settings` — field type `ebt_settings` (storage owned by `ebt_core`). Form widget
    `ebt_settings_default` (`Drupal\ebt_core\Plugin\Field\FieldWidget\EbtSettingsDefaultWidget`), view
    formatter `ebt_settings_default`. Label "Block settings", not required. Dropped from the block
    template via `content|without('field_ebt_settings')`.
  - `info` — the block_content base "Block description" field (`string_textfield` widget), on the
    Content tab.
- Form display `block_content.ebt_text.default`: `field_group` tabs `group_tabs` → `group_content`
  (tab "Content": `info`, `body`) and `group_settings` (tab "Settings": `field_ebt_settings`). Requires
  modules `ebt_core`, `field_group`, `text`.
- View display `block_content.ebt_text.default`: `body` (`text_default`, label hidden),
  `field_ebt_settings` (`ebt_settings_default`, label hidden). Requires `ebt_core`, `text`.
- Templates (theme hooks registered by `ebt_core`'s `theme_registry_alter`, suggestions added by
  `ebt_core`'s `theme_suggestions_block_alter`): `block--block-content--ebt-text.html.twig` (hook
  `block__block_content__ebt_text`) and `block--inline-block--ebt-text.html.twig` (hook
  `block__inline_block__ebt_text`). Both add classes `block ebt-block ebt-block-<plugin_id>
  block-<provider> block-<plugin_id>` (block-content also `plugin-id-<plugin_id>`; inline-block also
  `block-revision-id-<id>`), and end with `{{ styles|raw }}`.
- `.install`: `ebt_text_update_9101` (make `body` required); `ebt_text_uninstall` (logs a notice and
  **keeps** the block type + existing blocks on uninstall — remove them manually via the custom block
  library if wanted).
- Rendering/styling machinery is **not in this module**: `ebt_core` services `ebt_core.generate_css`
  (`GenerateCSS`) and `ebt_core.generate_js` (`GenerateJS`), invoked from
  `EbtCoreHooks::preprocessBlock`, set the `styles` variable and the `drupalSettings.ebtCore` data.
