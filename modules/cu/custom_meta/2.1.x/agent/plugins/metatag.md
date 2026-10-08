# How Custom Meta turns config into Metatag plugins

Custom Meta does not define a new plugin *type*. It plugs into Metatag's existing plugin types
(`MetatagTag`, `MetatagGroup`) and uses plugin **derivers** to generate one tag plugin per user-defined
definition.

## The pieces (`src/Plugin/metatag/...`, `src/Plugin/Derivative/...`)

| Class | Metatag plugin | Role |
|---|---|---|
| `Plugin/metatag/Group/Custom` | `@MetatagGroup(id="custom_meta")` | The "Custom Metatags" group all custom tags fall under. |
| `Plugin/metatag/Tag/CustomMetaTagName` | `@MetatagTag(id="custom_meta_tag_name")` | Base tag for `attribute: name`; `deriver = CustomMetaDeriverName`. |
| `Plugin/metatag/Tag/CustomMetaTagProperty` | `@MetatagTag(id="custom_meta_tag_property")` | Base tag for `attribute: property`; deriver `CustomMetaDeriverProperty`. |
| `Plugin/metatag/Tag/CustomMetaTagHttpEquiv` | `@MetatagTag(id="custom_meta_tag_http_equiv")` | Base tag for `attribute: http-equiv`; deriver `CustomMetaDeriverHttpEquiv`. |
| `Plugin/Derivative/CustomMetaDeriver{Name,Property,HttpEquiv}` | — | Read `custom_meta.settings` and emit derivatives. |

The base tag annotations set `group = "custom_meta"`, `secure = FALSE`, `multiple = TRUE`, and (for
name/property/http-equiv) `type = "string"`.

## Deriver logic (e.g. `CustomMetaDeriverName::getDerivativeDefinitions`)

```php
$settings = \Drupal::config('custom_meta.settings');
$prefix   = $settings->get('prefix') ?? '';
foreach ($settings->get('tag') ?? [] as $id => $meta) {
  if ($meta['attribute'] == 'name') {          // each deriver filters by its attribute
    $d = $base_plugin_definition;
    $d['weight']++;
    $d['id']    = $id;
    $d['name']  = $prefix . $id;               // prefix applied here
    $d['label'] = t($meta['label']);
    $d['description'] = t($meta['description']);
    $this->derivatives[$id] = $d;
  }
}
```

So a definition `{attribute: property, name: og_x, ...}` produces the derivative
`custom_meta_tag_property:og_x`, rendered as `<meta property="{prefix}og_x" content="...">`.

## Output

`CustomMetaTagName::output()` (and the property/http-equiv variants) call the Metatag base `output()`
then **unset any element whose `content` attribute is empty**, so unfilled custom tags emit nothing.

## Adding definitions in code

There is no service API — write to the config object and rebuild plugin caches:

```php
$config = \Drupal::configFactory()->getEditable('custom_meta.settings');
$tags = $config->get('tag') ?? [];
$tags['my_tag'] = [
  'attribute' => 'name',      // name | property | http-equiv
  'name' => 'my_tag',
  'label' => 'My Tag',
  'description' => 'My custom meta tag',
];
$config->set('tag', $tags)->save();
\Drupal::service('plugin.manager.metatag.tag')->clearCachedDefinitions();
```
