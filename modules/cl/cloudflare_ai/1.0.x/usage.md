<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare AI provides the AI Gateway client and provisionable AI Gateway / Vectorize primitives.

---

Cloudflare AI provides the AI-group resources for the Cloudflare suite — the AI Gateway client plus provisionable primitives (an AI Gateway and a Vectorize index) with their data-plane clients — built on the Cloudflare API and Cloudflare SDK. It lets Drupal provision and use Cloudflare's AI Gateway (for routing/caching AI calls) and Vectorize (vector database).

Credentials are handled by the Cloudflare SDK (settings.php/env). It underpins the Cloudflare AI Gateway provider. Depends on `cloudflare_sdk` and `cloudflare_api`; supports Drupal 10.5+, 11, and 12.

---

- Provide Cloudflare AI-group resources.
- Offer an AI Gateway client.
- Provision an AI Gateway.
- Provision a Vectorize index.
- Provide data-plane clients.
- Route/cache AI calls via the gateway.
- Use Cloudflare's vector database.
- Build on Cloudflare API + SDK.
- Handle credentials via the SDK (settings.php/env).
- Depend on `cloudflare_sdk` and `cloudflare_api`.
- Support Drupal 10.5+, 11, and 12.
- Underpin the AI Gateway provider.
- Manage AI resources
- Configure Vectorize
- Support AI infrastructure.
- Provision primitives.
- Integrate Cloudflare AI.
- Keep secrets secure
