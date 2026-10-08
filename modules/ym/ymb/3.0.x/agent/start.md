<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yandex Money Blocks (ymb) — agent index

**A configurable block rendering a payment form that directs funds to a Yandex.Money wallet.**

- **Version:** 3.0.x (dev-3.0.x)
- **Core:** ^9 || ^10 || ^11
- **Block:** `ymb_ymb` ("Yandex Money Block") — per-instance config: `receiver`, `target`, `sum` (default 200), `url`, `description`
- **Theme:** `ymb_block` template renders the payment form
- No routes, permissions or services; all state is block config.

**Security:** display-only block; payment and any card handling occur on Yandex's side (no callback/gateway logic in Drupal). Placement/config is gated by normal block-admin permission. No anonymous mutating endpoints.
