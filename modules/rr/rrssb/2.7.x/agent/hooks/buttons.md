# Adding / altering RRSSB buttons

Defined in `rrssb.api.php`. The built-in buttons are themselves provided via
`rrssb_rrssb_buttons()`; you extend or change them from any module.

## `hook_rrssb_buttons()` — add buttons

Return an array keyed by button name. Each value may contain:

| Key | Meaning |
|---|---|
| `svg` | Minified inline `<svg>` markup (no width/height/fill) |
| `svgfile` | Path to an SVG file (alternative to `svg`); defaults to `<name>.min.svg` in the library icons dir |
| `share_url` | Share URL template; supports `[rrssb:url]`, `[rrssb:title]`, `[rrssb:image]` |
| `follow_url` | Follow URL template; supports `[rrssb:username]` |
| `color` / `color_hover` | Button background colours |
| `text` | Button text (defaults to the button name) |
| `popup` | Whether to open in a popup (default TRUE) |

You must supply at least one of `share_url` / `follow_url`.

```php
function mymodule_rrssb_buttons() {
  return [
    'mastodon' => [
      'svgfile' => '/path/to/mastodon.min.svg',
      'follow_url' => 'https://mastodon.social/@[rrssb:username]',
      'color' => '#6364FF',
    ],
  ];
}
```

## `hook_rrssb_buttons_alter(&$buttons)` — change existing buttons

```php
function mymodule_rrssb_buttons_alter(&$buttons) {
  // Point the email button at a newsletter subscribe page.
  if (\Drupal::service('module_handler')->moduleExists('simplenews')) {
    $buttons['email']['follow_url'] = '/newsletter/subscriptions';
    $buttons['email']['title_follow'] = 'subscribe';
  }
}
```

After changing button definitions, regenerate the per-button CSS in the library →
[../drush/gen-css.md](../drush/gen-css.md).
