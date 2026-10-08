# ShareThis — the manager service

## Service: `sharethis.manager`

Class `Drupal\sharethis\SharethisManager` implements `SharethisManagerInterface`. Tagged
`sharethis_manager`. Constructor: `config.factory`, `title_resolver`, `current_route_match`,
`request_stack`, `entity_type.manager`, `module_handler`.

| Method | Purpose |
|---|---|
| `getOptions()` | Assemble the full options array from `sharethis.settings` (buttons, publisherID, services, widget, onhover, neworzero, twitter_*, late_load, view_modes, cns, node_types, shorten). This is the canonical read of the effective config. |
| `blockContents()` | Options + current page title/URL, ready for `renderSpans()` (used by the basic block). |
| `widgetContents(array $settings)` | Options + a configured path/URL (used by the widget block). |
| `renderSpans(array $data_options, $title, $path)` | Build the renderable button `<span>`s array (options + title + path); runs `hook_sharethis_render_alter()` per button. |
| `sharethisIncludeJs()` | Build the `drupalSettings.sharethis` JS config + light options. |
| `getShareThisLightOptions(array $data_options)` | Map settings to the `stLight` options object. |
| `toBoolean($val)` | Coerce a config value to bool. |

## Typical programmatic use

```php
$manager = \Drupal::service('sharethis.manager');
$options = $manager->getOptions();
$build = $manager->renderSpans($options, $node->getTitle(), $node->toUrl()->setAbsolute()->toString());
$build['#attached']['library'][] = 'sharethis/sharethis';
```

`getOptions()` is the reliable way to read what ShareThis will actually emit (it resolves every
`sharethis.settings` key with defaults), rather than reading raw config yourself.

## External dependency

`renderSpans()` output relies on ShareThis's hosted scripts, attached via libraries
`sharethis/sharethispickerexternalbuttonsws`, `sharethis/sharethispickerexternalbuttons`,
`sharethis/sharethis` (the picker libraries load `https://ws.sharethis.com/...`). This module is
a wrapper around that external service; the buttons do not function without network access to
`sharethis.com`.
