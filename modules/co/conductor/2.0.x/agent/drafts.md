<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conductor — drafts: mapping, quota, dashboard, cleanup

## Storage: conductor_draft_map

`conductor.install` `hook_schema()` defines table `conductor_draft_map`:

| field | type | notes |
|-------|------|-------|
| entity_id | int unsigned | part of primary key |
| entity_type | varchar_ascii (ID_MAX_LENGTH) | part of primary key |
| draft_id | varchar(128) | Conductor draft UUID; unique key `draft_id__uniq` |
| created / changed | int unsigned | unix timestamps |
| deleted | tinyint | soft-delete flag (0/1) |

Primary key `(entity_id, entity_type)`; `draft_id` unique. Dropped on `hook_uninstall`.

## DraftRepository

Service `conductor.draft_repository` (`Drupal\conductor\Repository\DraftRepository`, implements
`DraftRepositoryInterface`). Constructor: `@database`, `@datetime.time`, `@entity_type.manager`,
`@config.factory`. Constants: `DEFAULT_DRAFT_TITLE = "Untitled Canvas draft:"`, `DEFAULT_MAX_DRAFT =
15`. All access uses the DB query builder with bound values.

- `getDraft($entity_type, $entity_id)` — the mapping row (or `[]`).
- `getDrafts(?int $year)` — rows whose `created` falls in the given calendar year, newest first.
- `createDraft($entity_type, $entity_id, $draft_id)` — verifies the entity exists (storage `load`),
  idempotent no-op if the same mapping exists, else rejects when the entity is already linked, the
  draft is already linked elsewhere, or the per-year quota is reached; then upserts. Throws
  `UnableToAssignDraftToEntityException` on any of those.
- `updateDraft(...)` → `upsertDraft(...)` (DB `merge` keyed on entity_id+entity_type).
- `deleteDraft($entity_type, $entity_id)` — soft-delete (`deleted = 1`).
- `isDraftLinkedToAnEntity($draft_id)`, `getMaxDrafts()` (config `max_drafts`, default 15),
  `getUsedDrafts(?year)` (count of `getDrafts`).

## Draft CRUD API

Route `conductor.api.draft` `/conductor/api/draft/{entity_type}/{entity_id}` (GET/PUT/POST/DELETE,
`no_cache`, permission `use conductor`). `ConductorDraftApiController::__invoke` matches on method:

- **GET** → `getDraft` (404 if none).
- **POST** → `createDraft`; body `{"draftId": "..."}`. Idempotent: same mapping → 200, new → 201,
  conflict/quota → 422 (`UnableToAssignDraftToEntityException`).
- **PUT** → `updateDraft` (upsert) with body `draftId`.
- **DELETE** → soft-delete the mapping (404 if none).

Request bodies are parsed with `JSON_THROW_ON_ERROR`; errors return JSON `{error, exception}`.

## Dashboard

Route `conductor.draft_dashboard` `/admin/reports/conductor` (permission `use conductor`).
`ConductorDraftDashboard` renders a `#theme => table` of the current year's drafts: draft-id link to
`https://app.conductor.com/u/{accountId}/writing-assistant/draft/?draftId=...` (falls back to plain id
if no account), entity link (`toLink`, or a "not found or deleted" note), created/changed dates, and a
Deleted/Published status. Above it, a "Drafts usage" details block shows `usedDrafts/maxDrafts` for the
year. All dynamic values render through escaped render arrays / `t()` placeholders.

## Cron cleanup (opt-in)

`Drupal\conductor\DraftCleanup` runs from `ConductorHooks::cron()` (`#[Hook('cron')]`). It is a **no-op
unless `conductor.settings:enable_draft_cleanup` is TRUE** (default FALSE;
`conductor_update_10001` disables it for existing sites). When enabled it fetches Conductor drafts
(`getExistingDrafts`) and deletes those that (a) have a title starting with `"Untitled Canvas draft:"`,
(b) are older than `delete_unlinked_drafts_after` (default 21600s / 6h), and (c) are not mapped locally
(`isDraftLinkedToAnEntity`). Deletions go through `ConductorHttpApiClient::deleteDraft`. Keep it
disabled where multiple Drupal databases share one Conductor account (documented in the config
comments) to avoid deleting drafts owned by another environment.

## Entity delete hook

`ConductorHooks::entityDelete` (`#[Hook('entity_delete')]`) soft-deletes the local mapping for any
deleted entity (`draftRepository->deleteDraft`). No external call is made.
