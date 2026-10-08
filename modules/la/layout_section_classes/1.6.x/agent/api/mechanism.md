<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: the layout-class swap, storage, and rendering

The whole module is one hook + one class (`src/ClassyLayout.php`). No services or schema.

## The swap — `hook_layout_alter()`

```php
foreach ($definitions as &$definition) {
  if ($definition->get('class') === LayoutDefault::class && $definition->get('classes') !== NULL) {
    $definition->setClass(ClassyLayout::class);
  }
}
```

So a layout is upgraded **iff** it still uses core `LayoutDefault` *and* declares a `classes:`
key. Layouts with a custom class, or without `classes:`, are untouched. Check whether a layout
got upgraded:

```php
$m = \Drupal::service('plugin.manager.core.layout');
$def = $m->getDefinition('my_layout');
$isClassy = get_class($m->createInstance('my_layout', [])) === 'Drupal\\layout_section_classes\\ClassyLayout';
$hasClasses = $def->get('classes') !== NULL;
```

## The config form — `ClassyLayout::buildConfigurationForm()`

For each group under the definition's `classes`, builds a `select`:
`#multiple` = group `multiple`, `#options` = group `options`, `#required` = group `required`,
`#default_value` = existing config or group `default`. Throws
`'The "options" key is required for layout class definitions.'` if a group has no `options`.
`submitConfigurationForm()` stores the values at
`$this->configuration['additional']['classes']` (i.e. `additional.classes.<group>`).

## Where selections live

Inside the Layout Builder **section** configuration (the layout plugin config of that section),
under `additional.classes`. For a section stored on an `entity_view_display`
(`third_party_settings.layout_builder.sections`), read it via the `Section` object:

```php
$section->getLayoutSettings()['additional']['classes']['style'] ?? NULL;   // the chosen class
```

Set it the same way and re-save the display (or the entity for overrides).

## Rendering — `ClassyLayout::build()`

For each stored group value:
- a string class → pushed onto `$build['#attributes']['class']`;
- an array (multi-select) → merged in (empties filtered);
- if the group definition has `region_classes[<class>]`, those classes are pushed onto the named
  regions' `#attributes['class']`;
- if it has `attributes[<class>]`, those key/values are set on `$build['#attributes']`.

Net effect: the chosen option keys become CSS classes on the section wrapper (plus optional
region classes and section attributes), on top of whatever `LayoutDefault::build()` produced.
