<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EtherAPI (etherapi) — agent index

**Accepts Ethereum/crypto payments (etherapi.net) for the Basket store, confirmed by a signed status callback.**

- **Version:** 1.0.x  •  core: `^9 || ^10 || ^11`  •  package: Online store
- **Configure:** `etherapi.settings` → `/admin/config/development/etherapi` (permission *access etherapi settings*, `restrict access: true`).
- **Routes:** `etherapi.pages` `/etherapi/{page_type}` (`_permission: access content`) — `pay` renders `PaymentForm` for a `new` payment (`?pay_id=`); `status` is the etherapi.net callback.
- **Service:** `EtherAPI` (`@database`) — `load()`, `update()` on table `payments_etherapi` (parameterized queries).
- **Hooks:** `hook_etherapi_payment_params_alter`, `hook_etherapi_api_alter`. Basket plugin `BasketEtherAPI`.

**Access:** the `access content` route is a **payment callback** — the controller does not fetch any request-supplied URL. The `status` branch verifies a `sha1(...:apiKey)` signature (per-currency API key as shared secret) before completing the order, and optionally checks a source-IP allow-list. Set an API key for every currency (`src/Controller/Pages.php:89,109`). Settings route is properly restricted.

See [configure/settings.md](configure/settings.md) and [api/callback.md](api/callback.md)
