<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Tax Conditions — agent index

Adds **condition plugins to Commerce tax types** so a tax rate applies only when the order matches business
rules (total, store, customer). Version **1.2.x**. Core `^9.1 || ^10`. Depends on `commerce_tax` (>= 8.x-2.20).

Site-builder feature only — no routes, no own permissions, no callbacks. Conditions are configured on the tax
type form (`/admin/commerce/config/tax-types`) and evaluated per order at tax-calculation time. No untrusted
input path; security surface is limited to the admin tax UI. Verify computed tax on a test order.
