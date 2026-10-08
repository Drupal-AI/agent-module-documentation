<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Integration Samples (api_orchestrator_integration_samples) — agent index

Container module for the bundled sample integrations. Depends on `api_orchestrator`. No code, routes, entities, plugins, permissions or config schema — only an `.info.yml` and `.install`.

Enable one of the dependent sample submodules to install demo config:
- `api_orchestrator_sample_jsonplaceholder` — JSONPlaceholder REST (also needs `api_orchestrator_mirror`).
- `api_orchestrator_sample_shopify` — Shopify Storefront GraphQL via mock.shop (needs mirror).
- `api_orchestrator_sample_magento` — Magento 2 GraphQL (needs mirror).
- `api_orchestrator_sample_alerts` — sample alert rules (needs `api_orchestrator_alerts`).

Each sample ships service/endpoint (and, for samples, mirror/alert) config entities via `config/install` and removes them on uninstall.
