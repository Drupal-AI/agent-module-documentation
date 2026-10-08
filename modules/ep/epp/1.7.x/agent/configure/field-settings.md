# Configure — per-field prepopulate settings

There is **no admin settings page** (`configure = null`). You configure epp on each individual
field.

## In the UI

1. Go to the field's settings: *Structure → Content types → [type] → Manage fields →* edit a field
   (or a base field override).
2. In the **Entity Prepopulate** fieldset:
   - **Value** — a textarea holding a YAML string that may contain tokens. For a simple scalar
     field just type the value/token; for multi-property fields use YAML keys (see below).
   - **Also on update** — check to reapply the value on edit, not only on create.
   - If the Token module is enabled, a **token browser** link is shown here.
3. Save the field. If both Value and "Also on update" are left empty, the settings are removed.

## Where it is stored

On the field config entity `field.field.<entity_type>.<bundle>.<field_name>`:

```yaml
third_party_settings:
  epp:
    value: "Prefilled by EPP"     # YAML string, tokens allowed
    on_update: false               # true = also apply on update
```

## Read / set via drush

Read:

```bash
drush config:get field.field.node.article.field_epp_known third_party_settings.epp
```

Set programmatically:

```php
use Drupal\field\Entity\FieldConfig;

$fc = FieldConfig::loadByName('node', 'article', 'field_epp_known');
$fc->setThirdPartySetting('epp', 'value', "Prefilled by EPP");
$fc->setThirdPartySetting('epp', 'on_update', TRUE);
$fc->save();
```

Remove the setting:

```php
$fc->unsetThirdPartySetting('epp', 'value');
$fc->unsetThirdPartySetting('epp', 'on_update');
$fc->save();
```

## YAML value examples

- Scalar (title/string): `The current date is [current-date:custom:Y-m-d]`
- Text field with format:
  ```yaml
  value: "Hello [current-user:display-name]"
  format: basic_html
  ```
- Multi-property fields (geofield, link, address) — use the property keys the field expects.

The value only takes effect when **all** tokens in it resolve; see
[api/mechanism.md](../api/mechanism.md).
