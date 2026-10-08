<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Taxonomy (better_taxonomy) — agent index

Enhances Drupal core's **taxonomy term overview** page. It repoints the core overview
route to `.../{vocabulary}/list`, embeds the unchanged core overview form inside its own
`ListForm`, and layers on three features: a **name filter**, a **bulk "Add multiple terms"**
form (dash-indented hierarchy), and a **"Delete all terms"** batch operation. Package
`Taxonomy`. Depends only on core **`taxonomy`**. Core requirement `^10.2 || ^11`. License
GPL-2.0-or-later. Version 1.0.3 (dir 1.0.x). **No entities, no permissions, no config, no
Drush, no plugins.**

- **Routes, forms, the filter/bulk-add/delete-all mechanics, services and hooks, how to operate it** →
  [config/overview.md](config/overview.md)

## What it actually is (from source)

- **3 routes** (`better_taxonomy.routing.yml`):
  - `better_taxonomy.list` → `Form\ListForm` at `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/list`, permission **`access taxonomy overview`**.
  - `better_taxonomy.add_multiple` → `Form\AddMultipleForm` at `.../add-multiple`, gated by **`_entity_create_access: taxonomy_term:{taxonomy_vocabulary}`**.
  - `better_taxonomy.delete_all` → `Form\DeleteAllForm` at `.../delete-all`, gated by **`_custom_access: DeleteAllForm::access`** (allows `administer taxonomy` OR per-vocabulary `delete terms in {vid}`).
- **RouteSubscriber** `Routing\MainMenuRouteSubscriber` rewrites the *core* route `entity.taxonomy_vocabulary.overview_form` path to `.../{taxonomy_vocabulary}/list` so the core "Overview" link lands on the enhanced page.
- **Hooks** (OOP `Hook\BetterTaxonomyHooks`, wired via `#[Hook]` + `#[LegacyHook]` shims in `.module`):
  - `entity_type_alter` swaps the `taxonomy_vocabulary` list builder to `VocabularyOverrideListBuilder` (adds a "Delete all terms" operation).
  - `form_taxonomy_vocabulary_form_alter` adds a "Delete all terms" action link to the vocabulary edit form.
  - `local_tasks_alter` unsets the original core "List" local task; `preprocess_html` adds a body class on the list route.
- **2 services** (`better_taxonomy.services.yml`): `BTService` (search, bulk-create, max-depth, access helper) and `BTFormsService` (cascading AJAX parent selects).
- **1 asset library** `better_taxonomy/main` (`js/better_taxonomy.js` + `scss/better_taxonomy.css`); no external/CDN dependency.

## Key source files

- `src/Form/ListForm.php` — enhanced overview; embeds `Form\CoreOverviewTerms`.
- `src/Form/CoreOverviewTerms.php` — wraps core `taxonomy\Form\OverviewTerms`, adds the filter, swaps to search results when `?search=` is present.
- `src/Form/AddMultipleForm.php` — bulk term entry + AJAX parent selects; submit → `BTService::addMultipleTerms()`.
- `src/Form/DeleteAllForm.php` — `ConfirmFormBase`; `access()` method; submit → `DeleteAllBatch::initiateBatchProcessing()`.
- `src/DeleteAllBatch.php` — Batch API delete of every term (`loadTree` → per-term `delete()`).
- `src/BTService.php` — `checkSearch()`, `getSearchList()` (entity-query `LIKE`), `getVocabularyMaxDepth()` (recursive CTE SQL), `addMultipleTerms()`/`recursiveCreateTerms()`, `sanitizeName()`, `checkUserAccessToVocabularyRoute()`.
- `src/BTFormsService.php` — `getMultilevelSelects()` cascading `#ajax` selects.
- `src/VocabularyOverrideListBuilder.php` — extends core `VocabularyListBuilder`, adds delete-all operation when the user passes `better_taxonomy.delete_all` access.
