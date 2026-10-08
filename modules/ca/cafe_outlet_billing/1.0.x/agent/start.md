<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cafe Outlet Billing (`cafe_outlet_billing`) — agent index
**Cafe billing form that renders line items into a TCPDF PDF invoice.**

- **Version:** 1.0.x  | **Core:** ^10 || ^11  | **PHP:** >=8.1 | Composer: `tecnickcom/tcpdf`
- **Depends on:** core `field`, `views`
- **Routes:** `/billing-form` (`cafe_outlet_billing.form`) and `/generate-bill/{items}/{cashier_id}` (`cafe_outlet_billing.generate_bill`)
- Both use the `access content` permission. `{items}` = URL-encoded JSON line items; controller sums totals and streams `application/pdf`.
- No server-side order/payment state; the PDF is built purely from the request (header shows the `system.site` name + email).
