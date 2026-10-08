# Overriding layouts with Layout Options UI

## The settings form

Route `layout_options_ui.settings` → `/admin/config/system/layout_options/config` (permission
`administer site configuration`), form `\Drupal\layout_options_ui\Form\Settings`
(config form, form id `layout_options_settings`). It lists all discovered layouts (from
`plugin.manager.core.layout`) as checkboxes; ticking one marks that layout to be overridden to
use the Layout Options plugin. On submit it saves the config and clears the plugin cache.

## The config: `layout_options.settings` → `layout_overrides`

Only config object is `layout_options.settings` (schema in the submodule:
`layout_options_ui.schema.yml`). Its `layout_overrides` key is a map:

```yaml
layout_options.settings:
  layout_overrides:
    layout_discovery__layout_onecol: true    # {provider}__{layout_id}: bool
    layout_discovery__layout_twocol: true
    layout_builder__layout_twocol_section: false
```

- **Key** = `"{provider}__{layout_id}"`. The provider is the layout definition's provider —
  core layouts are provided by **`layout_discovery`** (so `layout_onecol` →
  `layout_discovery__layout_onecol`), Layout Builder's own by `layout_builder`.
- **Value** = `1`/`true` to override, `0`/`false` (or absent) to leave the core class.

### Read / write

```bash
drush cget layout_options.settings layout_overrides
```

```php
\Drupal::configFactory()->getEditable('layout_options.settings')
  ->set('layout_overrides', ['layout_discovery__layout_onecol' => 1])
  ->save();
\Drupal::service('plugin.manager.core.layout')->clearCachedDefinitions();  // or drush cr
```

## How the swap works (`hook_layout_alter`)

`layout_options_ui_layout_alter(array &$definitions)` runs during layout discovery:

```php
foreach ($definitions as $key => $definition) {
  $providerKey = "{$definition->getProvider()}__{$key}";
  if (($settings[$providerKey] ?? 0) == 1) {
    $definitions[$key]->setClass('\Drupal\layout_options\Plugin\Layout\LayoutOptions');
  }
}
```

So after enabling an override and clearing caches,
`plugin.manager.core.layout`'s definition for that layout reports class
`Drupal\layout_options\Plugin\Layout\LayoutOptions` instead of the core
`Drupal\Core\Layout\LayoutDefault`. That is the signal the override is active.
