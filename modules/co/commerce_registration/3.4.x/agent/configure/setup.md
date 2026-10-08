# Setup & configuration

Commerce Registration has **no module-wide settings form** — `data.json.configure` is `null`. You
configure it by (1) attaching a registration field to a product **variation** type, (2) tuning
per-variation registration settings, and (3) choosing which checkout pane creates registrations.
Everything below cites the module's own routes/plugins; the registration field, registration types,
and per-host "registration settings" entities come from the `registration` module.

## Install-time guard

`commerce_registration_requirements()` (in `commerce_registration.install`, phase `install`) blocks
installation if any `commerce_product` **type** already has a field of type `registration`. Registration
fields must live on product **variation** types, because variations are the purchasable entity. A
runtime `PreventProductTypeRegistrationField` constraint (added via `hook_entity_type_alter` to
`field_storage_config`) also blocks creating a `registration` field storage on `commerce_product` and
uninstalls the half-created storage. Fix: delete the offending field from the product type and add it
to the variation type instead.

## Setup steps

1. Create at least one registration type at `/admin/structure/registration-types` (Registration module).
2. Add a **registration** field to the product **variation** type
   (`/admin/commerce/config/product-variation-types/{type}/edit/fields`). Set the default registration
   settings on the field as desired.
3. Configure that variation type's **form display** so the registration field is editable (not disabled).
   The Registration module's own "Register" tab setting can be ignored — a checkout pane replaces it.
4. Edit each product variation and pick a registration type (unless a field default already sets one).
5. Products that have ≥1 variation with a registration type get a **Manage Registrations** local task
   on the product (see routes below).
6. (Optional) On the order-item type's **Add to cart** form display, choose the
   `commerce_registration_variation_title` widget ("Product variation title (spaces available)") to show
   remaining spaces. See [plugins/checkout.md](../plugins/checkout.md).
7. Place a checkout pane (see next section).
8. (Optional holds) Make the **Held** state the default state for new registrations and enable exactly
   one Order-Information-step pane; release holds via the registration type's hold length or by setting
   the order type to delete abandoned carts.

## Choosing the checkout pane

Exactly one of two panes must create the registrations:

- **`registration_process`** (default step `payment`) — creates one registration per order item for the
  person checking out, no data entry. It **must be placed before** the Payment Process pane, or
  registrations are never created. Use when buyers register only themselves and no extra field data is
  needed.
- **`registration_information`** (place in the **Order Information** step) — renders an inline
  registration form per space so the buyer can enter field data or register someone else. Uses a
  `checkout` form-display mode if one exists on the registration type, else the default. Use when
  registration types have extra fields or buyers may register others.

See [plugins/checkout.md](../plugins/checkout.md) for pane behavior details.

## Routes, local tasks, access

| Route | Path | Controller / form |
|---|---|---|
| `entity.commerce_product.commerce_registration.manage_registrations` | `/product/{commerce_product}/registrations` | `CommerceRegistrationController::manageRegistrations` |
| `entity.commerce_product.commerce_registration.registration_settings` | `/product/{commerce_product}/registrations/settings` | `CommerceRegistrationController::registrationSettings` |
| `entity.commerce_product.commerce_registration.broadcast` | `/product/{commerce_product}/registrations/broadcast` | `EmailProductRegistrantsForm` |

All three require `_manage_commerce_registrations_access_check: 'TRUE'` and are `_admin_route`. Local
tasks (`commerce_registration.links.task.yml`) render these under the product as **Manage Registrations**
→ Registrations / Settings / Email Registrants.

**Access model.** `ManageCommerceRegistrationsAccessCheck` (service
`commerce_registration.manage_commerce_registrations_access_checker`) allows access only if the product
has at least one variation with a registration type set **and** the account passes the Registration
module's per-variation `ManageRegistrationsAccessCheck` for that variation (it builds a synthetic
variation route match and re-delegates). Otherwise it returns `neutral` (effectively deny, hiding the
tab). This module defines **no permissions of its own** — the effective permissions are the Registration
module's per-host manage permissions, evaluated against each product variation.

- **Settings page.** When a product has a single registration-enabled variation, the Settings tab shows
  that variation's registration-settings form directly; with multiple, it shows the
  `product_registration_settings` view with per-variation edit links. A `?variation_id=` query arg
  targets one variation. The underlying editable entity is the Registration module's `registration_settings`
  entity (capacity, open/close dates, held-state, multiple-registrations, etc.) — not defined here.

## Config schema owned here

Only one key is defined by this module (`config/schema/commerce_registration.schema.yml`):
`field.widget.settings.commerce_registration_variation_title` with `label_display` (bool),
`label_text` (label), `hide_single` (bool). Views plugin schema lives in
`commerce_registration.views.schema.yml`. There is no `config/install/` default config; `config/optional/`
ships view definitions and the `registration.checkout` form mode + `registration.summary` view mode.
