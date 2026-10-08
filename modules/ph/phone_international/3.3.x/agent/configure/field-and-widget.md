# Configure International Phone

## Field type

`phone_international` — stores a single `varchar(256)` value. Default widget
`phone_international_widget`, default formatter `phone_international_formatter`.
On `preSave()` the value is reformatted to **E.164** by the `phone_international.validate`
service (invalid input is logged and stored as-is).

## Widget settings (`phone_international_widget`)

Configured per field on *Manage form display*. Schema key
`field.widget.settings.phone_international_widget`.

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `geolocation` | boolean | `false` | Auto-detect the visitor's country (overrides `initial_country`). |
| `initial_country` | string (ISO 3166-1 alpha-2) | `PT` | Preselected country when geolocation is off. |
| `preferred_countries` | array | `['PT']` | Countries pinned to the top of the list. |
| `countries` | `all`\|`exclude`\|`include` | `exclude` | How to treat `exclude_countries`. |
| `exclude_countries` | array | `[]` | The countries to exclude (mode `exclude`) or the only ones allowed (mode `include`). |

## Formatter (`phone_international_formatter`)

Renders each valid number as a `tel:` link (`Url::fromUri('tel:'.rawurlencode($number))`);
numbers that fail validation are output as plain (escaped) text. Same settings schema exists
(`field.formatter.settings.phone_international_formatter`) but the default formatter uses the
stored value directly.

## Global setting

Config object `phone_international.settings`, single key:

| Key | Type | Meaning |
|---|---|---|
| `cdn` | boolean | Load the intl-tel-input assets from a CDN (`true`) instead of a local `libraries/` copy (`false`). |

Settings form: route `phone_international.settings` → `/admin/config/phone_international`
(permission `administer site configuration`).

```php
\Drupal::configFactory()->getEditable('phone_international.settings')->set('cdn', TRUE)->save();
```

## Creating the field in code

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;
FieldStorageConfig::create(['field_name'=>'field_phone','entity_type'=>'node','type'=>'phone_international'])->save();
FieldConfig::create(['field_name'=>'field_phone','entity_type'=>'node','bundle'=>'article','label'=>'Phone'])->save();
// widget with default country GB:
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_phone', [
  'type' => 'phone_international_widget',
  'settings' => ['initial_country'=>'GB','geolocation'=>FALSE,'countries'=>'all','preferred_countries'=>['GB'],'exclude_countries'=>[]],
])->save();
```
