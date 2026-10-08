<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Profile Inline Form Radios (commerce_profile_inline_form_radios) — agent index

Provides an **alternative Commerce customer-profile inline form that renders the customer's saved
address-book profiles as radio buttons** instead of the default single select dropdown, so a returning
customer picks an existing billing/shipping address with one click rather than re-typing it. Package
`commerce_profile_inline_form_radios`. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed
**1.0.0-beta1** (version dir `1.0.x`).

## Dependencies

- Drupal module (`.info.yml`): **`commerce:commerce_order`** (Drupal Commerce). That is the only
  hard dependency of the base module.
- Composer (`composer.json`): **`drupal/commerce: ^2.28 || ^3`**.
- No PHP-library requirements, no `.install`, no `.api.php`, no routes/services/permissions/config,
  no templates/JS/CSS libraries. Selection refresh uses core `#ajax`; the checkout form supplies the
  CSRF token.

## What it provides (from source)

- **One Commerce inline form plugin** — `@CommerceInlineForm` id
  `commerce_profile_inline_form_radios_customer_profile`, label "Customer profile (radios)", class
  `src/Plugin/Commerce/InlineForm/CustomerProfile.php`. It **extends** Commerce's own
  `commerce_order` `CustomerProfile` inline form and overrides `buildInlineForm()` (plus the AJAX
  callback and validate/submit) to change only the rendering:
  - When the profile type allows multiple profiles and the customer is authenticated, it loads the
    customer's own address-book profiles via `addressBook->loadAll($customer, …)` and builds an option
    per profile plus `_original` (when editing) and `_new` ("+ Enter a new address").
  - Instead of the base class's single `#type => 'radios'`/select, it emits **one `#type => 'radio'`
    element per option** (each `#return_value` = the profile id / `_new` / `_original`, CSS class
    `available-profiles`), inside an `addresses` container. Selecting a radio fires a core `#ajax`
    refresh; the chosen profile is shown rendered (via the `profile` view builder) with an **Edit**
    button, and a `copy_to_address_book` checkbox is placed under the selected option.
  - Ownership scoping, option resolution (`getProfileForOption()`, `selectDefaultProfile()`),
    country filtering, `copy_to_address_book`, validation and save all come from the base class
    unchanged. The submitted radio value is resolved by keying into the already owner-scoped profile
    set (with a default-profile fallback), i.e. the selectable options are scoped to the current
    customer's own profiles.
- **`hook_commerce_inline_form_..._alter`** (`.module`) — for this plugin, attaches Commerce
  Shipping's "Billing same as shipping" element when `commerce_shipping.profile_field_copy` supports
  the form (only if Commerce Shipping is present).

Note: the base module only *defines* the inline form plugin and the alter hook — nothing in it
instantiates the plugin. On its own it has no visible checkout effect. A submodule (below) or custom
code must call `inlineFormManager->createInstance('commerce_profile_inline_form_radios_customer_profile', …)`
for the radios to appear.

## Submodules (in `modules/`)

Each is a tiny override that swaps a core Commerce integration to build its customer/billing profile
through the radios inline form. Enable only those matching your checkout integrations.

- **`commerce_profile_inline_form_radios_shipping`** — dep `commerce_shipping:commerce_shipping`.
  `hook_commerce_checkout_pane_info_alter` repoints the **`shipping_information`** pane to a subclass
  of Commerce Shipping's `ShippingInformation` that builds the shipping profile via the radios inline
  form (still owner-scoped to `order->getCustomerId()`); keeps recalculate-shipping / packer logic.
- **`commerce_profile_inline_form_radios_payment`** — dep `commerce:commerce_payment`.
  `hook_commerce_checkout_pane_info_alter` repoints the **`payment_information`** pane to a subclass of
  Commerce Payment's `PaymentInformation` that builds the billing profile via the radios inline form.
- **`commerce_profile_inline_form_radios_paypal`** — deps `commerce:commerce_payment`,
  `commerce:commerce_paypal`; core **`^9 || ^10` only (no D11)**.
  `hook_commerce_payment_gateway_info_alter` swaps the `paypal_checkout` gateway's `add-payment-method`
  plugin form to a subclass that renders the billing profile with the radios inline form.

## Usage / files

- Human setup guide: [../human-docs/index.md](../human-docs/index.md).
- Feature/usage summary: [../usage.md](../usage.md).
- No agent subdocs — the module is a single inline-form override plus three small pane/form overrides;
  everything is covered above.
