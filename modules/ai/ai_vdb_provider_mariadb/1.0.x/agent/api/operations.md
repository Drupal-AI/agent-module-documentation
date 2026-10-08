<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rate-limit throttling, hooks & Drush commands

## Embedding rate-limit throttle

`EmbeddingRateLimitSubscriber` (`src/EventSubscriber/…`, service
`ai_vdb_provider_mariadb.embedding_rate_limit_subscriber`, arg `@logger.factory`) subscribes to the `ai`
module's `PreGenerateResponseEvent` / `PostGenerateResponseEvent`.

- It acts **only** on calls whose operation type is `embeddings` and whose tags include `ai_search`
  (indexing) — chat and other AI calls are untouched.
- `onPreGenerateResponse()` enforces a minimum interval since the last embedding call by `usleep()`-ing the
  remainder. The delay is a process-static set by `MariaDBProvider::indexItems()` before each run via
  `setDelay(computeDelayMs(rpm, tpm, avg_tokens))`.
- `computeDelayMs()` — `max(60000/rpm, avg_tokens*60000/tpm) * 1.1` (most-restrictive of RPM/TPM + 10%
  buffer; the daily TPD cap is intentionally ignored). Defaults RPM 3000 / TPM 1,000,000 / avg 500 tokens.
- Debug mode (`setDebugMode()`) logs per-call timing (`onPreGenerateResponse`) and token usage from the
  OpenAI response (`onPostGenerateResponse`) to the `ai_vdb_provider_mariadb` channel — two entries per
  chunk; disable in production.
- `indexItems()` also retries an item up to 5 times on `AiRateLimitException`/`AiRequestErrorException` with
  exponential backoff (5/10/20/40/80 s), calling `resetLastCallTime()` around the long sleep.

## Hooks — `AiVdbProviderMariadbHooks`

Autowired class invoked from `.module` via `#[LegacyHook]` wrappers:

- `help` (`help.page.ai_vdb_provider_mariadb`) — renders the module's own `README.md` through
  `League\CommonMark\CommonMarkConverter` (`html_input: strip`, `allow_unsafe_links: false`), or the
  `markdown` module, or an `htmlspecialchars`'d `<pre>` fallback.
- `form_search_api_server_form_alter` — attaches the `ai_vdb_provider_mariadb/server_form` JS library and
  pre-fills the database name (Drupal's DB) and a default collection `ai_vdb_vectors` for the MariaDB
  backend.
- `page_top` — flushes any deferred warning messages stored in the `ai_vdb_provider_mariadb` private
  tempstore during indexing.
- `search_api_index_update` — when a MariaDB-backed AI Search index is saved, creates the collection table
  (requires embedding **dimensions** to be set) and calls `MariaDBVectorClient::updateFields()` to add
  columns / relation tables for the index's fields.

## Drush commands — `MariaDBTestCommands`

Service `ai_vdb_provider_mariadb.commands` (arg `@logger.factory`), diagnostics only — they call OpenAI
directly using the key from `ai_provider_openai.settings` (via the Key repository):

| Command | Aliases | Purpose |
|---|---|---|
| `ai-vdb:test-rate-limits` | `test-rate` | Sends one `text-embedding-3-large` request and prints the OpenAI request/token rate-limit headers and metadata. |
| `ai-vdb:test-batch-indexing [items] [chunks]` | `test-batch` | Fires `items × chunks` rapid embedding requests (default 5×5) to observe when a rate limit is hit and the achieved requests/sec. |

Both are developer tools for tuning the RPM/TPM/avg-token settings; they perform no vector writes.
