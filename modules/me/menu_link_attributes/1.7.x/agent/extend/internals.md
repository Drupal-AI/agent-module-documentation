# Internals / how it works

All logic lives in `menu_link_attributes.module` (no services or plugins). Useful when
customizing behavior or reading/writing attributes in code.

**Form injection** — `hook_form_menu_link_content_form_alter()`:
- Reads defined attributes from `menu_link_attributes.config` (`attributes`).
- Builds `$form['options']['attributes']` (a `#tree` details element), one form element per
  defined attribute, element type from `type` (or `select` if `options` set, else `textfield`).
- Defaults each field from the link's existing `options['attributes'|'container_attributes']`.
- Registers an entity builder `menu_link_attributes_menu_link_content_form_entity_builder`.

**Saving** — the entity builder:
- Requires `use menu link attributes`; otherwise re-applies the previously stored options.
- `class`/`container_class` are coerced to arrays; empty values are stripped (not saved).
- Attributes detected as container attributes (see below) are moved to a
  `container_attributes` group.
- Merges results into `$menu_link->link->first()->options` via
  `NestedArray::mergeDeepArray()`, and mirrors them onto other translations unless the link is
  "default-translation-affected only".

**Container detection** — `menu_link_attributes_is_container_attribute($name)`: true when the
name starts with `container_` (unless `container: false`) or the definition sets
`container: true`.

**Rendering** — `hook_preprocess_menu()` →
`_menu_link_attributes_preprocess_menu_items()` recurses menu items and copies each link's
`options['container_attributes']` onto the item's `<li>` `$item['attributes']`. Link-level
`attributes` render automatically through core's link theming.

**To set attributes programmatically**, write into the menu link's `link` field options:
```php
$options = $menu_link->link->first()->options ?: [];
$options['attributes']['class'] = ['btn', 'btn-primary'];      // on <a>
$options['container_attributes']['class'] = ['is-cta'];        // on <li>
$menu_link->link->first()->options = $options;
$menu_link->save();
```
