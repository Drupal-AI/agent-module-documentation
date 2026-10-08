# Selector plugin types

Image Effects defines three plugin types so effect config forms have consistent, swappable
Color / Image / Font pickers. Each has a manager service and an attribute.

| Plugin type | Manager | Attribute | Plugin dir |
|---|---|---|---|
| Color selector | `Drupal\image_effects\Plugin\ColorSelectorPluginManager` | `Plugin\Attribute\ColorSelector` | `src/Plugin/image_effects/ColorSelector/` (e.g. `HtmlColor`, `Basic`) |
| Image selector | `Drupal\image_effects\Plugin\ImageSelectorPluginManager` | `Plugin\Attribute\ImageSelector` | `src/Plugin/image_effects/ImageSelector/` (e.g. `Basic`, `Dropdown`) |
| Font selector | `Drupal\image_effects\Plugin\FontSelectorPluginManager` | `Plugin\Attribute\FontSelector` | `src/Plugin/image_effects/FontSelector/` (e.g. `Basic`, `Dropdown`) |

(Base attribute: `Plugin\Attribute\ImageEffectsBase`. Legacy service aliases
`plugin.manager.image_effects.*_selector` are deprecated — use the manager class id.)

## Add a selector plugin
1. Create a class under `src/Plugin/image_effects/<Type>Selector/` in your module.
2. Annotate it with the matching attribute, e.g.:
   ```php
   #[ColorSelector(id: 'my_picker', title: new TranslatableMarkup('My picker'))]
   class MyPicker extends ColorSelectorPluginBase { /* getForm(), getValue() ... */ }
   ```
3. It becomes selectable on the module settings form (see
   [../configure/settings.md](../configure/settings.md)).

The active selector is instantiated by the manager using the `plugin_id` stored in
`image_effects.settings`.
