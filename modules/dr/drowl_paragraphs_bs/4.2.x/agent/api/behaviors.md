<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base behaviors: hooks, theming, libraries, Drush

All in `drowl_paragraphs_bs.module` unless noted. There are no services and no custom plugin managers.

## Preprocess / attribute application

- `hook_preprocess_paragraph()` (`drowl_paragraphs_bs_preprocess_paragraph`): attaches the
  `drowl_paragraphs_bs/global` frontend library to every paragraph, then reads the paragraph's
  `field_settings` (only if it is a `drowl_paragraphs_bs_settings` field). From the stored settings it:
  - collects up to 4 animations into a `data-animations` JSON attribute and adds the `has-animation`
    class (values `Json::encode`d);
  - sets `data-equal-height-group` and attaches `drowl_paragraphs_bs/equal_height_groups` when a group
    is set;
  - adds `classes_additional` via `Attribute::addClass()` and sets `id_attr` via `setAttribute('id', …)`.
  These stored values were already sanitized on save (`Html::getClass` / `Html::cleanCssIdentifier`, see
  [../fields/settings-field.md](../fields/settings-field.md)).
- `hook_preprocess_layout_paragraphs_builder()`: attaches `drowl_paragraphs_bs/admin` to the builder form.
- `hook_preprocess_details()`: for UI-Styles `ui_style_options` details inside `behavior_plugins`, adds a
  `form-wrapper--<label>` class and force-opens a whitelist of option groups (Layout Options, Icon,
  Buttons, Score, Slideshow, Tabs / Accordion, Image Style, Media+Text, Card, Gallery).

## Theme + suggestions

- `hook_theme()` registers `field__field_paragraphs_paragraphs`, `paragraph_preview_placeholder`,
  `paragraph__drowl_paragraphs_bs`, and `form__drowl_paragraphs_bs__layout_paragraphs_component_form`
  (templates in `templates/`).
- `hook_theme_suggestions_paragraph_alter()` prepends `paragraph__drowl_paragraphs_bs`,
  `…__<type>`, and `…__<type>__<view_mode>` suggestions so the module's base paragraph template applies.
- `hook_theme_suggestions_form_alter()` adds `form__drowl_paragraphs_bs[…]` suggestions for the
  `layout_paragraphs_component_form`.
- `hook_theme_suggestions_paragraph_preview_placeholder()` adds view-mode/bundle suggestions.

## Preview placeholder

- `hook_entity_extra_field_info()` adds a hidden `paragraph_preview_placeholder` display component to
  every Paragraph type.
- `hook_ENTITY_TYPE_view()` (`drowl_paragraphs_bs_paragraph_view`): when that component is enabled, renders
  the `paragraph_preview_placeholder` theme hook using the Paragraph type's icon
  (`getParagraphType()->getIconFile()->createFileUrl()`) — used to show a lightweight placeholder in the
  Layout Paragraphs preview instead of the full render.

## Form alter

- `hook_form_layout_paragraphs_component_form_alter()`: changes `behavior_plugins` from a details to a
  `container` so editors don't need an extra click to reach UI Styles.

## Field info + libraries

- `hook_field_info_alter()`: sets the `drowl_paragraphs_bs_settings` category label on Drupal < 10.2 (legacy
  shim).
- `drowl_paragraphs_bs.libraries.yml`: `global` (frontend CSS/JS + `/libraries/verge/verge.min.js`),
  `admin` (admin CSS + depends on `drowl_layouts_bs/*`, `admin_iconset`, `admin_preview_styles`),
  `admin_iconset` (`/libraries/drowl-admin-iconset/style.css`), `admin_preview_styles`,
  `equal_height_groups` (JS).

## Drush

`\Drupal\drowl_paragraphs_bs\Drush\Commands\DrowlParagraphsBsCommands`:
- `drowl_paragraphs_bs:install-submodules` (alias `dpbs-install-sub`), option `--exclude=a,b,c`.
  Scans `modules/*/*.info.yml`, derives submodule machine names, and calls
  `moduleInstaller->install()` on the (non-excluded) list. Convenience installer for the 23 bundles.
