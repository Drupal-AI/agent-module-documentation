<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Pseudofields (crossword_pseudofields) — agent index

Submodule of **crossword**. Exposes puzzle parts as placeable pseudofields on node (and media, with
crossword_media) displays. Deps: `crossword:crossword`, core `node`. Core `^10.2 || ^11`.
GPL-2.0-or-later. `configure: crossword_pseudofields.settings`.

## Provides

- **`hook_entity_extra_field_info()`** — for each node bundle carrying a `crossword` field, registers
  9 display extra-fields: `crossword_title`, `crossword_author`, `crossword_notepad`,
  `crossword_controls`, `crossword_active_clue`, `crossword_grid`, `crossword_across`,
  `crossword_down`, `crossword_playable` (all `visible: FALSE` by default).
- **`hook_entity_view_alter()`** (`crossword_pseudofields_node_view_alter`) — renders the crossword
  field once via the `crossword_pseudofields` formatter using global settings, then maps each parsed
  region into the matching `crossword_*` build key with the component's weight and config cache tags.
- **Formatter** `crossword_pseudofields` = `CrosswordPseudofieldsFormatter` (extends base
  `CrosswordFormatter`); the base formatter's `#pseudofield` flag drives per-pseudofield theme
  suggestions.
- **Route/form** `crossword_pseudofields.settings` → `/admin/config/content/crossword-pseudofields`,
  `_permission: 'configure crossword pseudofields'`, `CrosswordPseudofieldsConfigForm`. Menu link.
- **Permission** `configure crossword pseudofields`.
- **Config** `crossword_pseudofields.settings` (config_object; install defaults in `config/install/`):
  `redacted`, `congrats`, `details.{title,author,notepad}_tag`, `buttons.*`, `clues`, `errors`,
  `references`, `rebus` — mirrors the base formatter's settings but applied globally.
- **`.install`**: `crossword_pseudofields_update_8001/8002` migrate old button config to the current
  schema (show/input_label/confirm).

## Notes

- The pseudofields are display-only extra fields (not stored fields); they read from the same
  `crossword.data_service` output as the formatters. `crossword_media` adds the identical set on media
  bundles when both modules are enabled.
