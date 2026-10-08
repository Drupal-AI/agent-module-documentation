<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AIA pipeline & request flow

AIA never applies AI output blindly. Every action runs a two-phase flow, and each phase is a distinct method on the `AiaActionInterface` contract (`src/Action/AiaActionInterface.php`).

## Single-action flow
Implemented in `AiaActionBase` subclasses (e.g. `GenerateContentTypeAction::executeDryRun()`):
1. `buildContext()` → `AiaContext` — gathers site facts (existing types, field types, installed modules, site UUID, Drupal version) as a serialized JSON graph.
2. `buildPrompt($context)` → `AiaPrompt` — assembles a system prompt (strict "return ONLY this JSON shape" instructions) + a user prompt embedding the context and the user's intent (`setUserIntent()`).
3. `aia.ai_request_service->request($prompt)` → `AiaResponse` — calls the AI. `AIRequestService` (real) sends a `ChatInput` via the `ai` module's default chat provider (`temperature 0.3`, `max_tokens 4096`) and strips markdown code fences; `MockAIRequestService` (default) returns deterministic keyword-matched JSON.
4. `validateResponse()` → `StructuredResponseValidator` parses/validates the envelope; then the action's own `validatePayload()` runs the per-action business-rule validator (e.g. `ContentTypePayloadValidator`) — machine-name format, "already exists" conflicts, field-type existence, etc.
5. `generateDiff()` → `DiffGenerator` builds an `AiaDiff` (plain text + structured colour-coded entries).
6. `executeDryRun()` returns an `AiaTaskResult{success, diff, message, validatedResponse}`. **No writes happen** — dry-run is side-effect free by contract.
7. `apply($validated)` — only called after a successful dry-run and explicit confirm; creates the real entities/config via the entity API, logs via `aia.task_logger`, and returns a result.

The web `AiaExecuteForm` and `AiaCommands` (Drush) both drive this same flow; apply is guarded by a JS `confirm()` (danger button) in the UI and `--auto-approve`/interactive confirm on the CLI.

## Router (natural language → action)
`AiaActionRouter::route($freeText, $definitions)` (`src/Service/AiaActionRouter.php`) sends the user's free text plus the list of available actions to the AI and parses a JSON reply into an `AiaRouterResult`:
- `{"type":"action","action_id":...,"refined_intent":...}` → single action, or
- `{"type":"pipeline","steps":[{action_id,intent},...]}` → multi-step plan.

On any failure it logs a warning and falls back to the first available action unchanged (never throws to the user).

## Pipeline (multi-step)
`AiaPipeline` (`src/Service/AiaPipeline.php`) runs a router pipeline plan:
- `dryRunAll($plan)` — dry-runs each step in order, stopping at the first failure.
- `applyAll($plan, $dryRunResults, $sessionId)` — generates a UUID `sessionId`, applies each step whose dry-run succeeded, logs each `aia_task` with that shared session id (so Task History groups them), and stops on the first apply failure. Already-applied steps remain and are individually rollback-able.

## Key value objects (`src/ValueObject/`)
`AiaContext`, `AiaPrompt` (system+user), `AiaResponse` (raw JSON), `AiaValidatedResponse` (actionType + payloadJson), `AiaRouterResult` (`singleAction()`/`pipeline()` factories, `isPipeline()`), `AiaDiff` (`toRenderArray()`, `diffText()`), `AiaTaskResult` (`success()`, `diff()`, `message()`, `validatedResponse()`).

## Rollback
`AiaRollbackService::rollback($taskId)` reads the logged `aia_task` payload and deletes what was created (content type + its fields, field + orphaned storage, vocabulary + terms, view, or block by stored id) via a `match` on action type. Guards against double-rollback and non-successful tasks. See `entity/aia_task.md`.
