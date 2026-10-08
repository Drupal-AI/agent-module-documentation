<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# POS to SynCart (syncart_pos) — agent index

Syncart submodule adding point-of-sale support. Core `^11 || ^12`. Package Synapse.
Depends on `syncart`, `cache_alter`.

## Provides
- **Config install** (`config/install/**`): `commerce_order.commerce_order_type.pos`,
  `commerce_checkout.commerce_checkout_flow.pos`, `commerce_number_pattern.pos`, pos order
  form/view displays, and `field.field.commerce_order.pos.shipments`.
- **Route** (`syncart_pos.routing.yml`): `syncart_pos.set_coockie` → `/syncart_pos/set_coockie`
  → `Controller\PosController::setCookie()` — sets a `cache_context=pos` cookie (path `/`, far-future
  expiry) and redirects to `/`.
- `syncart_pos.module`, `syncart_pos.install`. No services, permissions, or Drush commands.

## Parent
See `../../../3.0.x/agent/start.md` for the Syncart module.
