<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Permissions by Type generates a pair of permissions for every Commerce product type: 'view <type> commerce_product' and 'add <type> commerce_product to cart'. This lets you expose or gate products and their add-to-cart buttons per bundle and per role -- for example, wholesale products only visible/purchasable by a wholesale role.

---

Install and enable the module (depends on commerce_cart). Dynamically generated permissions then appear on /admin/people/permissions for each product type; assign them to roles. View access is added via hook_commerce_product_access (AccessResult::allowedIfHasPermission with the user.permissions cache context). The add-to-cart form is altered to hide the purchase widgets and show a login/denied message when the current user lacks the per-type add permission. To make the view permission restrictive, remove core Commerce's blanket product-view grant so only the per-type permission allows viewing.

---

- Generate view/add permissions per product type.
- Gate product viewing by bundle and role.
- Gate add-to-cart by bundle and role.
- Hide add-to-cart widgets for unpermitted users.
- Show a 'log in to buy' link to anonymous users.
- Show an access-denied message to logged-in users.
- Add view access via hook_commerce_product_access.
- Apply the user.permissions cache context.
- Integrate with the Commerce cart add form.
- Assign permissions on the standard permissions page.
- Support wholesale/members-only product catalogues.
- Combine with removing the default product-view grant.
- Use AccessResult for view access decisions.
- Provide permission callbacks for dynamic bundles.
- Restrict sensitive product types to specific roles.
- Work with any number of product types.
