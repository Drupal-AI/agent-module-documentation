<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blackbird REST endpoints

All routes are defined in `tmgmt_blackbird.routing.yml` and handled by
`Drupal\tmgmt_blackbird\Rest\BlackbirdApi` (service `tmgmt_blackbird.api`, `src/Rest/BlackbirdApi.php`).
Base path: `/api/tmgmt/blackbird`. `{tmgmt_job}` is constrained to `\d+`.

## Authentication (all endpoints)

- Every route declares `_access: 'TRUE'` — the Drupal routing layer imposes **no** access check;
  authentication is entirely in the controller.
- `getTranslatorForRequest()` reads the **`x-api-key`** request header; an empty header returns `NULL`.
  It loads all `tmgmt_translator` entities with `plugin = blackbird` and returns the first whose stored
  `api_key` matches via **`hash_equals()`** (constant-time compare). The stored key is `#required` and
  generated randomly, so there is no empty-key match.
- `requireTranslator()` calls `page_cache_kill_switch->trigger()` (responses vary by header, not URL, so
  the anonymous page cache must not reuse them), then throws `AccessDeniedHttpException` (HTTP 403) when
  no translator matches.
- `requireOwnedJob()` additionally throws 403 unless the job's assigned translator equals the
  authenticated translator — a translator can only touch its own jobs.
- All JSON responses set `Cache-Control: no-store, private`.

## Endpoints

- **GET `/languages`** → `languages()`. Auth only. Returns a JSON array of `{id, name}` for every
  language from `language_manager->getLanguages()`.

- **GET `/jobs`** → `jobs()`. Auth only. Lists this translator's `tmgmt_job` entities (query
  `accessCheck(FALSE)` but scoped to `translator = <authenticated id>`, sorted by `created`). Query
  params:
  - `state` (default `unprocessed`): one of `unprocessed`, `active`, `rejected`, `aborted`, `completed`
    → mapped to TMGMT `STATE_*`; anything else → HTTP 400.
  - `created`: must be `ctype_digit` (non-negative timestamp) or HTTP 400; filters `created >=`.
  - `source` / `target`: filter by `source_language` / `target_language`.
  - `note_contains`: must be a string (else 400); case-insensitive `stripos` substring match against the
    job's `reference`.
  - For `state=unprocessed`, jobs without the `blackbird_awaiting_acceptance` setting are skipped (so
    unsubmitted checkout drafts never appear). Each row: `{id, name, source, target, created, state}`.

- **GET `/job/{tmgmt_job}`** → `job()` (GET branch). Owned-job auth. Exports the job via the TMGMT File
  `html` format (`format_manager->createInstance('html')->export($job)`) as `text/html; charset=UTF-8`,
  `Cache-Control: no-store, private`. Downloading does not change job state (an `unprocessed` job may be
  previewed before acceptance).

- **POST `/job/{tmgmt_job}`** → `job()` (POST branch). Owned-job auth. Imports translated HTML:
  - HTTP 409 if the job is not `active` (must be accepted first).
  - Body buffered to a `tempnam()` file; `html->validateImport($path)` must return a `JobInterface`
    whose id equals `{tmgmt_job}` (else HTTP 400); HTTP 400 if the job is already finished; on success
    `addTranslatedData($html->import($content, FALSE))`. Temp file is always `@unlink`-ed in `finally`.
    Empty body or unwritable buffer → HTTP 400. Any other throwable → HTTP 400. Returns empty 200.

- **POST `/job/{tmgmt_job}/accept`** → `jobAccept()`. Owned-job auth. HTTP 409 unless the job is
  `unprocessed` or already `active`. For an `unprocessed` job it also requires
  `blackbird_awaiting_acceptance` (else 409 "not been submitted"), clears that flag, and calls
  `submitted()` → job becomes `active`. Idempotent for an already-active job. Returns `{id, state:
  "active"}`.

- **GET/POST `/job/{tmgmt_job}/note`** → `jobNote()`. Owned-job auth. On POST: body must be JSON with a
  string `note` ≤ 255 chars (else HTTP 400); stored in the job's `reference` field and saved. Always
  returns `{id, note}` with the current note.

- **POST `/job/{tmgmt_job}/reject`** → `jobReject()`. Owned-job auth. Body must be JSON with a non-empty
  string `reason` (else HTTP 400). HTTP 409 unless the job is `active` (or already `rejected`). For an
  active job, `rejected('Blackbird rejected the translation job: @reason', …, 'error')` records the
  reason and moves it to `rejected`. Idempotent. Returns `{id, state: "rejected"}`. A rejected job can be
  re-submitted, returning to `unprocessed`.

## Lifecycle summary

Editor submits job → `unprocessed` (+`blackbird_awaiting_acceptance`). Blackbird polls `/jobs`,
optionally `GET /job/{id}` to preview, `POST /accept` → `active`, then `POST /job/{id}` with translated
HTML → finished, or `POST /reject` with a reason → `rejected`. No outbound calls are made by Drupal; the
whole exchange is Blackbird pulling from these endpoints.
