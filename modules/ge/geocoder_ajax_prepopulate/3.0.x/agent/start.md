<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geocoder AJAX Prepopulate (geocoder_ajax_prepopulate) — agent index

Adds a **manual AJAX button on the entity edit form** that geocodes a *source* field (e.g. an
Address or text field) into a Geocoder *destination* field (e.g. a geofield) **before save**, so the
editor can see and correct the result. It changes **when** geocoding happens (on button click),
not **how** — provider, field mapping, dumper and storage stay whatever `geocoder_field` is already
configured to use. Depends on **`geocoder:geocoder_field`**, not on `geocoder` as a whole.
Core `^9.2 || ^10 || ^11`.

Not a debounce / not type-as-you-go: geocoding fires only when the editor clicks the button.

## What you'd do → where

- **Turn on on-form prepopulate for a field, and understand the button/AJAX flow** →
  [configure/geocoder_ajax_prepopulate.md](configure/geocoder_ajax_prepopulate.md)

## Key facts (real symbols)

- **No routes, no permissions, no configuration entity, no config schema, no plugins, no Drush.**
  Everything is Form-API hooks in `geocoder_ajax_prepopulate.module` plus one AJAX command.
- Adds geocoding method option **`prepopulate_from_source`** to the `geocoder_field` third-party
  settings on the field config edit form (`hook_form_field_config_edit_form_alter`).
- On the entity form, `hook_field_widget_single_element_form_alter` adds a `#type => button`
  labelled *"Populate from the <source> field."* with `#ajax` callback
  `geocoder_ajax_prepopulate_ajax`, `#validate => ['geocoder_ajax_prepopulate_validate']`,
  `#submit => []`, and `#limit_validation_errors => []` (source field is intentionally not
  validated).
- `geocoder_ajax_prepopulate_validate` builds the entity from submitted values and calls
  `_geocoder_ajax_prepopulate_geocode()`, which uses the `geocoder` service +
  `GeocoderProvider::loadMultiple($geocoder['providers'])` + the configured dumper
  (`plugin.manager.geocoder.dumper`, `plugin.manager.geocoder.preprocessor`); the result is written
  back into `$form_state` user input.
- AJAX callback returns an `AjaxResponse` with `ReplaceCommand` (the field element),
  a custom **`ChangeWhenReady`** command (`src/Ajax/ChangeWhenReady.php`), and `PrependCommand`
  for status messages. `js/change_when_ready.js` fires a jQuery `.change()` on the replaced inputs
  so widgets like Geofield Map refresh. Library: `geocoder_ajax_prepopulate/change-when-ready`
  (depends on `core/drupal.ajax`).
- Special-cases the **Profile** module (form embedded in `user_register_form`) and
  `address_country` source fields (maps country code → name via `CountryManager`).
- Ships a `composer.lock` in the release tarball (unusual for a Drupal module; ignored when
  installed as a dependency).
