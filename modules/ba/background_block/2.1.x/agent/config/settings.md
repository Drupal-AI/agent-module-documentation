<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring block background color & opacity

Everything is per-block on the standard block configuration form; there is no dedicated settings route.

## Install / enable
- `drush en background_block -y`. Requires core `block` (auto-enabled).
- Grant the `administer background block` permission (defined in `background_block.permissions.yml`) to the
  roles allowed to set backgrounds. Users still need `administer blocks` to reach the block form at all.

## The form fields (`background_block_form_block_form_alter`)
Defined in `background_block.module`. The alter runs only when the current user
`hasPermission('administer background block')`. It sets `$form['third_party_settings']['#tree'] = TRUE` and
adds a collapsible **"Color settings"** fieldset (`#weight` 5) containing:

- `third_party_settings[background_block][colors_settings][background]` — `#type => 'color'`
  (core `Drupal\Core\Render\Element\Color`). Label "Background Block Color", description
  "Color Code. eg: #ffffff or white".
- `third_party_settings[background_block][colors_settings][opacity]` — `#type => 'number'`,
  `#min => 0`, `#max => 1`, `#step => 0.01`.

Default values are read back from the block's existing third-party settings via
`$block->getThirdPartySetting('background_block', 'colors_settings')`.

## How values are stored
Because the fields live under `third_party_settings` with `#tree = TRUE`, core's block form saves them
automatically as **third-party settings** on the block config entity, under provider `background_block`,
key `colors_settings` (`.background`, `.opacity`). No custom submit handler is involved. The module ships
**no `config/schema`**, so these third-party settings are schema-less.

`background_block_block_presave()` (implements `hook_ENTITY_TYPE_presave` for `BlockInterface`) unsets the
top-level `background` third-party setting when it is empty — note this checks the `background` key, not
`colors_settings`, so it is effectively a no-op for the keys the form actually writes (a leftover from an
earlier storage layout).

## How values are applied (`background_block_preprocess_block`)
On block render, the module loads the block by `#id` and, if set, writes to the block wrapper's `style`:

- if `colors_settings.background` is set → `style = 'background-color:' . $background`
- if `colors_settings.opacity` is set → `style = 'opacity:' . $opacity`

`$variables['attributes']` is a `Drupal\Core\Template\Attribute` object, so the value is HTML-escaped when
the template renders `{{ attributes }}`.

### Known functional quirks
- The two `if` blocks both **assign** to `$variables['attributes']['style']` rather than appending, so when
  both a color and an opacity are set, the opacity assignment **overwrites** the background-color one — only
  opacity is applied. Setting just one of the two works as expected.
- The `#type => 'color'` element validates and normalizes its value server-side to a `#rrggbb` hex string
  (`Color::validateColor` → `ColorUtility::hexToRgb`/`rgbToHex`); non-hex input (including a CSS keyword like
  `white`, despite the field description) is rejected with a form error, so the stored value is always a
  normalized hex color.

## Operating notes
- Values export with the block via config sync (they are part of the block entity).
- To clear a background, blank the color field and re-save the block.
- There are no routes, services, plugins, Drush commands, or libraries to configure.
