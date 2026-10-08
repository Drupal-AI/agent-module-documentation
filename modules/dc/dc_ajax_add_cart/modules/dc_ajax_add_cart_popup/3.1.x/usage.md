<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Commerce AJAX Add to Cart that opens a modal dialog confirming "The item has been added to your cart" (showing the product variation and a link to the cart) after an AJAX add-to-cart.

---

Enabling `dc_ajax_add_cart_popup` makes the AJAX add-to-cart flow finish with a Drupal modal
dialog instead of just a status message. It works via an event subscriber
(`AjaxAddToCartPopupSubscriber`): on the `commerce_cart` `CART_ENTITY_ADD` event it records the
purchased product variation, and on the kernel `RESPONSE` event — only when the response is an
`AjaxResponse` and something was added — it renders that variation in a dedicated
`dc_ajax_add_cart_popup` product-variation view mode and adds an `OpenModalDialogCommand` (700px
wide) to the response. A `hook_form_alter` on the ajax add-to-cart form attaches
`core/drupal.dialog.ajax` and sets `disable-refocus` on the submit `#ajax`. The dialog markup comes
from the `dc_ajax_add_cart_popup` theme hook / `dc-ajax-add-cart-popup.html.twig` template
(variables: the rendered variation, the variation entity, and the cart URL). A `config/optional`
view mode for `commerce_product_variation` is provided so you can control which fields show in the
popup. Depends only on `dc_ajax_add_cart`.

---

- Show a modal "added to cart" confirmation after an AJAX add-to-cart.
- Reassure customers their item was added without leaving the page.
- Display the added product variation (image, title, price) inside the popup.
- Offer a "View your cart" link straight from the confirmation dialog.
- Control which variation fields appear in the popup via the `dc_ajax_add_cart_popup` view mode.
- Enable a richer confirmation UX than a plain status message.
- Keep the popup styling/markup themeable via the provided Twig template.
- Turn the confirmation popup on or off simply by enabling/disabling the submodule.
- Use Drupal core's dialog system (no extra JS library) for the modal.
- Upsell or cross-sell by customising the popup view mode to show related info.
- Give shoppers an explicit next step (continue shopping vs go to cart).
- Confirm each variation added when a page has multiple add-to-cart forms.
- Localise the confirmation text (it uses translatable strings).
- Avoid a full page reload while still giving strong add-to-cart feedback.
- Pair with `dc_ajax_add_cart_views` for a fully ajaxified add/confirm/update cart experience.
