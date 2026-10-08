<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Autocomplete (with Photon API) (address_autocomplete_photon) — agent index

Adds a predictive **address autocomplete** widget to core **Address** fields, backed by the
open-source **Photon** geocoder (Komoot / OpenStreetMap). The user types one line, picks a
suggestion, and the individual Address sub-fields are auto-filled. Package `Field types`.
Depends on **`address:address`** (composer `drupal/address: ^1.0 || ^2.0`). Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.4.0.

- **Settings form, config object, permissions, routes** → [config/settings.md](config/settings.md)
- **The form element + field widget + client behavior (how autocomplete works)** →
  [fields/widget.md](fields/widget.md)
- **Submodule (Geofield prepopulate)** is documented separately at
  `modules/ad/address_autocomplete_photon/modules/address_autocomplete_photon_geofield/1.4.x/`.

## What it actually is

- One form element: `address_autocomplete` — `src/Element/AddressAutocomplete.php`, `#[FormElement('address_autocomplete')]`, extends `\Drupal\address\Element\Address`.
- One field widget: `address_autocomplete_photon` (label *"Address autocomplete with Photon"*) — `src/Plugin/Field/FieldWidget/AddressAutocomplete.php`, `field_types = { "address" }`, extends `AddressDefaultWidget`. Swaps the address element `#type` to `address_autocomplete`.
- One settings form: `SettingsForm` (`src/Form/SettingsForm.php`), route `address_autocomplete_photon.configure` at `/admin/config/system/address-autocomplete-photon`, menu link under *Configuration → System*.
- Two permissions (`address_autocomplete_photon.permissions.yml`): `administer address autocomplete photon` (gates the settings form, `restrict access: TRUE`) and `override address fields` (lets a user reveal/edit auto-filled fields when the widget allows it).
- Config: object `address_autocomplete_photon.settings` (defaults in `config/install/`, schema in `config/schema/`).
- Libraries (`address_autocomplete_photon.libraries.yml`): `autocomplete` (behavior `js/address-autocomplete.js` + CSS) and `autocomplete-plugin` (`js/plugin/address-autocomplete-photon.jquery.js`, depends on `core/drupal.autocomplete`, `core/jquery`).
- **No server-side controller, route, or proxy** beyond the admin form; no Drush; no `.install`.

## Mechanism (from source)

- `AddressAutocomplete::addressElements()` calls the parent Address element, then adds a `location_field` textfield (class `address-autocomplete-input`, `#maxlength 2048`, weight -99) whose default value is the formatted current address (`prepareDefault()` via `AddressDefaultFormatter::replacePlaceholders`).
- It attaches `library address_autocomplete_photon/autocomplete` and `drupalSettings.addressAutocomplete` = the config `autocomplete` mapping + `allow_overrides` (only TRUE when `#allow_overrides` **and** the current user has `override address fields`), `default_country`, and `format` (the country's address format string, from `address.address_format_repository`).
- Geocoding is **client-side**. `js/plugin/address-autocomplete-photon.jquery.js` binds jQuery UI autocomplete: its `source` calls `$.getJSON('https://photon.komoot.io/api/', { lang, q: "<term> <countryLabel>" })`, filters `data.features` to the selected country, formats each with `formatProperties()`, and on `select` maps Photon `properties` → the Address sub-field inputs (`getResponseMapping()`), applying per-country street formatting (`formatAddressLine1()`). Sub-fields are hidden/disabled per `managed_fields_display`.
- The Photon endpoint URL is **hardcoded in JS** (not admin-configurable, not request-driven) and the request is made by the visitor's browser, so there is no server-side outbound fetch.

## Config keys (`address_autocomplete_photon.settings` → `autocomplete`)

`min_length` (int, default 1), `limit` (int, default 3), `remove_duplicates` (bool, default true),
`managed_fields_display` (string: `default` | `hide` | `disable`, default `hide`). Widget-level
setting `allow_overrides` (bool, default FALSE) is per field-widget, not in the config object.
