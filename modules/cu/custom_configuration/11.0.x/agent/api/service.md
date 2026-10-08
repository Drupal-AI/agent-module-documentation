<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading values: the `custom.configuration` service

Service id **`custom.configuration`** → `Drupal\custom_configuration\Helper\ConfigurationHelper`
(`src/Helper/ConfigurationHelper.php`, wired in `custom_configuration.services.yml` with
`@database`, `@module_handler`, `@language_manager`, `@service_container`). This is the public API
for reading stored values; the admin forms use the same class for writes.

## `getValue($machine_name, $langCode = NULL, $domainKey = NULL): string|null`

Returns the single stored **string value** for a machine name in the given (or current) context.

```php
$value = \Drupal::service('custom.configuration')->getValue('mobile');
// e.g. "11111111111"  — or NULL
```

Behaviour (from source):
- Empty `$machine_name` → returns `NULL`.
- If `$langCode` is omitted → `getActiveLanguage()` = `language_manager->getCurrentLanguage()->getId()`.
- If `$domainKey` is omitted → `getActiveDomain()` = `'default'`, unless the **Domain** module is
  enabled, then `domain.negotiator->getActiveDomain()->id()`.
- Builds args `machine_name`, `langcode`, `domain_key`, `status = 1` and calls `getConfigList()`,
  which matches language/domain with `LIKE '%,<key>,%'` against the comma-wrapped columns and
  filters `custom_config_status = 1`.
- Returns the first matching row's `custom_config_value`, else `NULL`.

So a value that does not exist, is **Inactive** (`status = 0`), or does not match the
language/domain context returns `NULL` — callers should treat `NULL` as "no value".

## `getValues($machine_name, $langCode = NULL, $domainKey = NULL): object|null`

Same lookup, but returns a `stdClass` enriched with the optional values and metadata:

```php
$obj = \Drupal::service('custom.configuration')->getValues('mobile');
// $obj->machine_name, $obj->name, $obj->value,
// $obj->langcode  => ['en'], $obj->domain_key => ['default'],
// $obj->optional  => ['value_1' => 'Sales Team', 'value_2' => 'Office Phone', ...]
```

`custom_config_options` is `unserialize(..., ['allowed_classes' => FALSE])` (no object
instantiation), and the comma-wrapped langcode/domain strings are exploded into arrays via
`removeComma()` + `explode(',', …)`. Returns `NULL` on no match / empty machine name.

## Other public helper methods (same class)

- `createConfiguration(array $post)` / `updateValue(array $post)` — insert / update a row; return
  `['status' => 'status'|'error', 'message' => ...]`. Used by the add/edit forms.
- `deleteValue($config_id)` — delete a row by id.
- `checkDuplicateItems(array $post)` — TRUE if a machine-name + domain + language combination
  already exists (optionally excluding a `config_id`).
- `getConfigList(array $args = NULL)` — raw row fetch; supports `id`, `machine_name`, `langcode`,
  `domain_key`, `status` filters.
- `createMachineName($name)` — slugify a human key to a machine name (≤50 chars).
- `getLanguages()` / `getDomains()` / `getLanguageName()` / `getDomainName()` — context lookups
  (domains only populated when the Domain module is enabled).

## Context model

Values are stored per **machine name × domain × language**. Domains and languages are held as
comma-wrapped lists (`,en,fr,`, `,default,`), so one row can serve several languages/domains and
the `LIKE '%,key,%'` match finds it. Omit the langcode/domain arguments to read the value for the
request's current language and active domain; pass them explicitly to read another context's value.

## Notes

- Reads are DB-backed and uncached by the module; wrap hot paths in your own cache if needed.
- `getValue`/`getValues` never throw on a missing key — they return `NULL`.
- Store non-secret configuration only; rows are plain database text, not encrypted.
