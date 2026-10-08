<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Validation, render elements, services and integrations

## Constraint `valid_json`

`ValidJsonConstraint` (id `valid_json`) is attached to all three field types.
`ValidJsonConstraintValidator` skips empty values, otherwise calls
`\Drupal::service('serializer')->decode($value->value, 'json')` and, on exception, adds the
violation *"The supplied text is not valid JSON data (@error)."* with the decoder message.

It fires wherever entity validation runs (entity forms, `$entity->validate()`,
REST/JSON:API writes) — a bare `$entity->save()` in PHP does **not** validate.

```php
$node->set('field_payload', '{oops');
$violations = $node->validate();   // 1 violation on field_payload.0.value
```

## Render elements

| `#type` | Class | Output |
|---|---|---|
| `json_text` | `Drupal\json_field\Element\JsonText` | `<pre class="json-field"><code>@json</code></pre>` from `#text` |
| `json_pretty` | `Drupal\json_field\Element\JsonPretty` | `<div class="json-field-pretty">` + nested `<ul>`/`<dl>` from `#json` (a decoded value, not a string) |

Both are usable directly in any render array:

```php
$build['raw'] = ['#type' => 'json_text', '#text' => $node->field_payload->value];
$build['tree'] = ['#type' => 'json_pretty', '#json' => json_decode($node->field_payload->value)];
```

## Services

| Service | Class | Purpose |
|---|---|---|
| `json_field.views` | `JsonViews` | `getViewsFieldData(FieldStorageConfigInterface)` — builds the Views data, used by `json_field_field_views_data()` |
| `json_field.requirements` | `JsonFieldRequirements` | `libraryIsAvailable(bool $warning)`, `databaseIsCompatible()`, `getLibraryWarningMessage()`, `getDatabaseWarningMessage()` |
| `serializer.normalizer.json_item.native` | `JsonItemNormalizer` | normalizer (priority 20) for `NativeJsonItem`; emits the value unescaped in HAL/serialization output |

## Views / REST Export

`json_field_field_views_data()` (in `json_field.views.inc`) delegates to `json_field.views`,
which clones the standard `<field>_value` column into an extra
**`<field>_json_value`** column titled *"<label> (data)"* and forces its handler to the
Views field plugin `json_data` (`Drupal\json_field\Plugin\views\field\JsonDataField`).

`JsonDataField::render()` returns `$serializer->decode($value, 'json')` — i.e. a real
array/object instead of a string — but **only when the display handler is a
`RestExport`**. On a normal page/block display it falls back to the plain value.
`usesGroupBy()` is FALSE and advanced render is disabled for this handler.

So: add the *"… (data)"* field (not the plain one) to a **REST Export** display to get
embedded JSON in the feed.

## JSON:API

By default JSON:API returns the field as a string. Install
[JSON:API Extras](https://www.drupal.org/project/jsonapi_extras), override the resource type
at `/admin/config/services/jsonapi/resource_types`, open *Advanced* for the field and choose
the **JSON Field** enhancer.

## Feeds

`Drupal\json_field\Feeds\Target\JsonFieldTarget` (`@FeedsTarget(id = "json_field")`) maps a
source column onto the `value` property of any of the three types. For `json_native` and
`json_native_binary` the property is marked unique, so it can be used as the "unique target"
for updates.

## Diff

`src/Plugin/diff/Field/JsonFieldBuilder.php` provides a field builder for the
[Diff](https://www.drupal.org/project/diff) module so JSON fields show up in revision
comparisons. Diff is a `suggest`, not a hard dependency.

## Hooks the module implements

`hook_help()`, `hook_theme()` (returns an empty array), `hook_field_info_alter()` (only a
back-compat shim that sets the "JSON data" category on Drupal < 10.2), and
`hook_field_views_data()`. It defines **no** `.api.php` hooks of its own.

## Update path

`json_field_update_8100()` installs the `json_field_widget` submodule;
`json_field_update_8101()` flushes caches after class renames.
