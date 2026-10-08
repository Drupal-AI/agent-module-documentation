Theme Tokens exposes the active theme's logo and favicon as Drupal tokens — both as ready-to-use `<img>` markup and as raw URLs.

---

The module implements `hook_token_info()` and `hook_tokens()` to add a `theme` token type with four tokens: `[theme:logo]` and `[theme:favicon]` render a themed `image` element (an `<img>` tag) via the renderer, while `[theme:logo-url]` and `[theme:favicon-url]` return just the URL string. Values come from core `theme_get_setting('logo.url')` and `theme_get_setting('favicon.url')` for the currently active theme, so the token resolves against whatever theme is handling the request. It depends on the contrib Token module and has no configuration, permissions, schema, or admin UI — enabling it simply makes the tokens available anywhere Drupal token replacement runs (field defaults, views, mail bodies, metatags, pattern-based modules, etc.). This is a tiny utility module: the four token cases in `theme_tokens_tokens()` are the entire implementation.

---

- Insert the site/theme logo as an `<img>` into an e-mail template via `[theme:logo]`.
- Get the theme logo URL for a custom link or `<img src>` via `[theme:logo-url]`.
- Output the favicon as markup with `[theme:favicon]`.
- Get the favicon URL via `[theme:favicon-url]` for meta tags or manifests.
- Add the logo to a Metatag pattern or Open Graph image field.
- Use the logo token in a field default value or Views rewrite output.
- Include the logo in transactional mail (e.g. with Easy Email / Symfony Mailer templates).
- Build a PDF header that references the current theme's logo URL.
- Reference the logo in a block or custom text without hardcoding a path.
- Show the correct logo automatically when the active theme changes.
- Populate a structured-data (schema.org) logo property with the theme logo URL.
- Add branding to token-driven notification messages.
- Use the favicon URL in a web app manifest or link tag rendered through tokens.
- Provide the logo to any contrib module that consumes tokens (Pathauto-style patterns, Rules, ECA, etc.).
- Keep marketing/email branding in sync with the site theme's configured logo.
- Reference logo/favicon in a Twig template via a token-filter where available.
