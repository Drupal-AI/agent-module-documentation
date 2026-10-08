<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Bring postal code

Route: `/admin/config/bring-postal-code` (permission `access bring postal code settings`). Config object: `bring_postal_code.settings`.

## Fields
- **Client URL** — the Bring postcode service URL the browser calls, ending with `?` (JSONP request appends `country`, `pnr`, `clientUrl` params).
- **Attach to forms** — newline-separated list of form IDs; `hook_form_alter` attaches the library when `$form_id` matches one of them.
- **Input / output selectors** — one per line, `input|output|country` jQuery selectors, e.g. `#code|#name|#country`. The country segment is optional; omit it (`#code|#name`) to use the default country.
- **Default country** — used when a line has no country selector or the country field is empty.
- **Trigger length** — minimum characters typed before a lookup fires.

## Behaviour
`LookupTools::attach()` pushes the selectors + settings into `drupalSettings.bring_postal_code`. `js/lookup.js` binds `keyup` on each input; once the value length ≥ trigger length it does a `dataType: 'jsonp'` AJAX call to the client URL and writes `data.result` into the output selector, or an "Invalid postcode." message when `data.valid` is false.

## Important
Everything happens in the browser — there is **no server-side validation**. Use it as an entry convenience only; enforce authoritative address validation server-side if correctness matters (e.g. shipping).
