<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exposes the Document Loader API loader as a Tool-API tool (`document_loader_from_api`) so AI agents and other Tool consumers can fetch an HTTP/HTTPS API endpoint and get the response in a chosen format.

---

Document Loader Plugin - API Tool is an opt-in submodule of `document_loader_plugin_api`. It registers one Tool plugin, `DocumentLoaderTool` (id `document_loader_from_api`), declared with the `tool` module's `#[Tool]` attribute and marked `ToolOperation::Read`. The tool takes a `location` (endpoint URL) plus optional `output_format`, `http_method`, `request_body`, and `request_headers`, and returns `content` (the loaded, converted document) and `format`. At execution it accepts only `http`/`https` URLs, applies a small heuristic to confirm the target is an API request, then delegates to the parent module's `document_loader:api` plugin (obtained from `plugin.manager.document_loader`) with an `ApiInput` built from the caller's arguments. Access is granted to any authenticated user. The submodule requires both `document_loader_plugin_api` and `tool`, and ships no routes, permissions, config, or services itself.

---

- Let an AI agent fetch a REST endpoint and read the response as Markdown or JSON.
- Give a chatbot/assistant a function-call tool to look up live API data on demand.
- Have an agent POST a JSON body to an API and receive the transformed result.
- Pass custom request headers (e.g. `Accept`, correlation ids) from an agent call.
- Convert an API response to YAML/CSV/text/TOML for an agent workflow.
- Wire the tool into a `tool`-API-driven automation that ingests external data.
- Enumerate an API's records and hand an agent a CSV table of the results.
- Fetch a `.json`/`.yaml`/`.xml` document by URL for an agent to summarize.
- Provide a read-only data-loading capability to authenticated site users via the Tool API.
- Chain the tool's `content` output into a downstream summarization or extraction step.
- Use `http_method` = PUT/PATCH to drive an idempotent update call from an agent (returns the response body).
- Standardize how multiple agents fetch remote data by sharing one loader tool.
- Prototype an integration by letting an agent hit an endpoint before writing bespoke code.
- Surface API data inside a Tool-API playground or agent-testing UI.
- Return both the content and the `format` actually used so the caller can branch on it.
