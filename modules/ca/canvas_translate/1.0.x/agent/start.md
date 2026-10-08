<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas Translate (canvas_translate) — agent index

In-editor translation of **Drupal Canvas** (Experience Builder) content, shipped as a Canvas **page
extension** at `/canvas/app/canvas_translate`. Translates Canvas **pages** (content) plus **content
templates** and **page regions** (config layouts) side-by-side with the source, on a **draft →
review → publish** workflow. Package `Canvas`. Core `^11.3`. License GPL-2.0-or-later. Version
1.0.0-alpha4.

- **Dependencies:** `canvas:canvas (>=1.8.0)`, core `content_translation`, core `language`.
  Optional: `ai:ai` (only used by the `canvas_translate_ai` submodule).
- **Permission (one):** `translate canvas content` (`restrict access: TRUE`) — gates every route.
- **Config schema:** `canvas_translate.baseline.*` (the `canvas_translate_baseline` config entity).
- **No** Drush commands, **no** settings form (`configure` is null).

## Solution docs

- **All routes, the JSON API, permissions, CSRF, and the publish workflow** →
  [api/endpoints.md](api/endpoints.md)
- **Services, key/value stores, hooks, the baseline entity, the route subscriber, the extension** →
  [architecture/internals.md](architecture/internals.md)
- **AI machine-translation submodule** (`canvas_translate_ai`) →
  [../modules/canvas_translate_ai/1.0.x/agent/start.md](../modules/canvas_translate_ai/1.0.x/agent/start.md)

## What it provides (from source)

- **Page extension**: `canvas_translate.canvas_extension.yml` registers a `page`-type extension
  (id `canvas_translate`, url `extension/index.html`) — a bundled React/tsup SPA under `extension/`.
- **Controllers** (`src/Controller/`): `ApiTranslateController` (the JSON API — dashboard, content
  and config translation CRUD, publish, batch publish, approve, mark-reviewed), `PreviewController`
  (themed draft preview via `bare_html_page_renderer`), `TranslateRedirectController` (sends core's
  translation overview to the extension).
- **Services** (`src/Service/`, all autowired): `TranslatableFieldGlue` (extract/write component-tree
  strings — a tmgmt-free fork of Canvas's `ComponentTreeFieldProcessor`), `ConfigTranslatableGlue`
  (config-override translation), `TranslationStatus` (per-language status), `TranslationDraftStore`
  and `ApprovalStore` (key/value stores `canvas_translate.drafts` / `canvas_translate.approvals`).
- **Hooks** (`src/Hook/`, attribute-based): `OutdatedFlagHooks` (entity_presave → auto-set
  `content_translation_outdated`), `DraftCleanupHooks` (entity_delete → drop drafts), `RequirementsHooks`
  (runtime_requirements). Plus `canvas_translate.install` `hook_requirements` (blocks install alongside
  `canvas_multilingual`).
- **Config entity**: `ConfigBaseline` (`canvas_translate_baseline`) — snapshots published source
  strings so config-override staleness survives config export/import.
- **Event subscriber**: `TranslateRouteSubscriber` swaps the `entity.canvas_page.content_translation_overview`
  controller (keeps its access checks).

## Key design fact

Translation drafts live in this module's OWN key/value store, NOT Canvas's `canvas.auto_save` store,
so Canvas's "publish all" never publishes an in-progress translation. Publishing writes draft text
onto the target *unconditionally* (no source-diff) so a legitimately source-equal value never
publishes empty; non-translatable fields stay shared with the source. See
[architecture/internals.md](architecture/internals.md).
