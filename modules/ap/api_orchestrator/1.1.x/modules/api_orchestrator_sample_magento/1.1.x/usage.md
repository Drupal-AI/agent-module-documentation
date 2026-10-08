A Magento 2 GraphQL sample for API Orchestrator with ten pre-configured endpoints across products, categories, CMS and utilities.

---

This sample installs a Magento 2 GraphQL integration for API Orchestrator — a service plus ten pre-configured GraphQL endpoints covering products, categories, CMS content and utility queries — to demonstrate GraphQL usage, variable typing and token handling. Point the service's base URL (and any auth) at your own Magento GraphQL endpoint to use it against a real store; it pairs with the Mirror submodule to display results. Requires `api_orchestrator`, `api_orchestrator_integration_samples` and `api_orchestrator_mirror`.

---

- Model a Magento 2 GraphQL integration without hand-writing config.
- Query products, including by SKU or category.
- Fetch category trees and details.
- Retrieve CMS pages/blocks.
- Run Magento utility/store-config queries.
- See type-aware GraphQL variables (string vs numeric) in action.
- Point the sample service at your own Magento GraphQL endpoint.
- Mirror Magento products/categories into a local listing.
- Use it as a starting template for a production Magento integration.
