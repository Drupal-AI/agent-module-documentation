<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig HTML entities decode (twig_htmlspecialchars_decode) — agent index

One Twig filter, `htmlspecialchars_decode`, wrapping PHP's `htmlspecialchars_decode()`. No
dependencies, routes, permissions, config, schema, or hooks. Core `^9 || ^10 || ^11`.

Key facts:
- Whole module: `src/TwigHtmlSpecialCharsDecode.php` (extends `Twig\Extension\AbstractExtension`,
  registers the filter in `getFilters()`) + `twig_htmlspecialchars_decode.services.yml` (tagged
  `twig.extension`, service id `twig_htmlspecialchars_decode.twig.TwigHtmlSpecialCharsDecode`).
- Filter name: **`htmlspecialchars_decode`**; implementation
  `filter($text)` → `htmlspecialchars_decode((string) $text)`. Registered with **no `is_safe`
  flag** and no `preserves_safety`, so it returns a plain string that Twig re-escapes on print in
  auto-escaped contexts.
- Reason it exists: the Drupal 8 idiom `value|convert_encoding('UTF-8', 'HTML-ENTITIES')` throws
  under Drupal 9+ (Twig switched from `mbstring` to `iconv`, which rejects `HTML-ENTITIES`). This
  filter is the one-step replacement.

## What you'd do → where

- **Use the `htmlspecialchars_decode` filter in a template — syntax, behavior, escaping, and how
  to add a similar filter yourself** → [theming/twig-filter.md](theming/twig-filter.md)
