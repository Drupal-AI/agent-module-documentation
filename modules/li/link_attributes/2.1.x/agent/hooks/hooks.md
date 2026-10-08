# Hooks

Declared in `link_attributes.api.php`.

## `hook_link_attributes_plugin_alter(array &$plugins)`
Alter the discovered link-attribute plugin definitions (from the `*.link_attributes.yml`
files). Add, remove or tweak attributes and their form elements.

```php
function my_module_link_attributes_plugin_alter(array &$plugins) {
  // Default the target attribute to open in a new window.
  $plugins['target']['default_value'] = '_blank';

  // Remove an attribute you don't want editors to set.
  unset($plugins['accesskey']);

  // Add options / change the element type.
  $plugins['rel']['type'] = 'select';
  $plugins['rel']['options'] = ['' => 'None', 'nofollow' => 'nofollow'];
}
```

`$plugins` is keyed by attribute id; each value is the definition array documented in
[plugins/link-attributes.md](../plugins/link-attributes.md). The alter id is
`link_attributes_plugin` (set via `$this->alterInfo()` in `LinkAttributesManager`).
