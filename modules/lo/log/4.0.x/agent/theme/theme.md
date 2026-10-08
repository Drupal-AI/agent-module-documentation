<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme / template

Registered in `Drupal\log\Hook\ThemeHooks` (attribute hooks `#[Hook('theme')]` and
`#[Hook('theme_suggestions_log')]`).

## `log` theme hook

`hook_theme()` registers one hook:

```php
'log' => [
  'render element' => 'elements',
  'initial preprocess' => ThemeHooks::class . '::preprocessLog',
]
```

Default template: `templates/log.html.twig` — a `<div class="log">` that prints `content`.
`preprocessLog()` sets `$variables['log']` from `elements['#log']` (the `Log` entity) and
copies each render child into `$variables['content'][<key>]`.

Available Twig variables: `content` (rendered fields) and `attributes`.

## Template suggestions

`hook_theme_suggestions_log()` adds, in order:

- `log__<view_mode>`
- `log__<bundle>`
- `log__<bundle>__<view_mode>`
- `log__<id>`
- `log__<id>__<view_mode>`

So you can override per view mode, per log type, per specific log, or combinations — e.g.
`log__observation.html.twig` or `log__full.html.twig` (dots in the view mode are converted
to underscores).
