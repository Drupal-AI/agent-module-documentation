A reference example module that provides a test endpoint and demo webform for exercising Webform's Remote Post handler against a remote server.

---

Webform Remote Post Example demonstrates how Webform can push a submission to an external HTTP endpoint using the core Remote Post handler. It ships a controller (`WebformExampleRemotePostController::index`) exposed at `/webform_example_remote_post/{type}` that mimics a third-party REST API — receiving the posted data and returning a JSON response — so you can develop and debug the Remote Post handler without a real external service. The `{type}` path segment lets it simulate create, update, and delete requests. A bundled example webform is pre-wired to post to this local endpoint. It depends on `webform` and `token` (tokens fill the request payload) and adds no configuration UI, schema, or permissions of its own. Use it to learn the request/response shape of Remote Post integrations or as a scaffold for a local mock endpoint during development.

---

- Test Webform's Remote Post handler without a live external API.
- See the request/response shape of a remote-post integration.
- Provide a local mock endpoint for developing a CRM/webhook integration.
- Learn how the Remote Post handler formats submission payloads.
- Debug create, update, and delete remote requests via the `{type}` path.
- Reference a simple controller that returns a JSON response.
- Study how tokens populate the outgoing request body.
- Scaffold a custom controller that receives Webform posts.
- Demonstrate remote posting during a training or demo.
- Verify network/proxy configuration for outbound Webform requests.
- Inspect what headers and fields Webform sends on submit.
- Prototype webhook handling before building the real service.
- Teach the Remote Post feature during developer onboarding.
- Provide a known-good integration target for QA testing.
- Confirm error handling when a remote endpoint returns non-200.
- Model an idempotent endpoint that handles all submission operations.
- Reference for writing tests around remote-post behavior.
- Compare posted data against expected API contracts.
- Explore how submission updates and deletions are relayed remotely.
