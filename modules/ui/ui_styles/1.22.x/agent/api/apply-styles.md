<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apply and query styles in code

## The style plugin manager

Service `plugin.manager.ui_styles` → `Drupal\ui_styles\StylePluginManager`
(`StylePluginManagerInterface`). Definitions are `StyleDefinition` objects.

```php
$manager = \Drupal::service('plugin.manager.ui_styles');
$manager->getDefinitions();                  // all enabled StyleDefinition[]
$manager->getDefinition('text_color');       // one StyleDefinition (or NULL)
$manager->hasDefinition('text_color');
$manager->getCategories();                   // distinct category labels (natcasesort)
$manager->getSortedDefinitions();            // by weight, then category, then label, then id
$manager->getGroupedDefinitions();           // [category => [id => StyleDefinition]]
$manager->getDefinitionsForTheme('olivero'); // grouped, filtered to modules + this theme + its base themes
```

`StyleDefinition` getters: `id()`, `getLabel()`, `getDescription()`, `getCategory()`,
`hasCategory()`, `getOptions()` (class => label|meta), `getOptionsAsOptions()` (class =>
label), `getWeight()`, `isEnabled()`, `getProvider()`, `getLinks()` / `getRenderLinks()`,
`getPreviewedAs()`, `getPreviewedWith()`, `getIcon()`, `getAdditional()`, `toArray()`.

## Add classes to a render array

```php
// $selected: ['style_id' => 'chosen-class', ...]   $extra: 'free classes'
$build = $manager->addClasses($build, $selected, $extra);
```

`addClasses()` merges `$selected` values + space-split `$extra` (`array_unique` +
`array_filter`), then `addClassesToAcceptingOrWrap()` drills into the render tree: it skips
"meaningless wrappers" (`#theme` of `block` / `layout` / `view` that still have content),
finds the first element(s) that accept `#attributes`, and adds the classes there via
`AttributeHelper::mergeCollections`, wrapping the element in a `div` html_tag only if nothing
accepts attributes. Image/responsive-image formatters use `#item_attributes` instead
(`getElementAttributesProperty()` + `THEME_WITH_ITEM_ATTRIBUTES`; a `DeprecationHelper` call
switches `#item_attributes` → `#attributes` from core 11.4).

Attribute acceptance is decided by `Drupal\ui_styles\Render\Element`
(`isAcceptingAttributes()`): known `#type` lists (`$typeWithAttributes`,
`$typeWithoutAttributes`), `#theme` templates (`$themeWithAttributes` = `block`, `layout`),
or a theme-registry `variables` check; otherwise the element's `#pre_render` is run and
re-checked.

## The `ui_styles_styles` form element

`Drupal\ui_styles\Element\Styles` (`#type => 'ui_styles_styles'`). Use it to let a user pick
styles; its submitted value is the `{ selected, extra }` mapping.

```php
$form['styles'] = [
  '#type' => 'ui_styles_styles',
  '#title' => $this->t('Styles'),
  '#default_value' => ['selected' => $selected, 'extra' => $extra],
  // Optional:
  '#wrapper_type' => 'details',   // default 'details'; e.g. 'container'
  '#open' => FALSE,
  '#drupal_theme' => 'olivero',   // limit to styles available for this theme
];
```

Read the value back: `$form_state->getValue('styles')` → `['selected' => [...], 'extra' => '...']`.
(The deprecated `StylePluginManager::alterForm()` predates this element and is removed in 2.0.)

## Alter discovered styles

```php
// my_module.module (or a #[Hook('ui_styles_styles_alter')] method)
function my_module_ui_styles_styles_alter(array &$definitions): void {
  // $definitions: [id => \Drupal\ui_styles\Definition\StyleDefinition]
  unset($definitions['text_color']);                 // remove a style
  $definitions['spacing']->setWeight(-10);           // re-order
}
```

## Utility

`Drupal\ui_styles\UiStylesUtility::extractSelectedStyles()` converts raw
`ui_styles_<id>` form values into the `selected` map (used by the UI Patterns source for
backward compatibility with the old `_ui_styles_extra` config shape).
