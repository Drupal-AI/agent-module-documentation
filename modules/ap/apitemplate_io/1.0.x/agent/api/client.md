<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ApiTemplateClient service (`apitemplate_io.client`)

`Drupal\apitemplate_io\ApiTemplateClient` — inject `@apitemplate_io.client`.

## Methods
- `request($op, array $json_vars = [], array $query_vars = [])` — low-level call. `$op` maps to a method: `create-pdf`/`merge-pdfs` → POST, `list-templates`/`delete-object` → GET. Sends `X-API-KEY` header; `http_errors` off; returns a Guzzle response or NULL on transport error.
- `parseResponse($response, $raw_body = FALSE)` — returns decoded JSON array, or raw body if `$raw_body`; FALSE on non-200. Non-200 bodies are logged.
- `createPdf(array $body_vars, $template_id = NULL, $return_raw_body = FALSE)` — uses `default_template_id` config when `$template_id` omitted; returns `download_url` or raw binary.
- `mergePdfs(array $urls, $return_raw_body = FALSE)` — merges PDFs; non-http entries are converted to data URIs.
- `listTemplates()` — returns `templates` array (PDF format) or FALSE.
- `deleteObject($transaction_ref)` — deletes a prior transaction's object.
- `serveFile($url_or_content, $filename, $resolve_url = TRUE)` — builds a `Response` download. With `$resolve_url` TRUE it fetches `$url_or_content` server-side; keep callers admin-gated.
- `tempConfigOverride(array $conf_overrides)` — request-scoped, non-persisted override of `apitemplate_io.settings` keys (used by the Test Tool). Only pre-existing keys (except `_core`) are honored.

## Config keys (`apitemplate_io.settings`)
- `api_endpoint` (e.g. `https://rest.apitemplate.io`), `api_key`, `default_template_id`.

## Security
API key travels in `X-API-KEY` over TLS (Guzzle default verification). Stored plaintext in config — exclude from public config exports or move to a secrets workflow.
