# Commerce plugin instances (checkout panes, inline form, widgets, selection, constraint)

This module defines **no new plugin types**. It ships plugin *instances* that integrate with Commerce
and the Registration module. IDs below are real annotation ids.

## Checkout panes (`@CommerceCheckoutPane`)

| id | Class | Default step | Purpose |
|---|---|---|---|
| `registration_process` | `Plugin\Commerce\CheckoutPane\RegistrationProcess` | `payment` | Silently creates one registration per order item for the buyer. **Must be ordered before** the Payment Process pane. No UI. |
| `registration_information` | `Plugin\Commerce\CheckoutPane\RegistrationInformation` | (place in Order Information) | Renders an inline registration form per space; lets the buyer enter field data / register others. |

`registration_information` details:
- `isVisible()`: shown only when the cart holds ≥1 item configured for registration.
- `buildPaneForm()`: one `registration` inline form per space (`quantity` loop), reusing any already-attached
  registration or creating a new one (`author_uid` = current user, `langcode` = current language).
- `validatePaneForm()`: when the host's `multiple_registrations` setting is off, rejects duplicate
  registrant emails within the same item.
- `submitPaneForm()`: resets and re-attaches the edited registrations to the item; fills `anon_mail` from
  the order email for anonymous customers if still empty (`ensureRegistrationEmail`).
- `buildPaneSummary()`: renders each registration in the `summary` view mode.
- Form display used: `checkout` mode if present, else the default (`EntityFormDisplay::collectRenderDisplay($registration, 'checkout')`).

## Inline form (`@CommerceInlineForm` id `registration`)

`Plugin\Commerce\InlineForm\Registration` (extends Commerce `EntityInlineFormBase`). Required config
`order_id` (nonzero, else `\RuntimeException`). Builds the registration form via the `checkout` form
display and `RegisterForm::alterRegisterForm()`. Hides the `count` and `created` fields (one space per
registration keeps aggregate spaces ≤ item quantity). `validateInlineForm()` normalizes the
"who is registering" choice (`REGISTRATION_REGISTRANT_TYPE_ME/USER/ANON`) — clearing the unused of
`user_uid` / `anon_mail`, and forcing `user_uid` = current user for self-registration.
`submitInlineForm()` sets `order_id` from config and saves.

## Register form override

`hook_entity_type_alter` sets the `registration` entity's `register` form class to
`Form\RegisterForm` (extends the Registration module's `RegisterForm`). It gives each host a unique form
id and per-host "who is registering" field so multiple variations' register forms can coexist on one
product page. Only relevant if you display the register field directly instead of the add-to-cart form;
the typical flow uses the inline form above.

## Add-to-cart widgets (`@FieldWidget`, field type `entity_reference`)

| id | Class (extends `ProductVariationTitleWidget`) | Shows |
|---|---|---|
| `commerce_registration_variation_title` | `CommerceRegistrationVariationTitleWidget` | Variation title **with spaces available**. Settings: `label_display`, `label_text`, `hide_single`. |
| `commerce_registration_variation_details` | `CommerceRegistrationVariationDetailsWidget` | Variation title with registration details. |

Apply on the order-item type's **Add to cart** form display for the purchased-entity reference field.

## Entity-reference selection & form element

- `@EntityReferenceSelection` id `commerce_registration_variation` (`ProductVariationSelection`) — limits
  a reference to the registration-enabled variations of a given product (used by the broadcast form's
  recipient selector, via `#selection_settings: {product_id}`).
- `@FormElement` id `commerce_registration_entity_select` (`Element\EntitySelect`) — an "all vs. specific"
  entity picker used by the Email Registrants form.

## Validation constraint

`@Constraint` id `PreventProductTypeRegistrationField` (validator
`PreventProductTypeRegistrationFieldValidator`) — attached to `field_storage_config`; forbids creating a
`registration` field storage whose target entity type is `commerce_product`, and cleans up the partially
created storage. Registration fields belong on `commerce_product_variation`.

## Availability checker & order processor

These are tagged Commerce services rather than annotated plugins, but they are part of the checkout
integration — see [api/lifecycle.md](../api/lifecycle.md) for `CommerceRegistrationAvailabilityChecker`
(server-side capacity check on the requested quantity) and `RegistrationOrderProcessor` (prunes invalid
items).
