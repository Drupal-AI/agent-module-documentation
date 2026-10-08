# adobe_edge_fonts — agent start

Submodule of **fontyourface** (`part_of: fontyourface`). An **Adobe Edge Fonts provider**: pid
`adobe_edge_fonts`, provider name "Adobe Edge". Implements `hook_fontyourface_api()`,
`hook_fontyourface_import()`, `hook_page_attachments()`.

- **Setup:** none — no account or API key. No provider config object.
- **Import:** run it from `/admin/appearance/font/settings` ("Import from adobe_edge_fonts").
  Auto-import at install is disabled (large catalog); a post-install message points you to the
  settings form. Fonts are saved as `font` entities with pid `adobe_edge_fonts`.

Parent provider hook API + `font`/`font_display` model:
`../../../../fontyourface/4.2.x/agent/start.md`.
