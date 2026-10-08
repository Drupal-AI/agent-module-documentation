<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Add to Cart Ajax (commerce_addtocart_ajax) — agent index

**Ajaxifies the Drupal Commerce add-to-cart form** so a product is added in place, with no full
page reload: the submit button gets `use-ajax` and an `#ajax` callback, and the response replaces
the cart block and the status-messages region. Pure UX/form-alter module — the add-to-cart
operation still runs through Commerce's own `AddToCartForm` (access, product/variation, price and
quantity are all handled by Commerce core; this module changes only how the form submits).

Package `Commerce`. Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Installed **2.0.1**
(version dir `2.0.x`). A fork by goz of the older *Ajax add to cart* module, deliberately minimal
(no modal feature).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce`** and **`commerce:commerce_cart`** (both required).
- Composer (`composer.json`): `drupal/commerce ^2.0 || ^3.0`, `drupal/core ^10.1 || ^11 || ^12`.

## What it provides (from source)

- **`hook_form_alter`** (`Hook/CommerceAddtocartAjaxHooks::formAlter`, dispatched from the legacy
  `.module` shim): when the form's `callback_object` is a `commerce_cart` `AddToCartFormInterface`,
  calls `AjaxCartHelper::ajaxAddToCartAjaxForm()`. That adds a hidden `form_id` field, appends the
  `use-ajax` class + the `commerce_addtocart_ajax/addtocart.ajax` library to the submit button, and
  sets `#ajax` with `callback => 'commerce_addtocart_ajax_ajax_validate'` (event `click`, throbber
  "Adding to cart …").
- **AJAX callback** `commerce_addtocart_ajax_ajax_validate($form, $form_state)` in `.module` —
  builds an `AjaxResponse` via `AjaxCartHelper::ajaxAddToCartAjaxResponse()`. It issues
  `ReplaceCommand('.block-commerce-cart', <rendered cart block>)` and, when there are messages,
  `ReplaceCommand(<status_messages_selector>, <#type: status_messages>)`. The cart block is the
  first visible `commerce_cart` block on the page (`BlockRepository::getVisibleBlocksPerRegion()`),
  rendered for the **current session** via the block view builder — so it reflects only the current
  user's/session's cart.
- **`hook_preprocess_block`** (`preprocessBlock`): adds the `block-commerce-cart` class to any
  `commerce_cart` base-plugin block, giving the ReplaceCommand its target selector.
- **Settings form** `Form/CommerceAddToCartAjaxSettingsForm` (route
  `commerce_addtocart_ajax.settings` → `/admin/commerce/config/commerce-addtocart-ajax`, menu link
  under Commerce → Configuration). Single field **`status_messages_selector`** (CSS selector where
  status messages are injected after the AJAX call). Guarded by permission
  **`administer commerce addtocart ajax`** (`restrict access: TRUE`).
- **Config** `commerce_addtocart_ajax.settings` with config schema; install default selector is
  **`[data-drupal-messages],[data-drupal-messages-fallback]`** (same value is the in-code fallback).
- **Library** `commerce_addtocart_ajax/addtocart.ajax` = `js/addtocartajax.js` (depends on
  `core/drupal.ajax`). The JS monkey-patches `Drupal.Ajax.prototype.beforeSubmit` once so that, for
  this module's callback, any `/views/ajax` prefix is stripped from the request URL (fixes
  add-to-cart forms rendered inside a View).
- **`hook_help`** for `help.page.commerce_addtocart_ajax`.
- Service `commerce_addtocart_ajax.helper` (`AjaxCartHelper`, args: entity_type.manager,
  config.factory, messenger, block.repository, renderer) and the autowired hook class.

## Notes

- No custom AJAX route or controller: the only route is the permission-gated admin settings form.
  The `#ajax` callback is reached through Drupal's standard form pipeline (form build/validate,
  form token), and cart mutation is performed by Commerce's own AddToCartForm submit handlers.
- Single-surface module; no `agent/` subdocs are warranted. See also [../usage.md](../usage.md)
  and the human guide under [../human-docs/index.md](../human-docs/index.md).
