# Paragraphs Summary Token — agent index

Registers Token replacements that build a plain-text **summary** and a representative **image**
from a Paragraphs (`entity_reference_revisions`) field. No config UI (`configure` null), no
permissions, no Drush, no config schema. Depends on `paragraphs` + `token`; the image token also
needs core `image`. Two services do the work; everything else is `hook_token_info_alter()` +
`hook_tokens()` in `paragraphs_summary_token.tokens.inc`.

- **Token names, the `:image:<style>:<property>` syntax, where they appear** →
  [api/tokens.md](api/tokens.md)
- **The two builder services (`text_summary_builder`, `image_builder`) for custom PHP** →
  [api/services.md](api/services.md)

Key facts:
- Summary = first non-empty `text_long` field across the referenced paragraphs, `strip_tags` +
  `text_summary(..., 300)`. Recurses into nested paragraph fields and Paragraphs Library items.
- Image = first `image` field or `media` (image source) reference; supports `url` (default),
  `uri`, `width`, `height`, `mimetype`, `filesize`, plus an optional image style.
- Language-aware: uses the current language's translation of each paragraph.
