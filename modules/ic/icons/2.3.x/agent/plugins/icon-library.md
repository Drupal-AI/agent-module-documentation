<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IconLibrary plugin type

The module defines one plugin type: **IconLibrary**. A plugin adapts a concrete icon library
(a webfont / CSS icon set) to the module — it declares its config form, reads/produces the icon
list, and builds the CSS classes used to render each icon.

| Piece | Value |
|---|---|
| Manager service | `plugin.manager.icon_library` (class `Drupal\icons\IconLibraryPluginManager`) |
| Discovery dir | `Plugin/IconLibrary` (in any module) |
| Attribute | `Drupal\icons\Attribute\IconLibrary` (`id`, `label`, `description`, `deriver`) |
| Interface | `Drupal\icons\IconLibraryPluginInterface` |
| Base classes | `IconLibraryPluginBase`, `IconLibraryPluginJsonBase` |
| Alter hook | `hook_icon_library_alter(&$definitions)` |
| Cache | bin `default`, key `icon_set_libraries` |

Bundled plugins (each in a submodule): `fontawesome` (`icons_fontawesome`), `fontello`
(`icons_fontello`), `icomoon` (`icons_icomoon`). `IconLibraryPluginManager::getOptions()` returns
`id => label` for the icon-set add form.

## Interface (key methods)

- `label(): string`, `description(): string`
- `getIcons(): array` — the icons this instance offers, keyed by icon name (value = human title).
- `build(array $element, ConfigEntityInterface $entity, $name): array` — mutates the `icon` render
  element: adds the icon's CSS class(es) to `#attributes['class']` and attaches the per-set library.
  **This is the render contract** — output is class-based; no markup/SVG is injected.
- Configurable/PluginForm surface: `getConfiguration()/setConfiguration()/setConfigurationValue()`,
  `iconLibraryForm()`, `iconLibraryValidate()`, `iconLibrarySubmit()` (wrapped by
  `buildConfigurationForm/validateConfigurationForm/submitConfigurationForm`).
- `getMachineNameSuggestion()` — transliterated suggestion from the label.

## `IconLibraryPluginBase`

Abstract base implementing `IconLibraryPluginInterface`, `PluginWithFormsInterface`,
`ContextAwarePluginInterface`. Provides default config merge, an `access()` /
`iconLibraryAccess()` hook (default `AccessResult::allowed()`), the generic config form
(title + description + `iconLibraryForm()`), and the machine-name suggestion. Override
`defaultConfiguration()`, `getIcons()`, `build()`, and the `iconLibrary*` form hooks.

## `IconLibraryPluginJsonBase`

Base for providers whose icon list comes from a JSON metadata file inside a local library folder
(the bundled three extend it). Adds a required **`library_path`** textfield and validates, on submit,
that the folder + a JSON file + a CSS file exist under `DRUPAL_ROOT . '/' . library_path`, then calls
the abstract `processJson()` to cache the icon list into settings. Helpers: `getLibraryPath()`,
`getLibraryPublicPath()` (`'/'.path`), `getLibraryRealPath()` (`DRUPAL_ROOT.'/'.publicPath`).
Abstract methods a JSON provider must implement: `validateLibraryPath()`, `validateLibraryJson()`,
`validateLibraryCss()`, `processJson()`.

## Add your own provider

```php
// src/Plugin/IconLibrary/MyLib.php in your module
#[\Drupal\icons\Attribute\IconLibrary(
  id: 'mylib',
  label: new TranslatableMarkup('My Library'),
  description: new TranslatableMarkup('My icons.'),
)]
class MyLib extends \Drupal\icons\IconLibraryPluginBase {
  public function defaultConfiguration(): array { return ['icons' => []]; }
  public function getIcons(): array { return ['home' => 'Home', 'star' => 'Star']; }
  public function build(array $element, ConfigEntityInterface $entity, $name): array {
    $element['#attributes']['class'][] = 'myicon-' . $name;   // class-based, escaped by Attribute
    $element['#attached']['library'][] = 'mymodule/myicons';  // load your webfont CSS
    return $element;
  }
}
```

Extend `IconLibraryPluginJsonBase` instead if the icon list should be read from a JSON file at an
admin-supplied library path.
