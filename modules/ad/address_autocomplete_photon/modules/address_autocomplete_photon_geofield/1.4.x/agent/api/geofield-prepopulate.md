<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geofield prepopulate — how it works

## Install & enable

```bash
drush en address_autocomplete_photon_geofield -y
```

Ships inside the `address_autocomplete_photon` project (`modules/geofield/`). Depends on the parent
**`address_autocomplete_photon`** module and on **`geofield:geofield`**. Core `^10.1 || ^11 || ^12`.
No configuration of its own — it reuses the parent module's settings.

## Server side (PHP)

- `address_autocomplete_photon_geofield.services.yml` registers
  `Drupal\address_autocomplete_photon_geofield\Hook\AddressAutocompletePhotonGeofieldHooks` with
  `autowire: true`.
- `AddressAutocompletePhotonGeofieldHooks` (`src/Hook/AddressAutocompletePhotonGeofieldHooks.php`):
  - `#[Hook('help')] help()` — returns the About text for `help.page.address_autocomplete_photon_geofield`.
  - `#[Hook('field_widget_single_element_form_alter')] fieldWidgetSingleElementFormAlter(&$element, $form_state, $context)` —
    reads `$context['items']->getFieldDefinition()`; if the field type is **`geofield`**, appends
    library `address_autocomplete_photon_geofield/autocomplete` to `$element['#attached']['library']`.
- `address_autocomplete_photon_geofield.module` contains only `#[LegacyHook]` procedural shims that
  call the service (compatibility with older hook discovery).

That is the entire PHP surface: it just attaches JS to Geofield widget forms. It does **not**
require the parent's autocomplete widget to be on the same form via PHP — the JS bails out if no
`.address-autocomplete-input` is present.

## Client side (`js/address-autocomplete.js`)

`Drupal.behaviors.addressAutocompletePhotonGeoField`:

1. If there is no `.address-autocomplete-input` in the DOM, returns immediately.
2. `hideGeoFields()` — when the parent `settings.addressAutocomplete.managed_fields_display` is
   `hide`, hides `.field--widget-geofield-latlon`; otherwise sets `.geofield-lon` / `.geofield-lat`
   to `readonly`.
3. Listens for the parent widget's `autocompleteselect` event; if the picked result has a
   `geometry`, `updateGeoFields(result)` sets `.geofield-lon` = `geometry.coordinates[0]`,
   `.geofield-lat` = `geometry.coordinates[1]`, and triggers `change` on both.
4. For each address sub-field, a `change` handler (skipped when the field is hidden or `readonly`)
   recomposes the address (`getAddressFieldsValues()`) and calls
   `$.getJSON('https://photon.komoot.io/api/', { lang, limit, q })`, then updates the coordinates
   from `data.features[0]` — this covers the case where the initially selected suggestion lacked
   some property and the user corrected it by hand.
5. `eventToggleButton()` shows/hides the Geofield inputs in step with the parent module's override
   toggle button.

## Notes

- Coordinate order follows GeoJSON: `coordinates[0]` = longitude, `coordinates[1]` = latitude —
  written to `.geofield-lon` / `.geofield-lat` respectively.
- The Photon endpoint is hardcoded (`https://photon.komoot.io/api/`) and queried by the browser,
  same as the parent module — there is no server-side fetch, no admin-configurable host, and no
  API key.
- Targets Geofield's default lat/lon widget (relies on `.geofield-lon` / `.geofield-lat` /
  `.field--widget-geofield-latlon` selectors); other Geofield widgets (e.g. a map/WKT widget) will
  not receive the coordinates.
