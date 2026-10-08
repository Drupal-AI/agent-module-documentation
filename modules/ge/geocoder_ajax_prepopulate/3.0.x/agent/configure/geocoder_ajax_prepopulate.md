<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable on-form prepopulate for a field

There is **no admin settings page and no config of its own** (`configure: null`). Setup happens
inside an existing Geocoder field configuration; this module only adds one extra method option and
the on-form button.

## Prerequisite: a working Geocoder field

Configure Geocoder first. You need a **destination** field that Geocoder can write to (typically a
`geofield`, or an Address / text / country field) whose *Geocode* third-party settings
(`geocoder_field`) point at a **source** field, a provider, and a dumper. See the `geocoder` /
`geocoder_field` docs for that. This module reuses all of it unchanged.

## Step 1 — choose the prepopulate method

On the destination field's **field settings / config edit form** (Manage fields → the field →
Edit), the *Geocode* section (provided by `geocoder_field`) has a **Method** select. This module adds
a new option:

- **"Prepopulate by geocoding an existing field"** — internal value **`prepopulate_from_source`**.

Select it and pick the **source field** to geocode from (the *Prepopulate by geocoding an existing
field* select). When `prepopulate_from_source` is chosen, the module's form alter hides the settings
that no longer apply (`hidden`, `weight`, failure `handling`, `disabled`, `skip_not_empty_value`) via
`#states`, and stores the same provider/dumper settings that the ordinary `geocode` method would use
(a validate handler, `geocoder_ajax_prepopulate_settings_validate`, copies the `geocode` sub-values
up so nothing is lost). Save the field.

## Step 2 — use the button on the entity form

When you edit (or create) an entity that has this field, the destination field's widget now shows a
button:

> **Populate from the <source> field.**

Clicking it:

1. Fires a Form-API `#ajax` request (throbber message "Geocoding..."). Requires JavaScript — with
   JS off the button does nothing useful.
2. Runs `geocoder_ajax_prepopulate_validate`: builds the entity from the currently-entered values,
   geocodes the **source** field through the configured provider(s) and dumper, and writes the
   result into the destination field's input. The source field is **not** validated
   (`#limit_validation_errors => []`), so a partial address (e.g. only a city) can still be geocoded.
3. Replaces the destination field element in place (`ReplaceCommand`) and triggers a `change` event
   on its inputs (`ChangeWhenReady` → `js/change_when_ready.js`) so map widgets such as Geofield Map
   redraw. Any geocoding failure message is shown above the field (`PrependCommand`).

The editor can then accept the coordinates, edit the address and click again, or type coordinates by
hand — nothing is written to storage until the entity form itself is saved normally.

## Notes

- Geocoding failures respect the field's existing `geocoder_field` failure settings (status message /
  log warning); on failure the previous value is preserved.
- `address_country` source fields are converted from country code to country name before geocoding.
- The **Profile** module is handled specially: when the profile form is embedded in the user
  registration form, the entity is rebuilt from `$form_state->get(['profiles', $bundle])`.
- Applies only to configurable fields (`FieldConfigInterface`); base fields are skipped.
