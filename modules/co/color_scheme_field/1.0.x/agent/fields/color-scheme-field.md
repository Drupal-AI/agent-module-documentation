<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Color Scheme field type, widget & theming integration

## Field type — `color_scheme_field`

`src/Plugin/Field/FieldType/ColorSchemeItem.php` (`@FieldType`, extends `FieldItemBase`):

- `id = color_scheme_field`, label `Color Scheme`, description "Stores a color scheme name."
- `default_widget = color_scheme_field_widget`, `default_formatter = NULL`.
- **Storage** (`schema()`): one column `name` — `type: varchar`, `length: 255`; plus an index
  named `format` over `['name']`.
- **Property** (`propertyDefinitions()`): `name` — a `string` `DataDefinition`, label "Color Scheme".

The stored value is the theme's scheme **key** (machine name), not any color data. Access the raw
value with `$entity->get($field_name)->name` or `->getValue()[0]['name']`.

## Widget — `color_scheme_field_widget`

`src/Plugin/Field/FieldWidget/ColorSchemeWidget.php` (`@FieldWidget`, extends `WidgetBase`):

- Injected services (`create()`): `theme_handler` (`ThemeHandler`) and `extension.list.theme`
  (`ThemeExtensionList`).
- `formElement()` renders one child element `name`:
  - `#type => 'select'`, `#title => t('Color scheme')`, `#options => getColorSchemeOptions()`,
    `#default_value => $items[$delta]->name ?? NULL`, `#required` inherited from the element,
    `#empty_value => ''` (so the "none" choice stores an empty string).
- `getColorSchemeOptions()`: reads the **default** theme
  (`themeHandler->getDefault()` → `themeExtensionList->getExtensionInfo($theme)['color_scheme']`)
  and returns it filtered with `array_filter(..., ARRAY_FILTER_USE_BOTH)` keeping only entries whose
  **key and label are both non-empty strings**. If the theme declares nothing, options are empty.

Only the **default** theme's `color_scheme` is used — options are not per-bundle or per-active-theme
configurable, and the field type/widget expose no widget settings form.

## Theming integration — `hook_entity_view`

`color_scheme_field.module` → `color_scheme_field_entity_view(&$build, EntityInterface $entity)`:

- Iterates the entity's field definitions, skips any whose type is not `color_scheme_field`.
- Takes the first matching field, reads `$entity->get($field_name)->name`.
- If empty, continues; otherwise sets `$build['#color_scheme_field'] = $name` and `break`s.

So at most **one** scheme name is surfaced per entity view, under the render-array key
`#color_scheme_field`. The module does not print it — a theme's preprocess/template is expected to
turn it into a CSS class or select a scheme stylesheet. (Kernel test `testEntityBuild` confirms the
value appears in `$build` but not in the rendered HTML.)

## Requirements check — `hook_requirements`

`color_scheme_field.install` (runtime phase): reports OK when the default theme's info defines a
valid `color_scheme` map; `REQUIREMENT_ERROR` when it is missing, or when any entry has a
non-string/empty key or label.

## Add the field (Field UI)

1. Declare `color_scheme:` options in the default theme's `.info.yml`; clear caches.
2. Structure → (bundle) → **Manage fields** → Add field → **Color Scheme**.
3. Editing content shows the select of theme-declared schemes.
4. In the theme, read `#color_scheme_field` from the entity build and apply the matching palette.
