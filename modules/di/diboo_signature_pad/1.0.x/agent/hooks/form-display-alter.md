<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_entity_form_display_alter — diboo_signature_pad

File: `diboo_signature_pad.module`. Function: `diboo_signature_pad_entity_form_display_alter(EntityFormDisplayInterface $form_display, array $context)`. This is the module's entire logic — there is no other code, config, or schema.

## Install / enable
- `ddev drush en diboo_signature_pad -y`. Requires `diboo_core` and `signature_pad` to be present (declared in `diboo_signature_pad.info.yml`).
- No configuration step: README's CONFIGURATION section is "None". Once enabled, the alter fires automatically.

## Guard (early return)
The hook does nothing unless BOTH conditions hold:
1. `$context['form_mode'] === 'diboo_chain_link'` — only the Diboo chain-link form mode is affected.
2. `$form_display->getComponent('diboo_image')` returns a component — the display must already expose the `diboo_image` field.

If either fails it `return`s and the form display is left untouched. So a stock site without the `diboo_chain_link` form mode / `diboo_image` field sees no change.

## What it changes
On the `diboo_image` component:
- `type` → `signature_pad` (the widget provided by the `signature_pad` module; this module does not define the widget).
- `settings` (replaces the component's widget settings wholesale):
  - `progress_indicator`: `throbber`
  - `preview_image_style`: `''`
  - `background_color`: `rgba(0,0,0,0)` (transparent)
  - `pen_color`: `#000000`
  - `aspect_ratio`: `16:10`
  - `format`: `image/png`
  - `filename`: `drawing` (comment in source notes the file is randomized on upload regardless)
  - `min_strokes`: `10`
  - `min_strokes_message`: `Please add some strokes to give it more detail`
  - `fixed_width`: `0`, `fixed_height`: `0`
  - `reset_button`: `button`
  - `save_json_data`: `TRUE`
  - `dimensions_from_image`: `FALSE`
  - `color_picker`: `jscolor`
  - `size_picker`: `slider`
  - `undo`: `button`
  - `hide_remove_button`: `TRUE`
  - `hide_alt_field`: `TRUE`
  - `hide_title_field`: `TRUE`
  - `hide_image_link`: `'1'`
- `third_party_settings['change_labels']`:
  - `remove_label`: `''`
  - `field_label_overwrite`: `<nolabel>` (relies on the `change_labels` contrib module for effect).

Finally it calls `$form_display->setComponent('diboo_image', $imageComponent)` to write the modified component back.

## Notes for agents
- The actual capture, base64/data-URI decoding, MIME handling and file saving of the drawn image are done by the `signature_pad` widget in its own module — not here. This module only selects and configures that widget.
- To change any widget default you must edit this hook (or replace the module) — there is no admin form and no config object to override.
- `field_label_overwrite`/`remove_label` only take effect if the `change_labels` module is installed; they are third-party settings, not core keys.
