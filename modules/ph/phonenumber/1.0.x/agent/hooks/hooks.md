# Hooks

## Hook this module invokes (implement in your module)

### `hook_phonenumber_geo_ip_lookup_service()`

Invoked via `\Drupal::moduleHandler()->invokeAll('phonenumber_geo_ip_lookup_service', [$services])`
inside `phonenumber_geo_ip_lookup_services()`. Return an array of additional GeoIP lookup services;
the return is merged onto the built-in registry. Each entry is keyed by a service machine name and
uses the same shape as the built-ins:

```php
function mymodule_phonenumber_geo_ip_lookup_service(array $services) {
  return [
    'mygeo' => [
      'title'  => t('My GeoIP'),
      'url'    => 'https://example.com/geo',
      'type'   => 'json',            // 'json' or 'text'
      'script' => 'return data.country_code;', // JS body: receives `data`, returns ISO2
      'signup' => TRUE,             // TRUE => an API key field is required
    ],
  ];
}
```

The chosen service is exposed to the browser widget as
`drupalSettings.phone.options.geoLocationApi`; the lookup itself runs client-side.

## Hooks this module implements

| Hook | File | Purpose |
|---|---|---|
| `hook_help()` | `phonenumber.module` | Help text on `help.page.phonenumber`. |
| `hook_field_formatter_info_alter()` | `phonenumber.module` | Adds core `string` formatter support to the `phone` field type. |
| `hook_field_type_category_info_alter()` | `phonenumber.module` | Attaches the `phonenumber/phonenumber.phone-icon` library to the *General* field-type category. |

## Related hook in the verification submodule

`hook_phonenumber_verification_send_sms_callback_alter(&$send_sms_callback)` (defined in
`phonenumber_verification.api.php`) lets a module set the single SMS-sending callback used by the
verification flow. It belongs to the `phonenumber_verification` submodule, not the base module —
see that submodule's docs.
