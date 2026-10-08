<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping same as billing (commerce_shipping_same_as_billing) — agent index

Checkout convenience for Drupal Commerce: adds a **"shipping information is the same as the billing
information"** checkbox to the shipping profile inline form so the customer's **shipping address is
copied from the billing address** (one direction: billing → shipping). Drupal Commerce Shipping
ships the reverse behaviour out of the box (a checkbox that copies shipping → billing on the payment
pane); this module **disables that** and provides the flipped version, which suits checkout flows
that collect billing before shipping.

Package `Commerce (contrib)`. Core `^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed
**1.0.0-alpha3** (version dir `1.0.x`) — an **alpha / pre-stable** release; verify behaviour on your
own checkout flow. It has security-advisory coverage on drupal.org.

## Dependencies

- Drupal module (from `.info.yml`): **`commerce_shipping`** (Drupal Commerce Shipping).
- Composer (`composer.json`): **`drupal/commerce_shipping: ^2.11`** (which brings in Drupal Commerce).
- No third-party PHP libraries, no JS libraries.

## What it provides (from source)

The whole module is one service (a subclass of a Commerce Shipping service) plus three hooks and two
pane overrides. There are **no routes, no permissions, no config entities, no config schema, and no
config UI** — the checkbox lives inside the existing shipping checkout pane.

- **`ProfileFieldCopy` service** (`src/ProfileFieldCopy.php`, service
  `commerce_shipping_same_as_billing.profile_field_copy`, declared in `.services.yml` with
  `parent: commerce_shipping.profile_field_copy` so it inherits Commerce Shipping's implementation).
  It **flips the copy direction** of the parent:
  - `supportsForm()` returns TRUE only when the altered inline form is the **shipping** profile
    (`$inline_form['#profile_scope'] === 'shipping'`), an **order** is in the form state, and that
    order **is shippable** (`$order->hasField('shipments')`). Outside an order (e.g. the payment-method
    add/edit screen) it bails out.
  - `alterForm()` sources the **billing** profile via `getBillingProfileFromFormState()`, then adds a
    `copy_fields` container with an AJAX-refreshing **`enable` checkbox** (`ajaxRefresh`). Copying is
    on by default for a new shipping profile. When enabled it calls
    `$shipping_profile->populateFromProfile($billing_profile, $billing_fields)`, forces
    `copy_to_address_book` to FALSE, hides all other inline-form children (the address-book select and
    address widgets), and — for any shipping fields **not** present on the billing profile — builds
    extra widgets. It swaps the inline form's `runValidate` / `runSubmit` handlers for its own static
    `validateForm` / `submitForm`.
  - `submitForm()` re-runs `populateFromProfile()` (values may have changed since build), extracts any
    extra field values, sets `copy_fields` data = TRUE, unsets `copy_to_address_book`, carries over the
    source `address_book_profile_id` (only when billing and shipping bundles match, so the right option
    is preselected if the box is later unchecked), and saves the shipping profile.
  - `getCopyLabel()` chooses the label text ("My shipping information is the same as my billing
    information." for the profile owner, else "Shipping information is the same as the billing
    information.").
- **Billing-profile source (server-side re-derivation)** — `getBillingProfileFromFormState()` reads
  `$form_state->get('billing_profile')` when present (set by the pane overrides below), otherwise falls
  back to `$order->collectProfiles()['billing']`. Both are **the order's own billing profile**; no
  request-supplied profile id is dereferenced. The shipping profile is taken from the inline form's own
  entity (`$plugin->getEntity()`).
- **`.module` hooks** (`commerce_shipping_same_as_billing.module`):
  - `hook_commerce_inline_form_customer_profile_alter()` — delegates to the service
    (`supportsForm()` then `alterForm()`), attaching the checkbox to the shipping profile form.
  - `hook_module_implements_alter()` — **removes** `commerce_shipping`'s own implementation of the same
    hook, so the stock "My billing information is the same as my shipping information" checkbox on the
    payment pane is suppressed.
  - `hook_commerce_checkout_pane_info_alter()` — repoints the `billing_information` and
    `payment_information` pane classes to this module's overrides. Carries a `@todo` to drop this once
    Commerce core issue [#3183140](https://www.drupal.org/project/commerce/issues/3183140) lands.
- **Pane overrides** (`src/Plugin/Commerce/CheckoutPane/`) — `BillingInformation` and
  `PaymentInformation` extend the core Commerce panes and do one extra thing: they stash the currently
  edited **billing profile entity** into `$form_state->set('billing_profile', …)` (in build / validate,
  and after submit for the payment pane) so `ProfileFieldCopy` can read the live billing profile as the
  copy source.
- **Tests** — `tests/src/FunctionalJavascript/ProfileFieldCopyTest.php` (a `commerce_shipping_same_as_billing`
  group WebDriver test) drives a full checkout: copy-enabled shipping matches billing, edits carry over,
  unchecking restores the address-book select, works both with and without `commerce_payment` enabled.

## Usage / manual docs

- Task-oriented usage: [usage.md](../usage.md)
- Human setup guide: [human-docs/index.md](../human-docs/index.md)
