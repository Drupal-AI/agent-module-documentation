<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Order statistics is a placeholder submodule of the Arch suite reserved for order/sales reporting; in 8.x-1.0-alpha26 it ships only an .info.yml (package "Arch TODO") and provides no functionality yet.

---

`arch_order_statistics` is declared but not implemented. Its directory contains a single
`arch_order_statistics.info.yml` — no `.module`, routes, services, entities, config or `src/`.
Enabling it adds no routes, permissions, reports or behavior; it only records a dependency on the base
`arch` module and `arch_order`, marking the intent to add order/sales statistics in a future release.
Its package label is "Arch TODO". For actual order data today, query the `order` entity from
`arch_order` (which also provides a dashboard order-count panel and Views integration).

---

- (Planned) report on orders / sales — not implemented in this release.
- Reserve the `arch_order_statistics` machine name within the Arch project.
- Declare a dependency on `arch` and `arch_order` for future reporting features.
- Serve as a placeholder shown in the module list under package "Arch TODO".
- Signal roadmap intent for sales analytics to integrators.
- Enabling it currently has no runtime effect beyond its dependencies.
