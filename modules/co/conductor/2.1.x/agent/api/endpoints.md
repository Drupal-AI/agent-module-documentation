<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conductor — drafts, node extension, dashboard & cleanup

## Storage: conductor_draft_map

`conductor.install` `hook_schema()` defines table `conductor_draft_map`:

| field | type | notes |
|-------|------|-------|
| entity_id | int unsigned | part of primary key |
| entity_type | varchar_ascii (ID_MAX_LENGTH) | part of primary key |
| draft_id | varchar(128) | Conductor draft UUID; unique key `draft_id__uniq` |
| created / changed | int unsigned | unix timestamps |
| deleted | tinyint | soft-delete flag (0/1) |
| score | int unsigned, nullable | latest content score 0–100 (added by `conductor_update_10002`) |

Primary key `(entity_id, entity_type)`; `draft_id` unique. Dropped on `hook_uninstall`.

## DraftRepository

Service `conductor.draft_repository` (`Drupal\conductor\Repository\DraftRepository`, implements
`DraftRepositoryInterface`). Constructor: `@database`, `@datetime.time`, `@entity_type.manager`,
`@config.factory`. Constants `DEFAULT_DRAFT_TITLE = "Untitled Canvas draft:"`, `DEFAULT_MAX_DRAFT = 15`.
All DB access uses the query builder with bound values.

- `getDraft($entity_type, $entity_id)` — the non-deleted mapping row (or `[]`).
- `getDrafts(?int $year)` — rows whose `created` falls in the given calendar year, newest first.
- `createDraft($entity_type, $entity_id, $draft_id)` — verifies the entity exists (storage `load`),
  idempotent no-op if the identical mapping exists, else rejects when the entity is already linked, the
  draft is already linked elsewhere, or the per-year quota is reached; then upserts. Throws
  `UnableToAssignDraftToEntityException` on any of those.
- `updateDraft(...)` → `upsertDraft(...)` (DB `merge` keyed on entity_id + entity_type).
- `deleteDraft($entity_type, $entity_id)` — soft-delete (`deleted = 1`).
- `updateScore($entity_type, $entity_id, $score)` — sets `score` on the non-deleted mapping.
- `isDraftLinkedToAnEntity($draft_id)`, `getMaxDrafts()` (config `max_drafts`, default 15),
  `getUsedDrafts(?year)` (count of `getDrafts`).

## Draft CRUD + score API

Route `conductor.api.draft` `/conductor/api/draft/{entity_type}/{entity_id}`
(GET/PUT/POST/DELETE/PATCH, `no_cache`, permission `use conductor`).
`ConductorDraftApiController::__invoke` matches on HTTP method:

- **GET** → `getDraft` → the mapping row, or 404 `{error: 'Draft not found'}`.
- **POST** → `createDraft`; body `{"draftId": "..."}`. Idempotent: same mapping → 200, new → 201,
  conflict/quota → 422 (`UnableToAssignDraftToEntityException`).
- **PUT** → `updateDraft` (upsert) with body `draftId`.
- **DELETE** → soft-delete the mapping (404 if none).
- **PATCH** → `patchScore`; body `{"score": 0..100}`. Validates an integer in range (422 otherwise),
  then `updateScore` (404 if no active draft). 

Request bodies are parsed with `JSON_THROW_ON_ERROR`; errors return JSON `{error, exception}`. Method
mismatches → 405. `{entity_type}` is a free-form path segment resolved through the entity type manager.

## Node-form extension host

Route `conductor.node_extension` `/conductor/node-extension/node/{node_id}` (`node_id: \d+`,
`no_cache`, permission `use conductor`). `ConductorNodeExtensionController::__invoke`:

- `node_id` **0** = an unsaved node: returns the portal "shell" only (the app prompts the user to save
  first). No entity is loaded.
- Otherwise loads the node and allows the request only when `$node->access('update')` is TRUE **and**
  the node's bundle is listed in `conductor.settings:node_types` (`isEnabledBundle`); else throws
  `AccessDeniedHttpException`. The `use conductor` permission alone is not sufficient — access is
  checked in the controller (the route comment explains why: `node_id` 0 must still return the shell).
- Renders a `#type => container` with a `div#extensionPortalContainer` the app mounts into, attaches
  the `conductor/conductor.node_app` library, and passes `drupalSettings.conductor.entity` +
  `insertTargets`.
- `insertTargets()` lists formatted-text fields (`text_long`, `text_with_summary`) that the generated
  HTML can be written into — only fields that are non-computed, non-read-only, present in the form
  display (`entity_display.repository`), and pass `$node->get($name)->access('edit')`. Each target is
  `{id: "<field>[0][value]", label}`.

The button that opens this route is added to opted-in node forms by
`ConductorHooks::formNodeFormAlter` (`#[Hook('form_node_form_alter')]`): for `use conductor` users on a
bundle in `node_types`, it adds a "Writing Assistant" details group with an *Open extension*
`use-ajax` link that opens the route in a draggable dialog.

## Dashboard

Route `conductor.draft_dashboard` `/admin/reports/conductor` (permission `use conductor`, `no_cache`).
`ConductorDraftDashboard::__invoke` renders a `#theme => table` of the current year's drafts: a draft-id
link to `https://app.conductor.com/u/{accountId}/writing-assistant/draft/?draftId=…` (falls back to the
plain id when no account resolves), the entity link (`toLink`, or a "not found or deleted" note),
created/changed dates, the `score` (or `–`), and a Deleted/Published status. Above the table a "Drafts
usage" details block shows `usedDrafts/maxDrafts` for the year. All dynamic values render through
escaped render arrays / `t()` placeholders. Menu link `conductor.draft_dashboard` under *Reports*.

![Conductor drafts dashboard](../../../../../../../screenshots/conductor/2.1.x/drafts-dashboard.png)

## Cron cleanup (opt-in)

`Drupal\conductor\DraftCleanup::run()` runs from `ConductorHooks::cron()` (`#[Hook('cron')]`). It is a
**no-op unless `conductor.settings:enable_draft_cleanup` is TRUE** (default FALSE;
`conductor_update_10001` disables it for existing sites). When enabled it fetches Conductor drafts
(`getExistingDrafts`) and deletes those that (a) have a title starting with `"Untitled Canvas draft:"`,
(b) are older than `delete_unlinked_drafts_after` (default 21600 s / 6 h), and (c) are not mapped
locally (`isDraftLinkedToAnEntity`). Deletions go through `ConductorHttpApiClient::deleteDraft`. Keep it
disabled where multiple Drupal databases share one Conductor account (per the config comments) to avoid
deleting drafts owned by another environment.

## Entity delete hook

`ConductorHooks::entityDelete` (`#[Hook('entity_delete')]`) soft-deletes the local mapping for any
deleted entity (`draftRepository->deleteDraft`). No external call is made.
