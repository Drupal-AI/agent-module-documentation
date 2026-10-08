<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Translate — routes & JSON API

All routes are defined in `canvas_translate.routing.yml` and served by
`\Drupal\canvas_translate\Controller\ApiTranslateController` (JSON) and `PreviewController` (HTML).
The bundled SPA (`extension/`) is the only client.

## Access model (applies to every route)

- **Permission:** every route requires `_permission: 'translate canvas content'`
  (`canvas_translate.permissions.yml`, `restrict access: TRUE`).
- **Per-entity access:** controllers additionally check `$entity->access('update')` on the page /
  config entity (and on the *target translation* for save/discard) — the permission alone is not
  enough; a 403 is returned otherwise. Per-page edits stay subject to entity update access.
- **CSRF:** every mutating route (PATCH/POST/DELETE) adds `_csrf_request_header_token: 'TRUE'`.
  Read-only GET routes do not (nothing to protect).
- **No caching:** all routes set `no_cache: TRUE`; `{canvas_page}` is `\d+` and upcast to
  `entity:canvas_page`; config `{type}` is constrained to `content_template|page_region`.

## Content (canvas_page) endpoints

| Route | Method · Path | Controller method | Purpose |
|---|---|---|---|
| `canvas_translate.api.items` | GET `/canvas-translate/api/items` | `items()` | Dashboard: every page × language with status + completeness %, plus config items. |
| `…translation.get` | GET `/canvas-translate/api/items/canvas_page/{canvas_page}/{langcode}` | `getTranslation()` | Side-by-side field rows for one page + target language. |
| `…translation.save` | PATCH same path | `saveDraft()` | Autosave target values into the draft store. |
| `…translation.discard` | DELETE same path | `discardDraft()` | Drop the pending draft. |
| `…translation.publish` | POST `…/{langcode}/publish` | `publish()` | Apply draft → new revision. |
| `…translation.mark_reviewed` | POST `…/{langcode}/mark-reviewed` | `markReviewed()` | Clear `outdated` without rewriting values. |
| `…translation.approve` / `.unapprove` | POST `…/{langcode}/approve` \| `/unapprove` | `approve()` / `unapprove()` | Toggle draft approval (review step). |
| `…publish_batch` | POST `/canvas-translate/api/publish-batch` | `publishBatch()` | All-or-nothing publish of many `{id, langcode}` drafts. |
| `canvas_translate.preview` | GET `/canvas-translate/preview/canvas_page/{canvas_page}/{langcode}` | `PreviewController::preview()` | Themed full-page HTML preview with the draft applied (iframed by the editor). |

## Config (content_template / page_region) endpoints

Path shape `/canvas-translate/api/config/{type}/{id}/{langcode}[/…]`, `{type} ∈ content_template|page_region`,
`{id}` a config-entity id (may contain dots). Methods: GET `getConfigTranslation`, PATCH
`saveConfigTranslation`, DELETE `discardConfigTranslation`, POST `…/publish`
`publishConfigTranslation`, `…/approve`|`/unapprove` `approveConfig`/`unapproveConfig`,
`…/mark-reviewed` `markConfigReviewed`. Same permission + CSRF rules.

## Publish semantics (important)

- **Content publish** (`publish()` / `publishBatch()` → `applyDraftToTarget()`): writes the draft's
  non-empty values onto the **current** stored target *unconditionally* — no diff against the source.
  A value that legitimately equals the source (after "copy source", or an untranslated brand name)
  is still written, so a translation never publishes empty. Non-translatable fields are never written
  (they'd overwrite the shared source column); untranslated props keep their source-seeded value.
  Saves run inside a DB transaction; batch validates every page before saving any.
- **Config publish** (`ConfigTranslatableGlue::publish()`): flushes the staged draft into the live
  `LanguageConfigOverride` (or deletes it when empty), then records a `ConfigBaseline` snapshot.
- A new translation is **seeded from the source** (`addTranslation($langcode, $stored->toArray())`)
  so untranslated props keep their source value (no-data-loss invariant).

## Setup gating

`translatabilitySetup()` derives whether page translation can work: if content translation is not
enabled for the `canvas_page` bundle, or no written field (`title`, `description`, `components`) is
translatable, the endpoints return **409** `{code: translation_not_enabled}` and the SPA shows setup
instructions. Individually non-translatable fields degrade gracefully (excluded from rows, drafts,
publish, completeness) rather than blocking. `RequirementsHooks` surfaces the same check on the
status report.
