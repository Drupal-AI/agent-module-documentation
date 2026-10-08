<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Location AddressFinder integrates the AddressFinder service (addressfinder.com.au / .nz) into Webform, giving form builders an address autocomplete-and-verify widget for Australian and New Zealand addresses.

---

The module ships two element flavours. The composite location element (`webform_location_addressfinder`) extends `WebformLocationBase` and defines around thirty address sub-fields (full address, street parts, locality, state, postcode, latitude/longitude, GNAF/DPID/meshblock, etc.); its render element attaches drupalSettings plus the AddressFinder widget JS so a `result:select` from the widget populates each sub-field. A lighter single-textfield element (`webform_location_addressfinder_fulladdressonly`) captures just the formatted address. A global settings form (`src/Form/Settings.php`, at `/admin/config/webform_location_addressfinder`) stores the AddressFinder API key and AU/NZ and postal toggles; per-element config can override the key and options. The AddressFinder widget itself is loaded from `https://api.addressfinder.io/assets/v3/widget.js` and does all address lookups directly from the browser over HTTPS.

There are no security findings: the module makes no server-side HTTP calls, has no SQL, deserialization, or command execution, and holds no hardcoded secrets. The AddressFinder API key is stored in config and pushed to `drupalSettings` for the browser widget — this client-side exposure is by design, since AddressFinder issues a public/browser key scoped by referrer. Two operator notes: the settings route is gated by the broad `access administration pages` permission rather than a dedicated admin permission, and the shipped config schema keys (`element.default_addressfinder_api_key`, ...) do not match the flat keys the settings form actually reads/writes (`api_key`, `is_nz`, `no_postal`), so the schema does not describe the stored config.
---
- Add address autocomplete to a webform for AU/NZ addresses.
- Capture a full structured address into composite sub-fields.
- Capture just a formatted full-address string in one textfield.
- Populate latitude/longitude from a selected address.
- Store GNAF/DPID/meshblock identifiers from AddressFinder results.
- Configure a global AddressFinder API key for all forms.
- Override the API key per element.
- Switch a form's lookups to New Zealand addresses (`is_nz`).
- Enable postal-address results (`no_postal` toggle).
- Verify user-entered addresses against AddressFinder data.
- Reduce address entry errors on contact/booking forms.
- Suppress Enter-submit and browser autocomplete on the address input.
- Use the widget inside a larger composite webform element.
- Collect standardized street/locality/state/postcode parts.
- Provide type-ahead address suggestions as the user types.
- Map AddressFinder metadata into hidden webform fields.
- Build a service-area form that validates deliverable addresses.
- Attach the AddressFinder widget only where the element is used.
- Keep address lookups client-side (no server round-trip).
- Restrict who can set the API key via the settings form permission.
- Add address verification to a Road Safety / government intake form.
- Reuse a single AddressFinder account across multiple webforms.
