# Configure block attributes

Two steps: define available attributes globally, then set values per block.

## 1. Define attributes (global)

Settings form `ConfigForm` at `/admin/structure/block/attributes` (route
`block_attributes.config`, requirement `_permission: 'access administration pages'`). It edits the
whole `block_attributes.config` object as raw **YAML** in a textarea (suggests the `yaml_editor`
module). Shape:

```yaml
attributes:
  class:                 # attribute (machine) name = the HTML attribute rendered
    label: 'CSS class'   # optional; falls back to ucfirst(name)
    description: ''       # optional; help text on the per-block field
  data-track:
    label: 'Tracking id'
    options:             # optional; presence turns the per-block input into a <select>
      promo: Promo
      hero: Hero
```

Default `config/install/block_attributes.config.yml` ships only `class`. There is **no config
schema** for this object. `validateForm` YAML-decodes the text and rejects any attribute name for
which `BlockAttributesChecker::isAttributeAllowed()` returns FALSE.

## 2. Set values per block

`block_attributes_form_block_form_alter` adds an "Attributes" details group to every block config
form (`/admin/structure/block/...` or the block's Configure form; needs `administer blocks`). Each
defined attribute becomes a textfield (or a select when it has `options`). On submit,
`block_attributes_form_block_form_submit` stores the values in the block entity's
`settings.attributes`.

## 3. Render

`block_attributes_preprocess_block` reads `configuration.attributes` and, for each name that
passes `isAttributeAllowed()`, merges the value into `$variables['attributes'][$name]`. A
space-separated value is split into multiple values (e.g. multiple classes). Output goes through
core's `Drupal\Core\Template\Attribute` renderer, which `Html::escape()`s both attribute names and
values.

## Allowed-attribute check

`BlockAttributesChecker::isAttributeAllowed($name)`:

```php
$clean_key = strtolower(trim($attribute));
return !preg_match('/^on[a-z]+$/', $clean_key);   // blocks onclick, onmouseover, ...
```
