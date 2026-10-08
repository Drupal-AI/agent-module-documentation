<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Poool — agent orientation

Client-side integration for the Poool Access SaaS paywall.

- Version 1.0.x, core `^8||^9||^10`. Settings `/admin/config/services/poool` (`administer site configuration`). Public application id (regex-validated), no secret key.
- Attaches `assets.poool.fr/poool.min.js` (HTTPS) + a `poool-widget` div; `data-poool`/`data-poool-mode` on fields. Premium decided via `PooolUserIsPremiumEvent`.
- Paywall is client-side (Poool's soft-paywall model): full content is in the DOM and hidden by JS. The `poool` field stores its settings serialized. The application id is public; no secret key is stored.