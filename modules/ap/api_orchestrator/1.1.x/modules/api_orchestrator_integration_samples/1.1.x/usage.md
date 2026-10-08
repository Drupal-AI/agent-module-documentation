A lightweight container module for API Orchestrator's optional sample integrations; enable the individual sample submodules underneath it.

---

Integration Samples is a parent/container module that carries no configuration of its own. It exists so the bundled sample integrations (JSONPlaceholder, Shopify, Magento) and the sample alert rules can depend on a common enablement point. Enable one of the individual sample submodules to install ready-to-run API service and endpoint config entities that demonstrate REST and GraphQL usage. Requires `api_orchestrator`.

---

- Group the bundled sample integrations under one enable/disable point.
- Enable the JSONPlaceholder REST sample for a zero-config test integration.
- Enable the Shopify (mock.shop) GraphQL sample.
- Enable the Magento 2 GraphQL sample.
- Enable the sample alert rules package.
- Use the samples as reference configuration when building your own services/endpoints.
- Keep demo config isolated from production integrations.
