<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crossword Token (crossword_token) — agent index

Submodule of **crossword**. Special **file** tokens for crossword metadata + a dynamic image token.
Deps: `crossword:crossword`, contrib `token`. Core `^10.2 || ^11`. GPL-2.0-or-later.

## Provides (all in `crossword_token.tokens.inc`)

`hook_token_info()` + `hook_tokens()` registering file-scoped tokens, resolved via
`crossword.data_service`:

| Token | Source |
|---|---|
| `[file:crossword_author]` | `getAuthor()` |
| `[file:crossword_title]` | `getTitle()` |
| `[file:crossword_dimensions]` | `getDimensions()` (e.g. `15x15`) |
| `[file:crossword_dimension_across]` | `getDimensionAcross()` |
| `[file:crossword_dimension_down]` | `getDimensionDown()` |

Reached through an entity via the field, e.g. `[node:field_crossword:entity:crossword_title]`.

If `crossword_image` is enabled, also a **dynamic** token
`[file:crossword_image:{plugin_id}]` (and `…:{plugin_id}:{image_style}`): resolves through
`crossword.token()->findWithPrefix('crossword_image')`, generates the image with
`crossword.image_service::getImageEntity()`, and returns an absolute file URL — or the image-style
URL via `ImageStyle::load($style)->buildUrl(...)` when a style segment is present. More than two colon
segments are rejected.

## Notes

- No routes/permissions/config/services of its own; pure token integration. Used by the
  `crossword_download` formatters for link text.
