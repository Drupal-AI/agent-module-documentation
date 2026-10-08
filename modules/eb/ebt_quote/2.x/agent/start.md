<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Block Types (EBT): Quote (ebt_quote) — agent index

Ships a ready-made **Quote / testimonial block type**: a `block_content` bundle `ebt_quote` carrying a
required WYSIWYG **`body`** (the quote text, `text_with_summary`), a **`field_ebt_quote_author`**
(`text_long`, persona/company + role), a **`field_ebt_quote_image`** (`entity_reference` to a **media**
`image`, persona photo or logo), and the family's shared design field **`field_ebt_settings`**
(`ebt_settings`, from `ebt_core`). Almost everything ships as `config/install`; the module's **only PHP**
is one field widget, `EbtSettingsQuoteWidget` (widget id **`ebt_settings_quote`**), which subclasses
`ebt_core`'s base settings widget to add a **"Quote styles"** radio group with five predefined looks
(`persona`, `company`, `persona_with_small_icon`, `with_square_image`,
`with_frame_and_background_image`). It has **no routes, no services, no permissions, no drush, no plugin
types, no own config schema, and no `.module`**. At render, two Twig templates
(`block--block-content--ebt-quote.html.twig`, `block--inline-block--ebt-quote.html.twig`) branch on the
chosen style, `attach_library` the matching CSS component, arrange image/quote/author into
style-specific wrappers, add a class `ebt-quote-<style>`, and end with `{{ styles|raw }}` — the inline
`<style>` block that `ebt_core`'s `hook_preprocess_block` (`EbtCoreHooks::preprocessBlock` →
`ebt_core.generate_css`) builds from the per-block design options.

It is one of the **Extra Block Types** family (`ebt_core:ebt_core`): many one-component-per-module block
types over a shared core that owns the `ebt_settings` field type, the design/background widget, the
CSS-variable machinery, and the theme-hook registration. Components here are **block content types**
(placeable in a region, droppable into a **Layout Builder** section, referenceable from a field) — that
is the difference from the EPT family (paragraph types). Unlike the plainest siblings (e.g. `ebt_text`,
which uses `ebt_core`'s base widget unchanged), `ebt_quote` **defines its own widget** and ships five
CSS components plus an image style, so the whole component is the block type, its four fields, the two
displays, the custom widget, the five style libraries, the `quote_image` image style, and the two
templates.

- Depends on: `ebt_core:ebt_core` (info.yml). The shipped form/view display config also require
  `media`, `media_library`, `field_group` and `text` — all must be enabled for install to succeed even
  though they are **not** listed in `ebt_quote.info.yml`.
- Install gate: `hook_requirements` (install phase) blocks install unless a **Media type "image"**
  exists (the shipped `media.type.image` config satisfies it).
- Composer: `drupal/ebt_core ^2.0`. No external (non-Drupal) library, no PHP version constraint.
- Core: `^10.1 || ^11 || ^12`. Package: `Extra Block Types`. Version `2.0.0`.
- No settings page / `configure` route. No permissions, no drush, no plugin types, no own config schema.

## What you'd do → where

- **Place a quote block, and understand the block type, its four fields, the two displays, the five
  styles, the templates and where the inline styles come from** →
  [configure/block-type.md](configure/block-type.md)
- **The four fields in detail — the WYSIWYG `body`, `field_ebt_quote_author`, the media
  `field_ebt_quote_image` (+ `quote_image` image style), and the `ebt_settings` design options** →
  [fields/structure.md](fields/structure.md)
- **The custom `ebt_settings_quote` widget — the "Quote styles" radios, the five looks, `formElement`
  and `massageFormValues`** → [plugins/widget.md](plugins/widget.md)

## Key facts (real machine names)

- Block content type: `ebt_quote` (label "EBT Quote", `revision: 0`, description "Extra Block Type
  (EBT): Quote"). Config: `block_content.type.ebt_quote`.
- Fields on the bundle:
  - `body` — `text_with_summary`, **required** (`required: true`, `display_summary: false`), label
    "Quote". Form widget `text_textarea_with_summary` (rows 9). View formatter `text_default` (label
    hidden) → output via `check_markup()` with the editor's text format. Storage
    `field.storage.block_content.body` (core `text`).
  - `field_ebt_quote_author` — `text_long`, not required, label "Quote Author". Form widget
    `text_textarea` (rows 5). View formatter `text_default` (label hidden). Storage
    `field.storage.block_content.field_ebt_quote_author` (shipped here).
  - `field_ebt_quote_image` — `entity_reference` → `media`, target bundle `image`, not required, label
    "Quote Image". Form widget `media_library_widget`. View formatter `media_thumbnail` with image
    style **`quote_image`** and `image_loading: lazy`. Storage
    `field.storage.block_content.field_ebt_quote_image` (shipped here).
  - `field_ebt_settings` — `ebt_settings` (storage/type owned by `ebt_core`). Form widget
    **`ebt_settings_quote`** (`Drupal\ebt_quote\Plugin\Field\FieldWidget\EbtSettingsQuoteWidget`), view
    formatter `ebt_settings_default`. Label "Block settings", not required. The selected quote style is
    stored at `field_ebt_settings[0]['ebt_settings']['styles']`.
- Image style: `quote_image` (`image.style.quote_image`) — single `image_scale` effect, width 530, no
  upscale.
- Libraries (`ebt_quote.libraries.yml`), one CSS component each: `persona`, `company`,
  `persona_with_small_icon`, `with_square_image`, `with_frame_and_background_image`. The active template
  branch `attach_library`s exactly one, keyed by the stored style (default `persona`).
- Form display `block_content.ebt_quote.default`: `field_group` tabs `group_tabs` → `group_content` (tab
  "Content": `info`, `body`, `field_ebt_quote_author`, `field_ebt_quote_image`) and `group_settings`
  (tab "Settings": `field_ebt_settings`). Requires modules `ebt_quote`, `field_group`, `media_library`,
  `text`.
- View display `block_content.ebt_quote.default`: `field_ebt_quote_image` (`media_thumbnail`),
  `body`/`field_ebt_quote_author` (`text_default`, labels hidden), `field_ebt_settings`
  (`ebt_settings_default`, label above). Requires `ebt_core`, `media`, `text`.
- Templates (theme hooks registered by `ebt_core`'s `theme_registry_alter`, suggestions added by
  `ebt_core`'s `theme_suggestions_block_alter`): `block--block-content--ebt-quote.html.twig` (hook
  `block__block_content__ebt_quote`) and `block--inline-block--ebt-quote.html.twig` (hook
  `block__inline_block__ebt_quote`). Both branch on `…ebt_settings.styles`, add classes `block ebt-block
  ebt-block-<plugin_id> block-<provider> block-<plugin_id> plugin-id-<plugin_id> ebt-quote-<style>`
  (inline-block also `block-revision-id-<id>`), and end with `{{ styles|raw }}`.
- `.install`: `ebt_quote_requirements` (install-phase Media "image" gate); `ebt_quote_update_9101`
  (updates the block type description); `ebt_quote_uninstall` (logs a notice and **keeps** the block
  type + existing blocks — remove them manually via the custom block library if wanted).
- Rendering/styling machinery is **not in this module**: `ebt_core` services `ebt_core.generate_css`
  (`GenerateCSS`) and `ebt_core.generate_js` (`GenerateJS`), invoked from
  `EbtCoreHooks::preprocessBlock`, set the `styles` variable and the `drupalSettings.ebtCore` data.
