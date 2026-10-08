# datalayer API (procedural)

The module exposes global functions in `datalayer.module` (no services meant for reuse; the
`Hook\*` classes and `DatalayerLazyBuilders` are internal wiring). Include the file if calling
outside a normal request:

```php
require_once DRUPAL_ROOT . '/modules/contrib/datalayer/datalayer.module';
```

## `datalayer_add(array $data = [], bool $overwrite = FALSE): array`

Add keys to the outgoing dataLayer, like a `drupal_add_js()` for data. Backed by a static
cache seeded with `_datalayer_defaults()`. With no arguments it returns everything queued so far.

```php
// Add a value (does not clobber an existing same-named key unless $overwrite).
datalayer_add(['campaign' => 'summer-sale']);
datalayer_add(['siteName' => 'Override'], TRUE);   // force-overwrite
$current = datalayer_add();                          // read current payload
```

Note: values added this way are collected during page build. The usual place to inject
computed data is `hook_datalayer_alter()` (see [../hooks/hooks.md](../hooks/hooks.md)),
which receives the assembled array by reference.

## `datalayer_get_data_from_page(bool $reset = FALSE): array`

Assembles the full payload for the current page: defaults + (if `add_page_meta`) the route
entity's data + (if `expose_user_details`) user data + `userUid`, then invokes
`hook_datalayer_alter()`. Statically cached; pass `TRUE` to rebuild. This is what the
lazy builder json-encodes into the inline `window.dataLayer.push(...)` script.

## `_datalayer_defaults(): array`

Returns the always-present keys: `drupalLanguage`, `drupalCountry`, `siteName` (JSON key
names honor the `drupal_language` / `drupal_country` / `site_name` config). Useful to verify
config-driven key renaming from drush.

## Other helpers (mostly internal)

- `datalayer_get_page_data()` — entity data for the current route entity (`[]` if none).
- `datalayer_get_user_data()` — current-user payload, honoring `expose_user_details*` config.
- `datalayer_get_entity_group(EntityInterface $entity)` — owning Group (needs `group` module).

## Reading a field's expose setting in code

```php
$expose = $field_config->getThirdPartySetting('datalayer', 'expose');   // 0/1
$label  = $field_config->getThirdPartySetting('datalayer', 'label');    // output key
```
