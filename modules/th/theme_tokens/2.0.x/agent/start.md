# Theme Tokens — agent index

Tiny utility: exposes the active theme's logo and favicon as Drupal tokens. No config, no
permissions, no schema, no UI, no Drush. Depends on contrib `token`.

- **The four tokens and how they resolve** → [api/tokens.md](api/tokens.md)

Key facts:
- Token type `theme`. Tokens: `[theme:logo]`, `[theme:logo-url]`, `[theme:favicon]`,
  `[theme:favicon-url]`.
- `-url` variants return the raw URL; `logo`/`favicon` render a `#theme => image` element
  (an `<img>` tag).
- Sources: `theme_get_setting('logo.url')` / `theme_get_setting('favicon.url')` of the active
  theme. Implemented entirely in `theme_tokens.module` (`hook_token_info`, `hook_tokens`).
