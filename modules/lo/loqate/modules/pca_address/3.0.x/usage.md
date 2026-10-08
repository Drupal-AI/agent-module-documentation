<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PCA Address is a Loqate submodule that adds Loqate address autocomplete to the [Address](https://www.drupal.org/project/address) module: a `pca_address_advanced` field widget and matching form element that extend Address core's own widget/element.

---

The submodule depends on `loqate` and `address`. It defines a form element `pca_address_advanced`
(`AddressPcaAddress`, extending `\Drupal\address\Element\Address`) and a field widget
`pca_address_advanced` (`AddressPcaAddressWidget`, extending Address's `AddressDefaultWidget`). Both
pull in the shared `PcaAddressElementTrait` / `PcaAddressFieldWidgetTrait` from the base module, so the
Loqate lookup textfield, field-mapping-driven auto-population, manual-input toggle and client-side SDK
wiring behave exactly like the base `pca_address` element — just layered onto an Address field. The
widget's settings form adds "Show address fields", "Allow manual input" and a per-widget Loqate **Key**
override (`key_select`); leaving the key empty uses the site default. Choose the widget on an entity's
**Manage form display** tab for any `address`-type field. It has no config of its own and no
permissions; the API key and default field mapping come from the base module's config.

---

- Turn an existing Address field into a Loqate type-ahead address search.
- Auto-populate the Address subfields (country, locality, postal code, lines) from a Loqate result.
- Enable Loqate autocomplete on registration/checkout Address fields.
- Override the Loqate API key for a specific Address field widget.
- Show or hide the Address subfields until a result is chosen (`Show address fields`).
- Offer a manual-entry fallback on an Address field.
- Reuse the site-wide field mapping (`loqate.settings:pca_fields`) on Address fields.
- Use the `pca_address_advanced` element in a custom form that needs an Address-shaped value.
- Improve address data quality on Commerce/customer profiles that use Address.
- Keep Address's country-aware subfield behavior while adding Loqate search on top.
- Pass extra Loqate SDK options per widget via `pca_options` (e.g. country restriction).
- Provide a custom `pca_fields` mapping for a specific Address field instead of the site default.
- Set the widget on `node.<bundle>.default` form display via config or `drush php:eval`.
- Speed up address entry on membership/registration forms that use the Address module.
- Standardize verified postal data across content entities that share an Address field.
- Fall back gracefully to manual Address entry when a user's address isn't found by Loqate.

