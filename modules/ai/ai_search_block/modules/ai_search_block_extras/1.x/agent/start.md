<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Search Block Extras (ai_search_block_extras) — agent index

Submodule of `ai_search_block`. Opt-in UX add-ons; ships an auto-grow textarea for the AI Search
form. Presentation only.

## Dependencies
- `ai_search_block` (parent). Core `^10.2 || ^11 || ^12`.

## Provides
- Admin settings form `AiSearchBlockExtrasSettingsForm` (route `ai_search_block_extras.settings`,
  `/admin/config/ai/ai_search_block_extras`, `_permission: administer ai_search_block_extras`).
  Single toggle `autogrow_textarea`.
- Permission `administer ai_search_block_extras` (`restrict access: true`).
- Config object `ai_search_block_extras.settings` (`config/install/`), key `autogrow_textarea` (bool).
- Hook (`Hook/AiSearchBlockExtrasHooks::formAlter`): on `ai_search_block_form`, when the toggle is on
  and the block's `input_field` is `textarea`, attaches library
  `ai_search_block_extras/autogrow_textarea` (`js/ai_search_block_autogrow.js`).
- Menu link (`.links.menu.yml`) under the AI config area.

## Solution doc
- Settings & behavior: [agent/config/settings.md](config/settings.md)
