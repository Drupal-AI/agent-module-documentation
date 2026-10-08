# Widget: `phone_default`

Class: `Drupal\phonenumber\Plugin\Field\FieldWidget\PhoneDefaultWidget` (extends `WidgetBase`,
injects core `country_manager`). Applies to field types `phone` and core `telephone`.
It renders the `#type => phone` form element (`Drupal\phonenumber\Element\Phone`), which builds
an intl-tel-input–style control: a `tel` input plus hidden inputs for `phone_number`,
`country_code`, `country_iso2`, and (optionally) an `extension` textfield.

The widget merges the field settings (see [field-type.md](field-type.md)) with its own widget
settings and passes them to the element as `#phone`, then attaches `drupalSettings.phone.options`
and the JS libraries `phonenumber/phone` (+ `phonenumber/phonenumber.formatter` when
`mask_formatter` is on).

## Widget settings (`field.widget.settings.phone_default`)

`defaultSettings()`:

| Key | Default | Purpose |
|---|---|---|
| `initial_country` | `'auto'` | Preselected country, or `auto` = GeoIP lookup by IP. |
| `preferred_countries` | `['US','GB']` | Countries pinned to the top of the list. |
| `allow_dropdown` | `TRUE` | Allow opening the country dropdown. |
| `fix_dropdown_width` | `TRUE` | Match dropdown width to input width. |
| `separate_dial_code` | `FALSE` | Show dial code next to the flag. |
| `format_as_you_type` | `TRUE` | Live formatting while typing. |
| `format_on_display` | `TRUE` | Format existing value on init. |
| `show_flags` | `TRUE` | Show country flags. |
| `country_search` | `TRUE` | Search box atop the dropdown. |
| `use_fullscreen_popup` | `TRUE` | Fullscreen dropdown on small screens. |
| `remove_start_zero` | `TRUE` | Strip leading zero from local number/placeholder. |
| `mask_formatter` | `TRUE` | Apply an input mask from the country pattern. |
| `show_error` | `FALSE` | Inline client-side format error + block submit. |

The settings form additionally filters the country list by the field's `allowed`/`countries`
settings and forces `initial_country` to `auto` if the chosen country is not allowed.

## GeoIP "auto" country

When `initial_country` (or field `geo_ip_lookup`) resolves to `auto`, the client JS calls one of
the services from `phonenumber_geo_ip_lookup_services()` to detect the visitor's country. Built-in
services (key → title): `ip2c`, `ipapi` (default), `ip-api`, `ipwhois`, `geoplugin`,
`ipgeolocation` (requires an `api_key`). The selected service's `url`/`script`/`type` (and
`apiKey` when the service requires signup and a key is set) are exposed in
`drupalSettings.phone.options.geoLocationApi`; the lookup runs in the browser. Add your own service
with `hook_phonenumber_geo_ip_lookup_service()` — see [hooks/hooks.md](../hooks/hooks.md).

## Set widget settings via PHP

```php
$display = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');
$display->setComponent('field_phone', [
  'type' => 'phone_default',
  'settings' => [
    'initial_country' => 'US',
    'preferred_countries' => ['US', 'CA'],
    'separate_dial_code' => TRUE,
    'mask_formatter' => TRUE,
  ],
])->save();
```

## Server-side element handling (`Element\Phone`)

- `valueCallback()` reads submitted `phone_number`, `local_number`, `country_code`,
  `country_iso2`, and `extension` (extension only when `extension_field` is on).
- `validatePhone()` strips the country code from the local number in international mode, then
  cleans `phone_number` to digits only (`preg_replace('/[^\d]/','')`) and rejects it if it still
  contains non-digits; also enforces required. This is a server-side safety net; libphonenumber
  format/country validation is provided by the `phonenumber_validation` submodule's constraint.
