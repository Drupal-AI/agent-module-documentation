<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Penpot — the AI Agent tools and the context client

Two `#[FunctionCall]` plugins (in `src/Plugin/AiFunctionCall/`) wrap the
`ai_penpot.client` service (`PenpotContextClient`). Both are group `information_tools`,
`module_dependencies: ['ai_penpot']`, and both check permission before running:

```php
!use ai penpot design context && !administer ai agents && !use Drupal Canvas AI
  -> throw "You do not have permission to read Penpot design context."
```

Add these tools to a Canvas AI agent (or any AI Assistance agent) to let it work from a Penpot
design.

## Tool 1 — `ai_penpot:list_design_pages` (PenpotListDesignPages)

- Function name: `ai_penpot_list_design_pages`. Label *"Penpot: List Design Pages"*.
- Inputs (all optional): `penpot_url` (a link; file id extracted from it), `file_id` (UUID).
  Falls back to the configured `default_file_id`.
- `execute()` resolves the file id (context → parsed URL → default), calls
  `PenpotContextClient::listDesignPages()`, and dumps YAML: `penpot_file_id`, `design_pages`
  (`[{page_id, name}]` in document order) and a `hint` to build one Canvas page per design page and
  skip foundation pages (Colors, Typography, Icons, Spacing).

## Tool 2 — `ai_penpot:design_context` (PenpotDesignContext)

- Function name: `ai_penpot_design_context`. Label *"Penpot: Read Design Context"*.
- Inputs (all optional): `penpot_url`, `file_id`, `page` (page id **or** name). Explicit
  `file_id`/`page` win over what is parsed from `penpot_url`; file id falls back to the default.
- `execute()` calls `fetchPage($file_id, $page)` then `summarizeTokens()`, and dumps YAML:
  `penpot_file_id`, `page` (`{id, name}`), `colors`, `typography`, `content_texts`
  (`[{text, name, size}]`), `outline`, and a `hint` (reuse theme components; map colours onto theme
  design tokens; use text verbatim, larger sizes = headings).

## The client: `PenpotContextClient` (`src/PenpotContextClient.php`)

Constructor args: `@http_client`, `@config.factory`, `@logger.factory`, `@?key.repository`.

- **RPC transport** — `rpc($command, $payload, ...)` POSTs JSON to
  `<base>/api/rpc/command/<rawurlencode(command)>` with headers `Authorization: Token <token>`,
  `Accept: application/json`, `Content-Type: application/json`, default 30s timeout. Uses the
  standard Guzzle `http_client` (TLS verification on). `requireBaseUrl()` / `requireToken()` throw a
  helpful `\RuntimeException` when unset; `requestFailed()` logs and surfaces Penpot's own
  `hint`/`code` (e.g. `401 authentication-required`) instead of Guzzle's verbose message.
- **`fetchFile($file_id)`** — RPC `get-file` (metadata + page index, no shapes), 60s.
- **`fetchPage($file_id, $page_id = '')`** — RPC `get-page`. A non-UUID `$page_id` is resolved by
  name via `resolvePageIdByName()`; empty falls back to the file's first page.
- **`listDesignPages($file_id)`** — reads `pagesIndex`/`pages-index` + `pages` order into
  `[{page_id, name}]`.
- **`summarizeTokens($page)`** — walks the flat `objects` map: solid `fills[].fillColor` become
  hex colour labels (with opacity), `text` shapes yield typography keys and real text
  (`extractText()` joins paragraph runs; `firstTextStyle()` picks font family/weight/size), named
  shapes (excluding `Root Frame`) form an outline capped at 200 entries.
- **`parsePenpotUrl($url)`** (static) — extracts `file_id` and `page_id` UUIDs from workspace/view
  links or a bare UUID; strips a leading `@`/`@http` (AI prompts often prefix links). It only reads
  ids — it is never used as a fetch target; all requests go to the configured base URL.

## Operating notes

- The tools return **text/YAML to the agent**, not rendered HTML — the design's text content is
  consumed by the LLM, not written into the Drupal DOM.
- The base URL is admin-only config and validated to http(s)+host; the token is a Key value.
- To run a tool from code: `\Drupal::service('ai_penpot.client')->listDesignPages($fileId)` or
  `->fetchPage($fileId, $page)` then `->summarizeTokens($page)`.
