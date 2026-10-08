<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fetch data from an HTTP/HTTPS API endpoint through the Document Loader pipeline and convert the response into markdown, JSON, YAML, plain text, CSV, or TOML.

---

Document Loader Plugin - API adds one `DocumentLoader` plugin (`document_loader:api`, class `ApiLoader`) to the `document_loader` module's plugin manager. Code constructs an `ApiInput` (URL plus optional HTTP method, headers, and body), calls `ApiLoader::load($input, $format)`, and receives a `document_loader` Output object whose `getContent()` holds the requested representation and whose `getMetadata()` carries the source URL, method, HTTP status code, content type, and fetch timestamp. Internally the loader issues a single Guzzle request via Drupal's `http_client`, JSON-decodes the body (non-JSON bodies become `['content' => <raw>]`), and renders the data with `match($format)` into `JsonOutput`, `YamlOutput`, `MarkdownOutput`, `TextOutput`, `CsvOutput`, or `TomlOutput`; markdown/text/csv conversion is inline and TOML uses the bundled `TomlFormatter`. The module has no admin UI, routes, permissions, config, or services — it is a developer-facing extension of Document Loader. The optional `document_loader_plugin_api_tool` submodule surfaces the same loader as a Tool-API tool for AI agents.

---

- Pull a JSON REST endpoint into Drupal and get it back as a ready-to-store JSON string.
- Convert a third-party API's JSON response into Markdown for display or AI ingestion.
- Turn an API response into YAML for configuration-style output or diff-friendly storage.
- Flatten a list-of-records API payload into CSV for spreadsheet export or downstream import.
- Serialize API data to TOML via the bundled `TomlFormatter`.
- Render API data as an indented plain-text key/value tree for logs or previews.
- Make an authenticated GET request by passing an `Authorization` header through `ApiInput`.
- POST/PUT/PATCH a JSON body to an API and capture the transformed response.
- Send custom request headers (API keys, `Accept`, correlation ids) with each call.
- Normalize responses from several different APIs into one common output format.
- Feed cleaned API data into a migration or content-import routine.
- Prepare external API data for a RAG / AI pipeline as Markdown or plain text.
- Build a scheduled (cron/queue) job that fetches an endpoint and stores the converted result.
- Extract a nested array of records from a wrapped response and emit it as a CSV table.
- Auto-render a top-level array of objects as a Markdown table.
- Subclass `ApiInput` to inject bearer tokens or signed headers for a specific API.
- Capture per-request metadata (status code, content type, fetched-at) alongside the payload.
- Let an AI agent load and transform an API endpoint on a user's behalf (via the tool submodule).
- Reuse the `TomlFormatter` utility directly to convert any PHP array to TOML.
- Detect non-JSON responses (the loader wraps them as `{ "content": "..." }`) and handle them uniformly.
