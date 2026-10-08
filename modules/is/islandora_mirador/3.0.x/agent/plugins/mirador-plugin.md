# IslandoraMiradorPlugin plugin type

The module defines one plugin type used to inject configuration into Mirador's per-window config array.
It does NOT add JS plugins — the actual Mirador plugin code must be compiled into the Mirador build; these
Drupal plugins only toggle/populate the `window` config that build reads.

## Discovery

- Manager service: `plugin.manager.islandora_mirador` (`IslandoraMiradorPluginManager`, extends `default_plugin_manager`).
- Namespace scanned: `Plugin/IslandoraMiradorPlugin` in any module.
- Annotation: `@IslandoraMiradorPlugin(id, label, description)` (`src/Annotation/IslandoraMiradorPlugin.php`).
- Interface: `IslandoraMiradorPluginInterface` — `label()` and `windowConfigAlter(array &$windowConfig)`.
- Base class: `IslandoraMiradorPluginPluginBase`.
- Alter hook: `hook_islandora_mirador_info_alter()`; cache key `islandora_mirador_plugins`.

Every defined plugin is instantiated on every viewer render (`template_preprocess_mirador`) and its
`windowConfigAlter()` is called with the merged window config, so each plugin must self-check whether it is
enabled (they read `islandora_mirador.settings:mirador_enabled_plugins`).

## Shipped plugins

| id | Label | windowConfigAlter effect (when its checkbox is on) |
|---|---|---|
| `miradorImageToolsPlugin` | Mirador Image Tools | sets `imageToolsEnabled` and `imageToolsOpen` = TRUE |
| `textOverlayPlugin` | Text Overlay | sets `textOverlay => {enabled, selectable = TRUE, visible = FALSE}` |

## Implementing one

```php
namespace Drupal\my_module\Plugin\IslandoraMiradorPlugin;

use Drupal\islandora_mirador\IslandoraMiradorPluginPluginBase;

/**
 * @IslandoraMiradorPlugin(
 *   id = "myPlugin",
 *   label = @Translation("My plugin"),
 *   description = @Translation("Injects my Mirador window options.")
 * )
 */
class MyPlugin extends IslandoraMiradorPluginPluginBase {
  public function windowConfigAlter(array &$windowConfig) {
    // Optionally gate on config: islandora_mirador.settings:mirador_enabled_plugins.
    $windowConfig['myOption'] = TRUE;
  }
}
```

For the plugin to be selectable in the settings form its id must also appear as a checkbox — the form lists all
defined plugins, so simply defining the plugin adds it. To make it actually do something in the browser, the
corresponding Mirador JS plugin must be present in the compiled Mirador build being served (see the README's
"Developing Custom Plugins"). Modifying plugin config through the UI beyond the enable checkbox is not implemented.
