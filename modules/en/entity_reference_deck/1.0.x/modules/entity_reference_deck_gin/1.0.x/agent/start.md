<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck Gin (entity_reference_deck_gin) — agent index

Skin submodule of **Entity Reference Deck** for the **Gin** admin theme. Depends on
`entity_reference_deck`. Core `^11.4 || ^12`. Version 1.0.0-beta5. No routes, permissions, services
or plugins.

## What it provides
- Hook class `Hook/LibraryHooks` (`hook_library_info_alter`) — adds
  `entity_reference_deck_gin/gin_skin` as a dependency of the deck `card` / `deck_dialog` libraries,
  the EB `widget` library, and the Paragraphs `widget` library, so Gin edit forms load the token remap.
- Library **`gin_skin`** (`css/entity-reference-deck-gin.css`) remapping `--erdeck-*` tokens, scoped
  to `body.gin--edit-form`.

## Operate
Enable only with the Gin admin theme. No configuration.
