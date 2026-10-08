# The `telephone_plus_field` field — type, widget, formatters, Feeds

One field type with six stored properties, one widget, one active formatter (plus two deprecated),
and a Feeds target. No config schema ships, so the field/formatter settings below are stored but not
schema-validated.

## Field type — `telephone_plus_field`

`Plugin/Field/FieldType/TelephonePlusField.php`. Stored properties (`propertyDefinitions`):

| Property | Type | Required | Notes |
|---|---|---|---|
| `telephone_title` | string | no | e.g. "Customer services". Column exists only if `title_enabled`. |
| `country_code` | string | **yes** | 2-letter ISO-3166 alpha-2, `varchar(2)`. |
| `telephone_number` | string | **yes** | `varchar(60)`. Emptiness of this decides `isEmpty()`. |
| `telephone_extension` | string | no | `varchar(20)`. |
| `telephone_supplementary` | string | no | Column exists only if `supplementary_enabled`. |
| `display_international_number` | boolean | **yes** | `int tinyint unsigned default 0`. |

**Conditional schema** (`schema()`, `TelephonePlusField.php:97`): `telephone_title` (`varchar 255`)
and `telephone_supplementary` (`varchar 255`) columns are **added only when** the corresponding
storage setting is enabled. Enabling `title_enabled`/`supplementary_enabled` after data exists is a
schema change.

**Storage settings** (`defaultStorageSettings` / `storageSettingsForm`) — set on the field-storage
form:

| Key | Default | Effect |
|---|---|---|
| `title_enabled` | `FALSE` | Adds the title column + widget textfield. |
| `supplementary_enabled` | `FALSE` | Adds the supplementary column + widget textfield. |

**Field settings** (`defaultFieldSettings` / `fieldSettingsForm`) — set on the per-bundle field form:

| Key | Default | Effect |
|---|---|---|
| `default_country_code` | `NULL` (form-required) | Country pre-selected / hidden default. Options from `CountryManager::getStandardList()`. |
| `country_code_enabled` | `FALSE` | If TRUE, editors get a country `select`; if FALSE the country is a hidden field pinned to `default_country_code`. |

## Widget — `telephone_plus_widget`

`Plugin/Field/FieldWidget/TelephonePlusWidget.php`. Renders sub-elements inside a
`telephone_container` (`container-inline`): optional title, country (hidden or `select` per
`country_code_enabled`; always hidden on the default-value widget), a `#type => tel` number field,
extension, optional supplementary, and a `display_international_number` checkbox. `massageFormValues`
flattens `telephone_container` back onto the item and drops rows with an empty number.

**Validation** (`validateTelephoneNumber`, added via `#element_validate`, `TelephonePlusWidget.php:145`):
when the number is non-empty it builds `new TelephonePlusValidator($number, $extension, $country_code)`
and, if `!isValid()`, calls `$form_state->setErrorByName(... 'Invalid telephone number.')`. There is
**no custom regex** — validity is entirely whether `libphonenumber\PhoneNumberUtil::parse()` throws
`NumberParseException` (see `TelephonePlusValidator::isValid`). The extension is appended as
`"$number#$extension"` before parsing.

## Formatters

| Formatter id | Class | Status | Settings (defaults) |
|---|---|---|---|
| `telephone_plus` | `TelephonePlusFieldFormatter` | **active / default** | `link` (`TRUE`), `vcard` (`TRUE`) |
| `telephone_plus_link` | `TelephonePlusLinkFormatter` | `@deprecated` 2.x (link always on) | `vcard` (`TRUE`) |
| `telephone_plus_plain` | `TelephonePlusPlainFormatter` | `@deprecated` 2.x (never a link) | none |

All three `viewElements()` do the same thing: build a `TelephonePlusValidator`; if the number is
**invalid**, fall back to the **raw stored `telephone_number`** as text with an empty link; if valid,
build a `TelephonePlusFormatter` and set the display text from `->text($item->display_international_number)`
(national vs international) and, when linking, the href from `->url()`. Each item is an
`#theme => 'telephone_plus_item'` element with `#title/#number/#url/#extension/#supplementary/#vcard`.

**`tel:` link generation** (`TelephonePlusFormatter::url`, `TelephonePlusFormatter.php:75`): the href
is **not** the raw input — it is `PhoneNumberUtil::format($parsed, PhoneNumberFormat::RFC3966)`, e.g.
input `020 7946 0018` ext `123` (GB) → `tel:+44-20-7946-0018;ext=123`. The display text uses
`INTERNATIONAL` or `NATIONAL` format (e.g. `020 7946 0018 x123`). Rendering goes through the Twig
template, so `url`, `number`, `title` and `supplementary` are all auto-escaped in their contexts.

`hook_preprocess_field` (in `.module`) adds `p-tel h-card` classes to items whose `#vcard` is TRUE;
the deprecated formatters additionally attach the microformats `hcard` profile `html_head_link` when
`vcard` is on.

### Set the formatter from code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_phone', [
    'type' => 'telephone_plus',
    'settings' => ['link' => TRUE, 'vcard' => TRUE],
  ])->save();
```

### Migrating the deprecated formatters

`telephone_plus_update_8001` (in `telephone_plus.install`) rewrites any `node` view-display
component still using `telephone_plus_link` → `{type: telephone_plus, settings: {link: TRUE, vcard:
<old vcard>}}` and `telephone_plus_plain` → `{type: telephone_plus, settings: {link: FALSE, vcard:
FALSE}}`. It only walks `node` bundles; components on other entity types must be switched manually.

## Feeds target — `telephone_plus`

`Feeds/Target/TelephonePlus.php` (only compiled/used when the contrib **Feeds** module is present).
`@FeedsTarget(id = "telephone_plus", field_types = {"telephone_plus_field"})` exposes all six
properties as mappable sub-targets; `prepareValue` coerces an empty `display_international_number` to
`FALSE`. No parsing/validation happens on import — values are written as supplied, so a Feeds-imported
number that `libphonenumber` cannot parse will fall back to plain text on display.
