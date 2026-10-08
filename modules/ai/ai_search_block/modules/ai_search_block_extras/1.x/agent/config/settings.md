<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & behavior

Install: `drush en ai_search_block_extras`.

## Settings form (`src/Form/AiSearchBlockExtrasSettingsForm`)
Route `ai_search_block_extras.settings` → `/admin/config/ai/ai_search_block_extras`
(`_permission: administer ai_search_block_extras`). One checkbox:
- `autogrow_textarea` (bool) — enable the auto-growing textarea.

Saved to config `ai_search_block_extras.settings` (default in `config/install/`; `autogrow_textarea:`
key). A `.links.menu.yml` entry places it under the AI config area.

## Behavior (`Hook/AiSearchBlockExtrasHooks::formAlter`)
`hook_form_alter` on `ai_search_block_form`: if `autogrow_textarea` is enabled AND the block's
`search_config['input_field'] === 'textarea'`, it attaches the library
`ai_search_block_extras/autogrow_textarea` (asset `js/ai_search_block_autogrow.js`). The JS grows the
textarea one row at a time as the user types. No effect on textfield-input blocks or when the toggle
is off. No routes/controllers/services beyond the form; no external calls.
