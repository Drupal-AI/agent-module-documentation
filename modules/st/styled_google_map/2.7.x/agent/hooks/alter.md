<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# hook_styled_google_map_views_style_alter

Declared in `styled_google_map.api.php`. Invoked while the **Views style** builds its map
render array — use it to mutate map settings and marker locations in code before they reach
the JavaScript. It is *not* invoked for the single-entity field formatter.

```php
/**
 * Implements hook_styled_google_map_views_style_alter().
 */
function MYMODULE_styled_google_map_views_style_alter(array &$variables) {
  // $variables['map_settings'] — full settings tree; ['settings'] holds toggles like
  // ['cluster'], and ['locations'] holds every point on the map (mutate these).
  if (!empty($variables['map_settings']['settings']['cluster'])) {
    // e.g. swap the cluster icon.
  }
  foreach ($variables['map_settings']['locations'] as &$loc) {
    // adjust each marker (icon, popup text, coordinates) here.
  }

  // $variables['context'] — read-only: ['view'] (the View object) and ['options']
  // (the style options). Use only for conditions, do not rely on mutating it.
  if ($variables['context']['view']->id() === 'my_map_view') {
    // target one specific view/display.
  }
}
```

Only two top-level keys are passed: `map_settings` (mutable — settings + `locations`) and
`context` (`view`, `options` — for conditionals). This is the single hook the module
invites; there is no service API to call.
