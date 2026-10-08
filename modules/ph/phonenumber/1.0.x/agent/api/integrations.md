# Integrations & the `phone` form element

The base module exposes a reusable form element and two optional third-party integration plugins.

## `#type => phone` form element

Class `Drupal\phonenumber\Element\Phone` (`@FormElement("phone")`, extends `FormElement`). Renders
a `tel` input with the intl-tel-input JS control plus hidden `phone_number`, `country_code`,
`country_iso2` inputs and an optional `extension` textfield. Use it directly in any form:

```php
$form['phone'] = [
  '#type' => 'phone',
  '#title' => $this->t('Phone'),
  '#phone' => [
    'initial_country' => 'US',
    'preferred_countries' => ['US', 'GB'],
    'national_mode' => TRUE,
    'strict_mode' => TRUE,
    'mask_formatter' => TRUE,
    'geolocation_api' => 'ipapi',
    'extension_field' => FALSE,
  ],
];
```

Key processing: `processPhone()` builds the sub-elements, computes `preferred_countries`/
`only_countries`/`exclude_countries`, resolves the GeoIP service via
`phonenumber_geo_ip_lookup_services()`, and attaches `drupalSettings.phone.options` +
libraries `phonenumber/phone` (and `phonenumber/phonenumber.formatter` when masking is on).
`valueCallback()` collects the submitted parts; `validatePhone()` cleans `phone_number` to digits
and enforces required (see [../fields/widget.md](../fields/widget.md)). The submitted value is an
array with `phone_number`, `local_number`, `country_code`, `country_iso2`, `extension`.

## Feeds target — `phone`

Class `Drupal\phonenumber\Feeds\Target\Phone` (`@FeedsTarget(id = "phone", field_types = {"phone"})`,
requires the `feeds` module). Maps source columns to the field properties `phone_number`,
`local_number`, `country_code`, `country_iso2`, `extension`. `prepareValue()` normalises through the
phone-number util: from a local number + `country_iso2`, or from an international `phone_number`,
setting `value`, `local_number`, `country`, and `extension`; an unparseable value clears the item.
(No configurable settings.)

## Webform element — `phone`

Class `Drupal\phonenumber\Plugin\WebformElement\Phone` (`@WebformElement(id = "phone", composite = TRUE)`,
requires the `webform` module). A composite element exposing the same country/dropdown/mask/geo-IP
options as the field widget, plus a display "toggle theme" (`light`/`dark`/`iphone`/`modern`/`soft`).

- Display formats (`getItemFormats()`): `phone_international` (default) and `phone_local`; output is
  produced with libphonenumber `format()` and rendered as `#plain_text` or a `tel:` `#type => link`.
- When the `phonenumber_verification` submodule is enabled it injects the extra `verify` / `message`
  / `length` / `verify_interval` / `verify_count` properties and the verification UI; when `token`
  is enabled the SMS message field gets a token tree. Those belong to the verification submodule.

## Helper functions (in `phonenumber.module`)

- `phonenumber_geo_ip_lookup_services()` — returns the GeoIP service registry
  (`ip2c`, `ipapi`, `ip-api`, `ipwhois`, `geoplugin`, `ipgeolocation`), invoking
  `hook_phonenumber_geo_ip_lookup_service()` so other modules can add entries.
- `phonenumber_number_types()` — the libphonenumber number-type option list used by the field and
  webform settings forms.
