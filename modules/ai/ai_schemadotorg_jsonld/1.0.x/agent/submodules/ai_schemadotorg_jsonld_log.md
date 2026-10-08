<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: AI Schema.org JSON-LD Log (ai_schemadotorg_jsonld_log)

Records the prompt/response pairs of Schema.org JSON-LD AI generations into a database table and
provides an admin UI to review, download (CSV), and clear them. Package `AI`, core `^11`, depends only
on `ai_schemadotorg_jsonld`.

## What it provides

- DB table `ai_schemadotorg_jsonld_log` (`hook_schema` in `.install`): columns `id`, `entity_type`,
  `entity_id`, `entity_label`, `bundle`, `url`, `prompt` (big text), `response` (big text),
  `valid` (tinyint), `created`; indexes on `(entity_type, entity_id)` and `created`.
- Storage service `ai_schemadotorg_jsonld_log.storage` → `AiSchemaDotOrgJsonLdLogStorage`
  (alias `...StorageInterface`): `insert`, `loadAll`, `loadAllByEntity`, `loadMultiple` (paged, 20/page
  via `PagerSelectExtender`), `deleteByEntity`, `truncate` — all using the parameterized query builder.
- Event subscriber `AiSchemaDotOrgJsonLdLogEventSubscriber` (tagged `event_subscriber`).
- Controller `AiSchemaDotOrgJsonLdLogController`, confirm form `AiSchemaDotOrgJsonLdLogClearForm`, and
  three hook classes (`...LogEntityHooks`, `...LogFieldHooks`, `...LogFormHooks`).
- Config object `ai_schemadotorg_jsonld_log.settings` (`enable`, default `true`) with schema.

## Enabling logging

The parent settings form is altered (`Hook/AiSchemaDotOrgJsonLdLogFormHooks`) to add an *Enable prompt
and response logging* checkbox under *Development settings*, bound to
`ai_schemadotorg_jsonld_log.settings:enable`.

## Capture (`EventSubscriber\AiSchemaDotOrgJsonLdLogEventSubscriber`)

Subscribes to `PostGenerateResponseEvent`. When logging is enabled and the request carries this
module's automator tags (`AiSchemaDotOrgJsonLdAutomatorTrait::hasTags()`), it reads the entity type/id
from the `ai_automator:entity_type:` / `ai_automator:entity:` tags, loads the entity for its label,
bundle, and absolute canonical URL, extracts the first prompt message text and the normalized response
text, records whether the response is valid JSON (`valid`), and inserts a row. It stores prompts and
responses only — **no AI provider keys or credentials** pass through the event, so none are logged.

## Routes & access (`ai_schemadotorg_jsonld_log.routing.yml`)

- `ai_schemadotorg_jsonld_log.view` — `/admin/config/ai/schemadotorg-jsonld/log`,
  `Controller::index` / `::title`, `_custom_access: Controller::access`.
- `ai_schemadotorg_jsonld_log.download` — `.../log/download`, `Controller::download`, same
  `_custom_access`.
- `ai_schemadotorg_jsonld_log.clear` — `.../log/clear`, `AiSchemaDotOrgJsonLdLogClearForm`,
  `_permission: administer site configuration`.

`Controller::access()`: when the request is filtered to one entity (`?entity_type=&entity_id=`), access
requires `$entity->access('update')` (per-entity, cached per user); an unresolvable filter is
forbidden. Unfiltered access requires `administer site configuration`. A local task tab ("Log") is
added under the parent settings route.

## Admin UI (`Controller\AiSchemaDotOrgJsonLdLogController`)

`index()` builds a paged `#type: table` of Created / Entity / Prompt / Response / Valid. Prompt and
response cells are rendered with `#plain_text` inside `<pre>` (so stored text is escaped, not markup);
the entity cell is a `Link` (or `#plain_text`) with the entity-type/bundle suffix; invalid-JSON rows get
a warning class. Operations: a *Download CSV* link and (unfiltered only) a modal *Clear log* link.
`formatResponse()` pretty-prints valid-JSON responses.

`download()` streams a CSV (`StreamedResponse` + `fputcsv`) of the columns entity_type, entity_id,
entity_label, bundle, url, prompt, response, valid, created — all rows (or the entity-filtered subset).

`AiSchemaDotOrgJsonLdLogClearForm` is a `ConfirmFormBase` that `truncate()`s the table on confirm.

## Field & entity hooks

- `Hook/AiSchemaDotOrgJsonLdLogFieldHooks` — on saved entities with the JSON-LD field, adds a *View log*
  modal link (filtered to that entity) shown only when logging is enabled and the user has `update`
  access to the entity.
- `Hook/AiSchemaDotOrgJsonLdLogEntityHooks` — `entity_delete` calls `storage->deleteByEntity()` so a
  deleted entity's log rows are cleaned up.

## Operating notes

- Logging is on by default once the submodule is enabled; turn it off with the settings checkbox.
- Logged prompts include the rendered-entity content token (rendered as the anonymous user), so a row
  contains only anonymous-visible content.
- Use *Download CSV* for offline prompt/response review and prompt tuning.
