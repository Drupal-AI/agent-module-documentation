<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Ajax Cart Message disables the default add-to-cart status message when the add-to-cart request was made via AJAX, avoiding a redundant message.

---

Commerce Ajax Cart Message removes the standard "added to cart" status message when the add-to-cart
action was an AJAX request. On stores that update the cart via AJAX (an off-canvas cart, a live count),
the default Drupal status message is redundant or awkward because the UI already reflects the change;
this module suppresses it in that case while leaving it intact for non-AJAX adds. It depends on
Commerce Cart.

Use it to tidy the add-to-cart UX on AJAX-driven storefronts. It is a small presentation/UX adjustment
to Commerce cart behaviour with no access or pricing implications.

---

- Suppress the add-to-cart message on AJAX.
- Avoid a redundant cart status message.
- Tidy AJAX-driven cart UX.
- Keep the message for non-AJAX adds.
- Depend on Commerce Cart.
- Support off-canvas carts.
- Work with a live cart count.
- Adjust add-to-cart behaviour.
- Remove awkward status messages.
- Improve storefront UX.
- Detect AJAX add-to-cart requests.
- Leave normal adds unchanged.
- Have no pricing implications.
- Have no access implications.
- Refine cart feedback.
- Use on AJAX storefronts.
- Hide the default cart message.
- Present a cleaner add flow.
- Complement AJAX cart widgets.
- Reduce message noise.
