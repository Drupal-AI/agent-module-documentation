ECA integration for API Orchestrator: trigger API requests from no-code Events–Conditions–Actions workflows and branch on API responses.

---

The ECA submodule connects API Orchestrator to the ECA module. It ships ECA actions to send a pre-configured endpoint request (queued or direct) and to make a direct HTTP request through an API service (with method, URL, headers and body), ECA conditions to test the last API response (contains text, status code equals, service exists), and ECA events derived from API Orchestrator request completion and failure. Together these let site builders create no-code workflows that call external APIs and react to their responses. Requires `api_orchestrator` and `eca`. Lifecycle: stable.

---

- Call an API Orchestrator endpoint as a step in an ECA model.
- Make a direct HTTP request via an API service from an ECA workflow.
- Pass ECA tokens into request URLs, headers and bodies.
- Choose queued or direct execution for the endpoint action.
- React to a request completing or failing with an ECA event.
- Branch a workflow on the response status code.
- Branch on whether the response body contains a string.
- Guard a step by checking that a given API service exists.
- Build integration automations without writing PHP.
- Combine with the Notifications/Alerts submodules for end-to-end no-code flows.
