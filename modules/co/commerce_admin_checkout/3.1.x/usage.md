<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce: Admin Checkout enables administrators to use the checkout form to create orders for customers, gated by dedicated permissions.

---

Commerce: Admin Checkout enables Drupal Commerce administrators to use the checkout form to create
orders on behalf of customers — placing orders for a customer (phone/in-person sales), editing cart items
during checkout, and completing payment as an admin. It depends on Commerce Checkout and Order and ships a
`commerce_admin_payment` submodule.

The capability is properly permission-gated: dedicated permissions — `access checkout as a different user`,
`edit cart items during checkout`, `configure admin checkout settings`, plus core `access checkout` — are
checked (via `AccessResult::allowedIfHasPermission`) before an admin can check out as another user or edit
their cart. So creating orders for customers requires the explicit admin permission, not just any access.
Use it for assisted/phone-order workflows. When adopting, grant `access checkout as a different user` only
to trusted staff (it lets them place orders as/for other users and see their cart), and configure the admin
checkout settings. Standard Commerce order/payment concepts apply.

---

- Create orders for customers as admin.
- Use checkout on behalf of a user.
- Support phone/in-person orders.
- Edit cart items during checkout.
- Complete payment as an admin.
- Depend on Commerce Checkout and Order.
- Gate by access checkout as a different user.
- Check permissions before admin checkout.
- Grant the permission only to trusted staff.
- Use the commerce_admin_payment submodule.
- Configure admin checkout settings.
- Place orders for customers.
- Support assisted checkout.
- Require the explicit admin permission.
- Handle customer carts as staff.
- Create orders on behalf.
- Complete customer orders.
- Configure the workflow.
- Gate cart editing by permission.
- Enable admin checkout.
