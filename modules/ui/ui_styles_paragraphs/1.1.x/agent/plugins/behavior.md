<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ui_style_options` — Paragraphs behavior plugin

The module's entire surface. A single `@ParagraphsBehavior` plugin in
`src/Plugin/paragraphs/Behavior/UIStyleOptions.php` (`class UIStyleOptions extends
ParagraphsBehaviorBase`).

```
@ParagraphsBehavior(
  id = "ui_style_options",
  label = @Translation("UI Style Options"),
  description = @Translation("Integrates paragraphs with UI Styles module."),
  weight = 0
)
```

It is a plugin *of* Paragraphs' existing `ParagraphsBehavior` type (manager
`plugin.manager.paragraphs.behavior`) — this module does **not** define a new plugin type.

## Enable / configure (site builder)

Behaviors are turned on per paragraph type: `admin/structure/paragraphs_type/{type}/edit` →
"Behaviors" → tick **UI Style Options**. The configuration sub-form (`buildConfigurationForm()`,
`UIStyleOptions.php:134`) then lists every UI Style, grouped by its UI Styles *category*, each as a
`#type => 'checkbox'` whose `#return_value` is the style plugin id. Ticking a style makes it
available to contributors on that paragraph type.

- Grouping: `$this->stylePluginManager->getGroupedDefinitions()` drives the layout. If there is
  exactly one group the form is flat; otherwise each category becomes a `details` element. A group
  that already has an enabled style is rendered `#open`.
- Storage: `submitConfigurationForm()` (`:200`) writes the whole tree to
  `$this->configuration['enabled_styles']` — the behavior's persisted config for that paragraph
  type. `defaultConfiguration()` = `['enabled_styles' => []]`.
- The `enabled_styles` structure is nested by a category **group key**, which is a machine-name
  derived from the category label via `getMachineName()` (`:216`, transliterate → lowercase →
  `[^a-z0-9_.]` → `_`). Styles without a category sit at the top level.

## Apply values (contributor)

`buildBehaviorForm()` (`:79`) renders, on the paragraph add/edit form, one `#type => 'select'` per
*enabled* style, named **`ui_styles_<styleId>`**, with `#empty_option = "- None -"`, `#options` from
the definition's `getOptionsAsOptions()`, and `#weight` from the definition. Options that belong to
a category are wrapped in a matching `details` group. Selected values are read back through
`getFlattenedSettings()`.

`getEnabledStyles()` (`:236`) flattens `enabled_styles` (which may be one or two levels deep because
of grouping) into a plain list of enabled style ids, filtering out unchecked entries with
`NestedArray::filter()` + `array_filter()`.

## Render (`view()`)

`view()` (`:122`) runs when the paragraph is rendered:

```php
$classes = $this->getFlattenedSettings($paragraph);   // stored behavior settings, flattened
foreach ($classes as $key => $class) {
  if ($class) {
    $build['#attributes']['class'][] = $class;         // append CSS class to the paragraph wrapper
  }
}
```

`getFlattenedSettings()` (`:270`) reads `$paragraph->getBehaviorSetting($this->pluginId, [])` and
flattens the same nested-by-group shape into `styleId => classValue`. The class value is whatever
the UI Style option maps to (a CSS class string defined in the theme/module's UI Styles YAML); this
module adds nothing to it and does not sanitize it beyond the render system's normal attribute
handling. An empty/`- None -` selection is skipped.

## Injected services

`create()` (`:65`) injects, on top of `ParagraphsBehaviorBase`'s `entity_field.manager`:

- `plugin.manager.ui_styles` → `Drupal\ui_styles\StylePluginManager` (`$this->stylePluginManager`) —
  source of all style definitions; methods used: `getGroupedDefinitions()`, `getDefinition($id)`,
  and on each definition `id()`, `getLabel()`, `getCategory()`, `hasCategory()`, `getWeight()`,
  `getOptionsAsOptions()`.
- `transliteration` → `TransliterationInterface` (`$this->transliteration`) — used only by
  `getMachineName()` to build category group keys.

## Notes for agents

- There is no config schema shipped by this module, so the `enabled_styles` behavior config is
  stored without a dedicated schema definition; validation of the picked option relies on the
  select/checkbox `#options`/`#return_value` (a closed list from UI Styles).
- Clear caches (`drush cr`) after enabling UI Styles for a new theme so freshly declared styles
  appear in the checklist.
