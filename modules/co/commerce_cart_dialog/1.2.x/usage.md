<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Displays the Drupal Commerce cart inside a modal or off-canvas (slide-in) dialog so shoppers can view and edit their cart without leaving the current page.

---
The module adds a dedicated `/cart/dialog` route whose controller extends Commerce's own `CartController::cartPage()` — it renders exactly the standard cart page, but on a separate route so `hook_form_alter()` can attach `use-ajax-submit` behaviour to the cart's update and remove buttons. Submitting inside the dialog returns an `AjaxResponse` that refreshes or closes the dialog (`OpenDialogByPathCommand`, `CloseModalDialogCommand`/`CloseDialogCommand`) according to the configured dialog type. A `CartDialogBlock` block and a `DialogSettingsHelper` (registered as a `render.main_content_renderer`) provide the trigger and dialog rendering; settings live at `/admin/commerce/config/ccd` behind `access commerce administration pages`.

The `/cart/dialog` route uses `_access: 'TRUE'`, matching core Commerce's own cart page which is likewise open to everyone: it takes no cart/order ID argument and simply renders `parent::cartPage()`, which resolves carts for the **current** session/user through the cart provider — so there is no way to address another user's cart and no mutation beyond the standard, session-scoped cart operations. The settings form is admin-permission gated.
---
- Show the cart in a modal popup on click.
- Show the cart in an off-canvas slide-in panel.
- Let shoppers update quantities without a page reload.
- Remove line items via Ajax inside the dialog.
- Add a cart trigger block to the header.
- Close the dialog automatically after updating the cart.
- Keep customers on the product page while editing the cart.
- Configure modal vs off-canvas at `/admin/commerce/config/ccd`.
- Reuse the standard Commerce cart form in a dialog.
- Provide a mini-cart-style experience without custom JS.
- Refresh the dialog contents after an Ajax submit.
- Show status messages inside the cart dialog.
- Improve conversion with a frictionless cart view.
- Integrate the cart dialog with a Colorbox-style renderer.
- Place the cart block in any region or layout.
- Offer a quick "view cart" from anywhere on the site.
- Style the dialog via Commerce cart templates.
- Keep the full cart page available alongside the dialog.