# Tokens

Provided by `theme_tokens.module`. Token type `theme` (requires contrib `token`).

| Token | Returns | Source |
|---|---|---|
| `[theme:logo]` | Rendered `<img>` markup (via `#theme => image`, `#uri => logo url`) | `theme_get_setting('logo.url')` |
| `[theme:logo-url]` | Raw logo URL string | `theme_get_setting('logo.url')` |
| `[theme:favicon]` | Rendered `<img>` markup | `theme_get_setting('favicon.url')` |
| `[theme:favicon-url]` | Raw favicon URL string | `theme_get_setting('favicon.url')` |

- Resolved for the **active** theme handling the current request.
- The `logo`/`favicon` (non-url) tokens call `\Drupal::service('renderer')->renderPlain()` on
  an `image` render element, so they emit a full `<img>` tag; use the `-url` variants when you
  only need the path (e.g. an `href`, meta tag, or manifest).

## Usage in code

```php
$markup = \Drupal::token()->replace('[theme:logo]');
$url    = \Drupal::token()->replace('[theme:logo-url]');
```

Or place any of the four tokens anywhere token replacement runs (mail bodies, field defaults,
Views rewrites, Metatag patterns, etc.).
