<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Sample: Shopify (api_orchestrator_sample_shopify) — agent index

Shopify Storefront GraphQL demo via mock.shop. Depends on `api_orchestrator`, `api_orchestrator_integration_samples`, `api_orchestrator_mirror`. Config-only (no PHP `src/`).

## Provides
- An `api_orchestrator_service` (Shopify Storefront GraphQL, base URL mock.shop) plus GraphQL `api_orchestrator_endpoint` entities for product listing, product detail, collections and search, installed via `config/install`.
- `hook_install`/`hook_uninstall` add and clean up the sample config.

Works out of the box (mock.shop needs no auth). Point the service base URL / API key at a real Shopify Storefront to go live. Demonstrates `is_graphql` endpoints and mirror display.
