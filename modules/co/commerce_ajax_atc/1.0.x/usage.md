Commerce Ajax Add to Cart makes Drupal Commerce's "Add to cart" form submit over AJAX — refreshing the cart block in place and showing a configurable confirmation (a non-modal message, a modal dialog, or a Colorbox pop-up) instead of a full page reload.

---

You enable the behavior per product display: the module adds an **"Enable Ajax" checkbox** (a `commerce_ajax_atc` third-party setting `enable_ajax`) to the `commerce_add_to_cart` field formatter (and the `commerce_vado_group_add_to_cart` formatter) on a product's *Manage display*, stored on the `variations` component of that `entity_view_display`. When set, `hook_form_..._alter` attaches an AJAX callback (`commerce_ajax_atc_form_submit`) to the add-to-cart submit button; on success it replaces the `.cart--cart-block` markup with a freshly rendered cart block and shows the confirmation according to global settings. Those global settings live in the `commerce_ajax_atc.settings` config object, edited at *Commerce → Configuration → Ajax → Ajax add to cart pop-up settings* (`/admin/commerce/config/ajax-settings`, permission `access ajax atc administration pages`). The key setting is `pop_up_type`: `non_modal` (a Drupal `MessageCommand`), `modal_dialog` (a core `OpenModalDialogCommand`, with `ajax_modal_title`/`ajax_modal_width`/`ajax_modal_height`), or `colorbox` (needs Colorbox Load, with `colorbox_width`/`colorbox_height`). Additional settings control the success message text (with a `[variation_title]` token), the cart link text, and optional **View cart / Checkout / Close** buttons and their labels; `use_twig_template` switches the pop-up to the `commerce_ajax_atc_popup` theme hook, which renders the variation in the dedicated `commerce_ajax_atc_popup` view mode. A service-provider swap replaces `commerce_cart.cart_subscriber` with `AjaxCartEventSubscriber` so Commerce's default server-side "added to cart" message is suppressed in favour of the AJAX confirmation. There is a separate `enable_variation_cart_form_ajax` toggle for the Commerce Variation Cart Form integration. The module requires Commerce Cart.

---

- Add products to the cart without a full page reload on a catalog or product page.
- Refresh the cart block/flyout automatically after an add-to-cart.
- Show a modal dialog confirmation ("Product added to cart") after adding an item.
- Show a lightweight non-modal inline message instead of a modal.
- Render the add-to-cart confirmation inside a Colorbox pop-up (with Colorbox Load).
- Add a "View cart" button to the confirmation pop-up.
- Add a "Checkout" button so shoppers can jump straight to checkout from the pop-up.
- Add a "Continue shopping" / close button to the pop-up.
- Customize the success message text and use the [variation_title] token in it.
- Change or remove the "your cart" link text in the confirmation message.
- Enable AJAX add-to-cart only on specific product view modes (per display).
- Keep the standard add-to-cart form on some displays and AJAX on others.
- Set a custom modal title, width and height for the confirmation dialog.
- Set Colorbox width/height for the pop-up.
- Use a Twig template + dedicated view mode to render a rich product confirmation pop-up.
- Suppress Commerce's default "added to your cart" status message in favour of the pop-up.
- Improve conversion by reducing friction on the add-to-cart step.
- Provide AJAX add-to-cart for the Commerce Variation Cart Form module.
- Provide AJAX add-to-cart for Commerce VADO group add-to-cart forms.
- Localize the pop-up button labels (view cart / checkout / close) per site.
- Give a single-page-app feel to a classic Commerce storefront without decoupling.
- Restrict who can change the pop-up settings via a dedicated admin permission.
