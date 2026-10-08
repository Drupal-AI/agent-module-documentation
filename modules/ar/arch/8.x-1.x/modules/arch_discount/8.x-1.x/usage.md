<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Discount is a placeholder submodule of the Arch suite reserved for product discounts/promotions; in 8.x-1.0-alpha26 it ships only an .info.yml (package "Arch TODO") and provides no functionality yet.

---

`arch_discount` is declared but not implemented. Its directory contains a single
`arch_discount.info.yml` (description "Handle discounts for products") — no `.module`, routes,
services, entities, config or `src/`. Enabling it adds no routes, permissions, price modifiers or
behavior; it only records dependencies on `arch_price`, `arch_product` and `arch_order`, marking the
intent to add discount/promotion handling in a future release. Its package label is "Arch TODO". For
pricing behavior today, use `arch_price` (multiple prices, price types, price negotiator); this
module does not yet plug into it.

---

- (Planned) apply discounts/promotions to products — not implemented in this release.
- Reserve the `arch_discount` machine name within the Arch project.
- Declare dependencies on `arch_price`, `arch_product` and `arch_order` for future discount features.
- Serve as a placeholder shown in the module list under package "Arch TODO".
- Signal roadmap intent for promotions/discounts to integrators.
- Enabling it currently has no runtime effect beyond its dependencies.
