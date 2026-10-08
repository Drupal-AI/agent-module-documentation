<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Remote Requests lets ECA (Event-Condition-Action) models make server-side HTTP calls and react to the results, without writing PHP.
---
The module ships three plugins. The **Run Remote Requests** action (`eca_remote_request_run_remote_requests`) builds a Guzzle client and issues a request to a configured URL using a chosen method (GET/POST/PUT/PATCH/DELETE/HEAD/OPTIONS); the request body (`form_params` or `json`) and arbitrary Guzzle request options are supplied as ECA-token-replaced YAML, and the response (status, headers, body) is written into a named ECA token for downstream steps. The **Convert JSON to List** action parses a JSON string into an ECA list token, and the **Is JSON Data** condition tests whether a value is valid JSON.

Operationally you compose these in the ECA UI (BPMN/Modeller): trigger an event, optionally gate with the JSON condition, run the request, then convert/iterate the response. Security notes: the request URL comes from the ECA model configuration (editing ECA models requires the ECA admin permission), and the free-form Guzzle options let a model author set any client option — including headers, proxies, or TLS verification — so treat ECA model edit access as trusted. The action's own `access()` always returns allowed (access is governed by who may run the ECA model). Guzzle defaults keep TLS verification on unless a model explicitly disables it.
---
- Call an external REST API as a step in an ECA workflow
- POST form-encoded data to a remote endpoint on a content event
- Send a JSON payload to a webhook when a node is published
- Add custom Authorization or API-key headers via the Guzzle options field
- Capture a remote response into an ECA token for later steps
- Parse a JSON API response into an ECA list and loop over items
- Branch a workflow on whether a value is valid JSON
- Trigger a downstream service when an order or entity changes
- Fetch remote data to populate fields during entity save
- Use ECA tokens to build dynamic request bodies
- Set a request timeout or connect timeout through Guzzle options
- Route requests through an HTTP proxy defined in options
- Perform a DELETE call to a remote resource from a workflow
- Read the response status code to decide the next action
- Forward selected entity data to a CRM or notification service
- Chain multiple remote calls in one ECA model
- Store the response headers token for auditing
- Integrate Drupal events with third-party automation platforms
