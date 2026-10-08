<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extends the Geocoder module with a manual "Populate from the <source> field" AJAX button on the entity edit form, so an editor can geocode an address into a geofield (or other destination field) and check the result before saving, instead of waiting for save-time geocoding.

---

Normal Geocoder flow is save-then-geocode: `geocoder_field` runs the configured provider during `hook_entity_presave` and fills the destination field only once the form is submitted, so a mistyped address is discovered after save. This module moves geocoding onto the form. It adds a new geocoding method, `prepopulate_from_source`, to the geocoder settings of any field that can be a geocode destination (the field config edit form's *Geocode* third-party settings). When that method is selected, the entity edit form grows a button labelled *"Populate from the <source> field."* next to the destination field. Clicking it fires a Form-API `#ajax` request whose validate callback builds the entity from the currently-submitted values, geocodes the source field through the already-configured Geocoder provider(s) and dumper, writes the result back into the destination field's user input, and returns an `AjaxResponse` that replaces the field element in place. A small AJAX command (`ChangeWhenReady`, `js/change_when_ready.js`) then triggers a `change` event on the replaced inputs so downstream widgets such as Geofield Map re-render the new coordinates. Geocoding therefore happens on demand, the editor sees the coordinates, and can accept them, click again after fixing the address, or type coordinates by hand. It depends specifically on `geocoder:geocoder_field` (not on Geocoder as a whole) and ships no routes, permissions or configuration of its own — the provider, field mapping, dumper and storage all remain whatever `geocoder_field` is already set to do.

---

- Let an editor geocode an address on the form with a button click, before saving.
- Show the resulting coordinates so the editor can verify them.
- Catch a mistyped or ambiguous address at entry time, not after save.
- Re-geocode after correcting the address, without saving in between.
- Let an editor type coordinates by hand instead of geocoding.
- Prefill a geofield from an Address field on the same entity.
- Prefill latitude/longitude from a plain text address field.
- Populate a formatted-address destination from a partial source address.
- Prefill a region or country destination field.
- Preview map placement (e.g. via a Geofield Map widget) before publishing.
- Avoid saving content that carries wrong coordinates.
- Reduce save-and-check cycles when entering location content.
- Give editors confidence that geocoding resolved as expected.
- Support a venue, branch, store or office directory editing workflow.
- Speed up manual entry of many location records.
- Keep using an existing Geocoder provider and dumper unchanged.
- Add on-form geocoding to only the fields that opt in via `prepopulate_from_source`.
- Trigger geocoding without validating the whole form (`#limit_validation_errors` is empty), so partial addresses can still be geocoded.
- Refresh dependent map widgets automatically after populating (the `changeWhenReady` command).
- Work with the Profile module's user-register embedding, where the profile form is nested in the registration form.
