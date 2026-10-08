<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# altcolor — `hook_altcolor_alter_colors` (derived colors)

Declared in `altcolor.api.php`. Invoked by `AltColorPreprocessHooks::preprocessHtml` via
`$moduleHandler->invokeAll('altcolor_alter_colors', [$theme, &$colors, &$cacheableMetadata])`,
**after** the saved colors are read and **before** they are serialized into the `<html>` style
attribute. Use it to add derived/computed colors (lighten, darken, hue-shift) for browsers that
lack CSS Color 5 relative-color support, or to override colors conditionally per theme.

## Signature

```php
function hook_altcolor_alter_colors(
  string $theme,
  array &$colors,
  \Drupal\Core\Cache\CacheableMetadata &$cacheableMetadata
): void {
  if ($theme === 'olivero') {
    $colors['base-secondary-color'] = '#8f45a8';
  }
}
```

- `$theme` — active theme system name.
- `&$colors` — map of `variable => value`. Each entry is emitted verbatim as
  `--color-<variable>: <value>;`. Add keys for new derived variables, or replace existing values.
- `&$cacheableMetadata` — add cache contexts/tags/max-age here if your derivation depends on
  request state (the preprocess already adds the `theme` context and the `<theme>.config`
  dependency).

## Contract / caveats

- The module does **not** validate the value you set — the api file states it is the implementer's
  responsibility to supply a valid CSS color. Emit only trusted, well-formed color strings.
- Prefer pure-CSS relative colors in the theme's own CSS when possible, e.g.
  `--color-x-light: hsl(from var(--color-x) h s calc(l + 10%));`; use this hook only when you need
  PHP-side computation (e.g. a third-party color library) or legacy-browser fallbacks.
- Variable names become CSS custom-property names as-is; keep them CSS-identifier safe.
