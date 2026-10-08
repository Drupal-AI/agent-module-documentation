<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, forms & access

Two entry points, both Drupal `FormBase` forms (POST + automatic CSRF token). All actual
translation is delegated to the parent `auto_node_translate` module.

## Per-term route

Declared at runtime by `Routing\AutoTermTranslateRouteSubscriber::alterRoutes()` (only for the
`taxonomy_term` entity type, event priority **-210** so it inherits admin status):

- id `entity.taxonomy_term.auto_translation_add`
- path `taxonomy/{taxonomy_term}/auto-translate-form`
- `_form` = `Form\TranslationForm`, `_title` = "Automatic Translation"
- requirements: `_access_auto_term_translation: taxonomy_term`, `taxonomy_term: \d+`
- options: `_admin_route: TRUE`, param upcast `taxonomy_term` → `entity:taxonomy_term`

Surfaced on each term by `Plugin\Derivative\AutoTermTranslateLocalTasks` (a local task titled
"Automatic Translation") and by `hook_entity_operation` in the `.module` file (an "Auto Translate"
row, shown only when the term has `drupal:content-translation-overview` and
`auto_node_translate_translate_access()` allows).

## Bulk vocabulary route

Static, in `auto_term_translate.routing.yml`:

- id `auto_term_translate.bulk_form`
- path `/vocabulary/{vocabulary}/bulk-auto-translate-form`
- `_form` = `Form\BulkTranslationForm`, `_admin_route: TRUE`
- requirement: `_permission: "use bulk auto translate"`

Surfaced by `hook_menu_local_tasks_alter()` as an "Auto Translate" tab on
`entity.taxonomy_vocabulary.overview_form`, its visibility also gated on `use bulk auto translate`.

## Access model

`use bulk auto translate` (`auto_term_translate.permissions.yml`) is marked `restrict access: true`
and gates the bulk form only.

The per-term route uses the custom check `Access\AutoTermTranslateAccessCheck` (service tag
`access_check applies_to: _access_auto_term_translation`). `access()`:

1. If the term is translatable, load the entity type definition, read
   `translation.content_translation.access_callback`, and call it on the entity.
2. If that result is allowed, return it — i.e. it inherits **core content-translation access**.
3. Otherwise fall back to `AccessResult::allowedIfHasPermission()` on `auto translate {bundle}
   taxonomy_term` (or `auto translate taxonomy_term` for entity types without bundle granularity).
   Taxonomy terms use bundle granularity, so the effective fallback permission is
   `auto translate {vid} taxonomy_term`, defined by the parent module's
   `AutoNodeTranslatePermissions::contentPermissions()`.
4. Non-translatable entity → `AccessResult::neutral()`.

## Forms & translation logic

`Form\TranslationForm` (per term):
- `buildForm()` lists a checkbox per site language except the term's own langcode; each is labelled
  "new translation" or "overwrite translation" depending on `Term::hasTranslation()`.
- `validateForm()` errors if `auto_node_translate.settings:default_api` is empty
  ("translation API is not configured!").
- `submitForm()` calls `autoTaxonomyTranslateTerm($term, $lid)` for each ticked language, then
  redirects to `entity.taxonomy_term.canonical`.
- `autoTaxonomyTranslateTerm()`: gets/creates the target translation, instantiates the configured
  provider via `plugin.manager.auto_node_translate_provider`, then for each field translates text
  fields (`Translator::translateTextField`), `link` fields (`translateLinkField`) and
  `entity_reference_revisions`/paragraph fields (`translateParagraphField`), copies excluded/other
  fields verbatim, sets a new revision (log "Automatic translation using <api>", current user &
  request time) and `save()`s.

`Form\BulkTranslationForm extends TranslationForm`:
- `buildForm($form, $state, $vocabulary)` lists languages except the vocabulary's langcode.
- `submitForm()` queries every term with `vid == $vocabulary` (`accessCheck(FALSE)` — bulk-scope
  load behind the restrict-access permission), builds a Batch with a single operation
  `translateTerms(count, terms[], languages[])`.
- `translateTerms()` is the batch worker: `batchSize = 1` (one term per step), calls
  `autoTaxonomyTranslateTerm()` per selected language, updates `$context` progress.
- `finished()` shows "N terms processed." then redirects to the vocabulary overview.

Provider note: with the parent's default MyMemory provider, each translatable field value becomes an
outbound HTTPS request, so a bulk run over a large vocabulary fans out into many provider calls —
size the run accordingly and watch the provider's quota.
