<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Order: Invoice is a placeholder submodule of the Arch suite reserved for order invoicing; in 8.x-1.0-alpha26 it ships only an .info.yml (package "Arch TODO") and provides no functionality yet.

---

`arch_order_invoice` is declared but not implemented. Its module directory contains a single
`arch_order_invoice.info.yml` — no `.module`, routes, services, entities, config or `src/`. Enabling
it therefore adds no routes, permissions, entities or behavior; it only records a dependency on the
base `arch` module and `arch_order`, marking the intent to add invoice generation for orders in a
future release. Treat it as a not-yet-functional stub: enable it only if you are tracking the module
for when invoicing lands, and rely on `arch_order` for the actual order data. Its package label is
literally "Arch TODO".

---

- (Planned) generate invoices for Arch orders — not implemented in this release.
- Reserve the `arch_order_invoice` machine name within the Arch project.
- Declare a dependency on `arch` and `arch_order` for future invoice features.
- Serve as a placeholder shown in the module list under package "Arch TODO".
- Signal roadmap intent for order billing/invoicing to integrators.
- Enabling it currently has no runtime effect beyond its dependencies.
