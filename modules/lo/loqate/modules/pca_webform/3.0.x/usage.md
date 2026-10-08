<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PCA Webform is a Loqate submodule that provides a `webform_address_loqate` composite Webform element for collecting Loqate-verified addresses. The element is **deprecated** (since Loqate 2.1.0) but still ships.

---

The submodule depends on `loqate` and `webform`. It registers a composite Webform element
`webform_address_loqate` (form element `WebformAddressLoqate` extending Webform's
`WebformCompositeBase`, plus a matching `WebformElement` plugin) with subfields: address, address 2,
city, region, state/province (select), postal code, country (select). On render
(`preRenderWebformCompositeFormElement`) it attaches the `pca_webform/element.pca_webform.address.js`
library (which itself depends on the base module's external Loqate SDK library) and exposes the
resolved API key value at `drupalSettings.loqate.loqate.key` via `Loqate::getApiKey()` — again a
purely client-side lookup, no Drupal proxy. The plugin formats the stored composite value into readable
address lines for display. It has no configuration form of its own and no permissions. A tiny
`hook_webform_options_alter` copies a named options set onto a `data-option-type` attribute for the JS.
Because it is deprecated, prefer the base module's `pca_address` element (or the `pca_address`
submodule for Address fields) on new builds.

---

- Add a Loqate address-autocomplete element to a Webform.
- Collect a structured composite address (lines, city, region, state, postal code, country).
- Auto-populate Webform address subfields from a Loqate search result (client-side).
- Reuse the site-wide Loqate API key on Webform submissions.
- Render a human-readable address from a stored Webform submission value.
- Maintain legacy Webforms that already use `webform_address_loqate`.
- Migrate legacy Loqate Webform elements toward the non-deprecated `pca_address` element.
- Provide state/province and country select lists in the address element.
- Improve address data quality on Webform-based lead/contact forms.
- Add a country and state/province select to a Webform address composite.
- Reduce typos in postal codes on Webform submissions via type-ahead search.
- Collect addresses on event registration or order-inquiry webforms.
- Format submitted composite addresses into readable lines in results/emails.
- Keep an existing deprecated Loqate Webform element working on Drupal 9/10/11.
- Serve the Loqate SDK client-side without a Drupal proxy for Webform address search.
- Use `hook_webform_options_alter` behavior to expose named option sets to the JS.

