<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Altering style_option plugin info

The `style_option` plugin manager calls `alterInfo('style_options')`, so you can alter the
discovered plugin definitions with a standard plugin-info alter hook:

```php
/**
 * Implements hook_style_options_alter().
 *
 * @param array $definitions
 *   The discovered style_option plugin definitions, keyed by plugin id.
 */
function my_module_style_options_alter(array &$definitions): void {
  // e.g. relabel or remove a shipped plugin, or swap its class.
  if (isset($definitions['background_image'])) {
    $definitions['background_image']['label'] = t('Hero image');
  }
}
```

This alters the **plugin definitions** (the available option types), not the per-option YAML
configuration. To change which options appear on a layout or paragraph type, edit the
`[ext].style_options.yml` `contexts` section instead (see
[../configure/style-options-yml.md](../configure/style-options-yml.md)).
