<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crisis Mode — settings & config object

## Install / enable
`composer require drupal/crisis_mode` then enable (`drush en crisis_mode`). `crisis_mode_install()` (`crisis_mode.install`) creates a **disabled** block instance `crisismodeblock` (plugin `crisis_mode_block`) in the `content` region of the current default theme, weight `-9999`, label "Crisis Mode Block" with `label_display: 0`. Nothing is shown to visitors until crisis mode is activated. `crisis_mode_uninstall()` loads and deletes `crisismodeblock`.

## Configuration route
`crisis_mode.settings` → `/admin/config/system/crisis_mode`, permission **`administer crisis mode`** (`restrict access: TRUE`). Form: `\Drupal\crisis_mode\Form\CrisisModeSettingsForm`. Menu link under `system.admin_config_system`; a local task tab is also defined.

## Config object `crisis_mode.settings`
Default values from `config/install/crisis_mode.settings.yml`:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `crisis_mode_active` | int (0/1) | `0` | Master on/off flag; mirrors block enabled state |
| `crisis_mode_title` | label | `Crisis` | Block heading (required in form) |
| `crisis_mode_text` | mapping `{value, format}` | `<p>Crisis message ... </p>`, `full_html` | Rich-text body (required); form uses `text_format` fixed to `full_html` |
| `crisis_mode_link_title` | label | `More information` | CTA button label |
| `crisis_mode_node` | string (node id) | `''` | Optional internal node the CTA links to |
| `crisis_mode_region` | string | `''` | Theme region for the block (empty = Content) |
| `crisis_mode_background_color` | string | `#ffffff` | Form `#type: color` |
| `crisis_mode_background_image` | managed_file fid(s) | `''` | Block background image (`public://crisis_mode`, gif/png/jpg/jpeg, ≤25.6MB) |
| `crisis_mode_block_image` | managed_file fid(s) | `''` | Foreground image (same upload validators) |
| `crisis_mode_language_restriction` | checkboxes | `''` | Only shown/used on multilingual sites |

Only `crisis_mode_title`, `crisis_mode_link_title` and `crisis_mode_text` (`value`+`format`) are declared in `config/schema/crisis_mode.schema.yml`; the remaining keys are written by the form without explicit schema. These three fields are exposed to config translation (`crisis_mode.config_translation.yml`).

## Save behaviour (`submitForm()`)
1. Writes every cleaned form value into `crisis_mode.settings` and saves.
2. If `crisis_mode_active` is true → `Block::load('crisismodeblock')->enable()->save()`; else `->disable()->save()`. (Both branches print the same "Crisis Mode enabled!" status message; a logger notice records the real Enabled/Disabled state on channel "Crisis Mode".)
3. If a region was chosen → `$block->setRegion(...)->save()`.
4. On multilingual sites, selected `crisis_mode_language_restriction` langcodes are written into the block's `language` visibility condition (context `@language.current_language_context:language_interface`).
5. Calls `drupal_flush_all_caches()` — every save clears all caches.

## Notes for agents
- The active theme's default is read via `system.theme` `default`; regions come from `system_region_list()`.
- `crisis_mode_node` is an `entity_autocomplete` to `node`; stored as a node id.
