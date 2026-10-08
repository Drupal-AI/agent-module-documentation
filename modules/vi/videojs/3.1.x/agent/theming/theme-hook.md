<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — the `videojs` theme hook

`videojs_theme()` registers one theme hook so custom code can render a player without a field:

```php
'videojs' => [
  'variables' => ['items' => NULL, 'player_attributes' => NULL],
],
```

Template: `templates/videojs.html.twig`. Variables:

- `items` — array of source URLs/objects, rendered as `<source src="...">` (the formatters pass `Url` objects built from absolute file URLs).
- `player_attributes` — array with `width`, `height`, `preload`, and the booleans `controls`, `autoplay`, `loop`, `muted` (same shape as the formatter settings).

Minimal render array:

```php
$build['player'] = [
  '#theme' => 'videojs',
  '#items' => [
    \Drupal\Core\Url::fromUri('base:/sites/default/files/clip.mp4'),
  ],
  '#player_attributes' => [
    'width' => 640,
    'height' => 360,
    'preload' => 'metadata',
    'controls' => TRUE,
    'autoplay' => FALSE,
    'loop' => FALSE,
    'muted' => FALSE,
  ],
  '#attached' => ['library' => ['videojs/videojs']],
];
```

You must attach `videojs/videojs` yourself when rendering the theme hook directly — the template does not attach it.

Note: the README documents a richer legacy Drupal 7-style `theme('videojs', ...)` signature (with `player_id`, VTT `items`, `posterimage_style`). In this 3.1.x release the registered variables are only `items` and `player_attributes`; the poster-image/subtitle handling described in the README is not present in the current theme hook, so rely on the variables above.
