# Configure International Phone

## Field type

`phone_international` — stores a single `varchar(256)` value (property `value`, required).
Default widget `phone_international_widget`, default formatter `phone_international_formatter`.
On `preSave()` the value is reformatted to **E.164** by the `phone_international.validate`
service (invalid input is logged and stored as-is). (The config schema also declares a
`field.value.phone_international` mapping with `number`/`country_code`/`dial_code` sub-values,
but the shipped field type persists only the single `value` column.)

## Widget settings (`phone_international_widget`)

Configured per field on *Manage form display*. Schema key
`field.widget.settings.phone_international_widget` (type `phone_international.base_settings`).

| Setting | Type | Default | Meaning |
|---|---|---|---|
| `auto_placeholder` | `off`\|`aggressive`\|`polite` | `aggressive` | Show an example number for the selected country as the placeholder, updating on country change. |
| `national_number` | boolean | `true` | Use national-number display mode (intl-tel-input `nationalMode`). |
| `geolocation` | boolean | `false` | Auto-detect the visitor's country (via `ipinfo.io`); overrides `initial_country`. |
| `dial_code` | boolean | `false` | Display the country dial code separately, next to the flag (`separateDialCode`). |
| `initial_country` | string (ISO 3166-1 alpha-2) | `PT` | Preselected country when geolocation is off. |
| `preferred_countries` | array | `['PT']` | Countries pinned to the top of the list. |
| `countries` | `all`\|`exclude`\|`include` | `exclude` | How to treat `exclude_countries`. |
| `exclude_countries` | array | `[]` | Countries to exclude (mode `exclude`) or the only ones allowed (mode `include`). |

`auto_placeholder`, `national_number`, and `dial_code` are new in 4.0.

## Formatters

- **`phone_international_formatter`** ("Phone default formatter") — renders each valid number
  as a `tel:` link (`Url::fromUri('tel:'.rawurlencode($number))`, opened as external); numbers
  that fail validation are output as plain, HTML-escaped text (`nl2br(Html::escape())`). Uses
  the `phone_international.validate` service to decide valid vs invalid.
- **`phone_international_basic_string`** ("Plain text") — subclasses core `BasicStringFormatter`;
  outputs the stored value as plain text.

Both share the `phone_international.base_settings` schema
(`field.formatter.settings.phone_international_formatter`) but the defaults use the stored value directly.

## Global setting

Config object `phone_international.settings`, single key:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `cdn` | boolean | `false` | Load the intl-tel-input assets from the jsDelivr CDN (`true`, `//cdn.jsdelivr.net/npm/intl-tel-input/build`) instead of a local `libraries/intl-tel-input` copy (`false`). |

Settings form: route `phone_international.settings` → `/admin/config/phone_international`
(permission `administer site configuration`). `hook_library_info_alter` swaps in the local
JS/CSS paths when `cdn` is false.

```php
\Drupal::configFactory()->getEditable('phone_international.settings')->set('cdn', TRUE)->save();
```

## Library requirement check

`hook_runtime_requirements` (class `PhoneInternationalHooks`) reports on the status page whether
the local `intl-tel-input` library is present and at least **v25.3** (reads its `package.json`);
missing or older versions raise an error/warning. Irrelevant when `cdn` is on.

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
  'settings' => ['initial_country'=>'GB','geolocation'=>FALSE,'countries'=>'all','preferred_countries'=>['GB'],'exclude_countries'=>[],'dial_code'=>FALSE,'national_number'=>TRUE,'auto_placeholder'=>'aggressive'],
])->save();
```
