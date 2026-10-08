<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Enforces a minimum order total on the Commerce cart, driven by a per-store field, and gives shoppers visual feedback on how close they are to reaching it.

---
The minimum is read from a `field_store_min_order` field on the order's Commerce Store (via `_commerce_min_order_get_minimum()`), so different stores can require different thresholds. On the default cart form the module (`hook_form_BASE_FORM_ID_alter`) injects a themed progress element (`commerce_min_order_progress`) showing current total, minimum, remaining amount and a percentage; while the total is below the minimum it disables the checkout button and adds a submit-time validation callback that sets a form error with the formatted shortfall.

All logic is server-side form alteration and validation on the standard cart form — there are no routes, permissions, services or custom endpoints, and the check re-runs on submit so a disabled button alone is not the only guard. Setup is: add a `field_store_min_order` field to your Store type and set the amount per store; the cart enforces it automatically.
---
- Require a minimum spend before checkout is allowed.
- Set a different minimum per Commerce store.
- Show a progress bar toward the minimum order amount.
- Display how much more the customer must add.
- Disable the checkout button until the minimum is met.
- Block checkout server-side with a validation error.
- Show the shortfall as a formatted currency amount.
- Encourage larger baskets with a visual meter.
- Enforce wholesale minimum-order policies.
- Communicate the minimum clearly on the cart page.
- Prevent low-value orders that are unprofitable to fulfil.
- Localise the minimum-order message via translation.
- Reuse the store's minimum across all its carts.
- Combine with promotions to nudge order value.
- Give immediate feedback as the cart total changes.
- Validate the minimum even if the button is re-enabled client-side.
- Configure the threshold without writing code (a store field).
- Theme the progress element to match the storefront.