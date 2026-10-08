<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Autocomplete (Photon) – Geofield prepopulate (address_autocomplete_photon_geofield) — agent index

Submodule of **address_autocomplete_photon**. When a user selects a suggestion in the Photon
address autocomplete widget, it fills a **Geofield's longitude/latitude** from the selected
result's geometry. Package `Field types`. Depends on **`address_autocomplete_photon`** and
**`geofield:geofield`**. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.4.0.

- **How it hooks in and the coordinate-fill behavior** → [api/geofield-prepopulate.md](api/geofield-prepopulate.md)

## What it actually is

- One hook class: `Drupal\address_autocomplete_photon_geofield\Hook\AddressAutocompletePhotonGeofieldHooks` (`src/Hook/…`), an autowired service (`address_autocomplete_photon_geofield.services.yml`). Implements:
  - `#[Hook('help')]` → `help.page.address_autocomplete_photon_geofield` About text.
  - `#[Hook('field_widget_single_element_form_alter')]` → `fieldWidgetSingleElementFormAlter()`: for any field whose type is `geofield`, attaches library `address_autocomplete_photon_geofield/autocomplete`.
- `.module` file holds only `#[LegacyHook]` shims delegating to the service (procedural fallbacks).
- One library `autocomplete` (`js/address-autocomplete.js`), depends on `address_autocomplete_photon/autocomplete`, `core/drupal`, `core/jquery`.
- **No routes, no permissions, no config, no schema, no plugins.**

## Mechanism (from source)

- `js/address-autocomplete.js` (`Drupal.behaviors.addressAutocompletePhotonGeoField`) binds to the parent input's `autocompleteselect` event; `updateGeoFields(result)` writes `result.geometry.coordinates[0]` → `.geofield-lon`, `[1]` → `.geofield-lat`, then triggers `change` on both.
- `hideGeoFields()` / `showGeoFields()` follow the parent `managed_fields_display` setting (hide the `.field--widget-geofield-latlon` wrapper, or set the lat/lon inputs `readonly`), synced to the parent's override toggle button.
- If the user hand-edits an address sub-field, a `change` handler re-queries `https://photon.komoot.io/api/` (browser-side, hardcoded URL) with the recomposed address and updates coordinates from `data.features[0]`.
- All work is client-side; the submodule adds no server endpoint.
