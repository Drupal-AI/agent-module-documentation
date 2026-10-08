<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Orchestrator - Sample: Magento (api_orchestrator_sample_magento) — agent index

Magento 2 GraphQL demo integration. Depends on `api_orchestrator`, `api_orchestrator_integration_samples`, `api_orchestrator_mirror`. Config-only (no PHP `src/`).

## Provides
- An `api_orchestrator_service` (Magento 2 GraphQL) plus ten GraphQL `api_orchestrator_endpoint` entities (products, categories, CMS, utilities) installed via `config/install`.
- `hook_install`/`hook_uninstall` add and clean up the sample config.

Not zero-config: set the service `base_url` (and auth) to your Magento GraphQL endpoint. Demonstrates `graphql_query`/`graphql_variables`/`graphql_operation_name` and type-aware variable replacement; pairs with `api_mirror` for display.
