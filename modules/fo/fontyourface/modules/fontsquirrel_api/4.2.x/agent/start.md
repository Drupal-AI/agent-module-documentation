# fontsquirrel_api — agent start

Submodule of **fontyourface** (`part_of: fontyourface`). A **Font Squirrel provider**: pid
`fontsquirrel_api`, provider name "Font Squirrel". Implements `hook_fontyourface_api()`,
`hook_fontyourface_import()`, `hook_entity_presave()`, `hook_page_attachments()` and
`preprocess_font` hooks.

- **Setup:** none — no account or API key, no provider config object.
- **Import:** run it from `/admin/appearance/font/settings`; a post-install message points you
  there. Fonts (free, commercial-use) are saved as `font` entities with pid `fontsquirrel_api`.

Parent provider hook API + `font`/`font_display` model:
`../../../../fontyourface/4.2.x/agent/start.md`.
