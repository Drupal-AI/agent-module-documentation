<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bring postal code fills in locality/place-name fields on the client side from Bring's free postal-code service as a user types a postcode.

---

Configuration lives at `/admin/config/bring-postal-code` (custom permission `access bring postal code settings`) where you set the Bring client URL, a list of form IDs to attach to, and a set of `input|output|country` jQuery selectors (one per line), plus a default country. A `hook_form_alter` matches the configured form IDs and, via the `LookupTools` service, attaches the `bring-lookup` library and passes the selectors, default country, client URL, and trigger length to `drupalSettings`. The JavaScript (`js/lookup.js`) listens on each input's `keyup` and, once the value reaches the trigger length, issues a JSONP AJAX call to the configured Bring client URL with the postcode and country, writing the returned place name into the output selector (or an "Invalid postcode" message).

Because the lookup is entirely JavaScript/JSONP driven against the client-configured URL, the module performs no server-side validation — the README explicitly notes this — so treat the filled value as a convenience, not a validated address, and enforce real address validation elsewhere if needed. It works on any form (node, taxonomy, custom, or Commerce checkout) purely by selector configuration; there is no server endpoint of its own. The only route is the admin settings form.
---
Auto-fill a city/place field from a Norwegian postcode.
- Attach postcode lookup to a Commerce checkout form.
- Attach lookup to a node add/edit form.
- Attach lookup to a custom form by form ID.
- Configure the Bring client URL used for lookups.
- Define input/output jQuery selectors for a form.
- Specify a per-selector country selector.
- Set a default country for lookups.
- Set the minimum characters (trigger length) before lookup.
- Attach to multiple forms at once via a form-ID list.
- Fill localities across several supported countries.
- Show an "Invalid postcode" message on no match.
- Use JSONP so no server-side proxy is needed.
- Restrict who can change lookup settings via a custom permission.
- Speed up address entry for storefront customers.
- Reduce mistyped city names in address fields.
- Reuse the same selector config across similar forms.
- Add postcode helper to a taxonomy term form.
- Point the client URL at a different Bring endpoint/environment.
- Enable client-side convenience without server validation.
