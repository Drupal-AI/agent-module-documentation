# Mechanics — how the AJAX add-to-cart works

## Attaching the AJAX behavior

`commerce_ajax_atc_form_commerce_order_item_add_to_cart_form_alter()` runs on the add-to-cart
form. It reads the product's render display for the current view mode, and if the `variations`
component has `third_party_settings.commerce_ajax_atc.enable_ajax` set, calls
`commerce_ajax_atc_alter_submit()` which:

- adds an `#ajax` callback (`commerce_ajax_atc_form_submit`) to `actions.submit`
  (`disable-refocus`, throbber "Adding to Cart"),
- adds a message container `#add-to-cart-message-container-<variation_id>`,
- attaches `core/drupal.dialog.ajax` (for `modal_dialog`) or the Colorbox libraries + width/height
  `drupalSettings` (for `colorbox`).

The same pattern is applied to the `commerce_vado_group_add_to_cart` form (if `commerce_vado` is
enabled) and, when `enable_variation_cart_form_ajax` is on, to the Commerce Variation Cart Form.

## The AJAX callback

`commerce_ajax_atc_form_submit()` builds an `AjaxResponse`:

1. On no errors, re-renders the cart block (first block with plugin `commerce_cart`) and issues an
   `HtmlCommand` on `.cart--cart-block` — this is the in-place cart refresh.
2. Builds the success message (`success_message`, `[variation_title]` replaced with the variation
   label) and optional View cart / Checkout / Close buttons per the config booleans.
3. Emits the confirmation command based on `pop_up_type`:
   - `non_modal` → `MessageCommand` into the message container.
   - `modal_dialog` → `OpenModalDialogCommand($title, $content, {width,height})`.
   - `colorbox` → renders content and issues Colorbox Load's `OpenCommand`.
4. On validation errors, replaces the message container with `status_messages`.

## Suppressing the default Commerce message

`CommerceAjaxAtcServiceProvider::alter()` re-classes the core `commerce_cart.cart_subscriber`
service to `Drupal\commerce_ajax_atc\EventSubscriber\AjaxCartEventSubscriber` (and injects the
request stack). That subscriber suppresses Commerce's normal server-side "added to your cart"
status message on AJAX requests, so only this module's pop-up shows.

## Twig template + view mode

When `use_twig_template` is TRUE, the pop-up content uses the `commerce_ajax_atc_popup` theme
hook (template `commerce-ajax-atc-popup.html.twig`), rendering the purchased variation in the
dedicated **`commerce_ajax_atc_popup`** view mode
(`core.entity_view_mode.commerce_product_variation.commerce_ajax_atc_popup`, installed by the
module). Variables include `product_variation`, `success_message`, the button markup, and
`cart_url`.

## Close route

`/close-modal-form` (`commerce_ajax_atc.closeModal` → `ModalController::closeModalForm`,
permission `access content`) returns an AJAX command that closes the dialog; it backs the "close"
button in modal/colorbox pop-ups.
