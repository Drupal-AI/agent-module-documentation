<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_ng_lightbox_ajax_path_alter()`

The module has no `.api.php`, but `ng_lightbox_link_alter()` ends with:

```php
\Drupal::moduleHandler()->alter('ng_lightbox_ajax_path', $vars);
```

so every module may implement:

```php
/**
 * Implements hook_ng_lightbox_ajax_path_alter().
 *
 * @param array $vars
 *   The link render array: 'url' (\Drupal\Core\Url), 'text', 'options'.
 */
function mymodule_ng_lightbox_ajax_path_alter(array &$vars) {
  $path = $vars['url']->isRouted() ? $vars['url']->getRouteName() : '';

  // Force the lightbox ON for one admin link even though skip_admin_paths is TRUE.
  if ($path === 'entity.node.delete_form') {
    \Drupal::service('ng_lightbox')->addLightbox($vars);
  }

  // Force it OFF for a link that matched the patterns.
  if ($path === 'user.logout') {
    $classes = $vars['options']['attributes']['class'] ?? [];
    $vars['options']['attributes']['class'] = array_values(array_diff((array) $classes, ['use-ajax']));
    unset($vars['options']['attributes']['data-dialog-type'], $vars['options']['attributes']['data-dialog-options']);
  }
}
```

It runs **after** the pattern/class decision, so it is the last word: use it to add the lightbox
attributes to links the matcher skipped (the documented use case is re-enabling specific admin
paths when `skip_admin_paths` is on) or to strip them from links you want left alone.

`$vars` is the same array `hook_link_alter()` receives:

| Key | Contents |
|---|---|
| `url` | `\Drupal\Core\Url` |
| `text` | link text |
| `options` | render options, including `attributes` where the lightbox classes live |
