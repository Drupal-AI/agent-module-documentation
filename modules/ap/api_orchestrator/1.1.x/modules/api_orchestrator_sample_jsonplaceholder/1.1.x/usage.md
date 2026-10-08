A ready-to-use JSONPlaceholder REST sample for API Orchestrator: one service plus five endpoints that work with no configuration.

---

This sample installs an API Orchestrator service pointing at jsonplaceholder.typicode.com plus five REST endpoints (e.g. `jp_list_posts`), so you can exercise the module immediately with no setup. It is the quickest way to see queued/direct requests, token replacement and the request log in action, and it pairs with the Mirror submodule to display the fetched posts as a listing. Uninstalling removes the sample service and its endpoints. Requires `api_orchestrator`, `api_orchestrator_integration_samples` and `api_orchestrator_mirror`.

---

- Try API Orchestrator end-to-end with zero configuration.
- Run `drush api-orchestrator:request jp_list_posts` to fetch sample data.
- See queued vs direct execution using the provided endpoints.
- Inspect logged requests, trace IDs and cURL commands for real calls.
- Use it as a reference for defining REST services and endpoints.
- Mirror JSONPlaceholder posts into a filterable listing.
- Verify a fresh install works before wiring up a real API.
- Remove all sample config cleanly on uninstall.
