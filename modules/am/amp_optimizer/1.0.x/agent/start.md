<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AMP Optimizer (amp_optimizer) — agent index
**Applies the AMP Toolbox TransformationEngine to rendered HTML responses for anonymous users.**

- **Version:** 1.0.x
- **Core:** ^8.9 || ^9 || ^10
- **Route:** `amp_optimizer.settings` → `/admin/config/services/amp/optimizer` (permission `administer site configuration`)
- **Service/subscriber:** `OptimizerSubscriber` on `KernelEvents::RESPONSE` (priority -9999); returns early for authenticated users and non-HTML responses.
- **Library:** ampproject/amp-toolbox (composer).
- **Security:** Settings route is permission-gated; response transformation runs only for anonymous users; no mutating or anonymous endpoints. No external network calls in module code.
