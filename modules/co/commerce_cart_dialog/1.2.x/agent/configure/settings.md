<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Cart Dialog — configuration & behaviour

## Settings form
- Route `commerce_cart_dialog.settings` → `/admin/commerce/config/ccd` (menu under Commerce config).
- Permission: `access commerce administration pages`.
- `DialogSettingsHelper::getDialogType()` chooses **modal** vs **off-canvas**; the form (`src/Form/SettingsForm.php`) stores dialog type/options.

## How the dialog works
1. `/cart/dialog` renders the standard Commerce cart page (controller extends `CartController`).
2. `commerce_cart_dialog_form_alter()` (only on that route, for `views_form_commerce_cart_form*`) adds `use-ajax-submit` + `#dialog_reload` to the update-cart and remove-item buttons and injects `status_messages`.
3. On submit, `commerce_cart_dialog_form_submit_for_dialog()` returns an `AjaxResponse` that closes the modal (`CloseModalDialogCommand`) or off-canvas (`CloseDialogCommand`) and reloads via `OpenDialogByPathCommand`.
4. Place the `CartDialogBlock` (and/or link to `/cart/dialog`) as the dialog trigger.

## Access note
`/cart/dialog` is `_access: 'TRUE'` like the core cart page; it only ever operates on the current session/user's cart (no ID parameter), so exposing it to anonymous shoppers is expected and safe.
