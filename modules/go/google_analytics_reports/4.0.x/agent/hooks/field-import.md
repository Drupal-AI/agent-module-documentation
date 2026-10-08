<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_google_analytics_reports_field_import_alter`

Defined in `google_analytics_reports.api.php`. Lets you alter a single Google Analytics field
definition just before it is saved into the `google_analytics_reports_fields` table during
*Import fields*.

```php
/**
 * @param array $field
 *   - id: GA field id without the leading "ga:".
 *   - kind: collection type.
 *   - attributes: [type, dataType, group, status, uiName, description,
 *       calculation, minTemplateIndex, maxTemplateIndex, allowedInSegments, ...].
 */
function mymod_google_analytics_reports_field_import_alter(array &$field) {
  // Force the 'date' field to be treated as a date data type.
  if ($field['id'] === 'date') {
    $field['attributes']['dataType'] = 'date';
  }
}
```

Use it to correct or normalise how GA dimensions/metrics are typed/grouped so they behave
correctly as Views fields, filters and arguments. It runs once per field during the import
batch; re-run *Import fields* to apply changes.
