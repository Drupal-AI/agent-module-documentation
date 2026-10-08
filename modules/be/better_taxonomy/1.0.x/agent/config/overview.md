<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Taxonomy — overview page, routes, forms, services

Enhances the core taxonomy term overview. No install-time configuration: enable
`better_taxonomy` (`ddev drush en better_taxonomy -y`) and every vocabulary's
Structure → Taxonomy → *Overview* is replaced by the enhanced page. There is no settings
form, no config object, no schema, no permissions of its own.

## How the overview is replaced

- `Routing\MainMenuRouteSubscriber::alterRoutes()` rewrites the **core** route
  `entity.taxonomy_vocabulary.overview_form` to path
  `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/list`.
- `better_taxonomy.routing.yml` defines `better_taxonomy.list` at that **same path**,
  served by `Form\ListForm` (permission `access taxonomy overview`).
- `Hook\BetterTaxonomyHooks::localTasksAlter()` unsets the original core "List" local task
  (`better_taxonomy.links.task.yml` re-adds a "List" tab at weight `-999` on the vocabulary
  overview base route). `preprocessHtml()` adds the body class `better-taxonomy-overview-page`
  on `better_taxonomy.list`.
- `ListForm::buildForm()` attaches library `better_taxonomy/main` and calls
  `createSectionCoreForm()`, which renders the untouched core form
  `Form\CoreOverviewTerms` (id `taxonomy_overview_terms`) as `$form['core']`. So all core
  overview behaviour (weights, drag reorder, per-term operations) is preserved.

## Filter (search)

- `CoreOverviewTerms::buildForm()` calls `BTService::checkSearch()`, which reads the
  `search` query parameter. With **no** `search`, it defers to core
  `taxonomy\Form\OverviewTerms::buildForm()`. With a `search` value it instead calls
  `BTService::getSearchList($search, $vid)` and renders `BTService::getSearchResults()`.
- `getSearchList()` runs an **entity query** on `taxonomy_term`:
  `condition('vid', $vid)`, `condition('name', '%'.$search.'%', 'LIKE')`, `sort('name')` —
  parameterized by the entity-query layer. Route already requires `access taxonomy overview`.
- `getSearchResults()` builds a `#type => table` (columns Name/Level/Parent/Status/Operations;
  Level and Parent columns are dropped for flat vocabularies). Rows come from
  `getTableRow()`: term name as a `#type => link`, per-term operations from the core term
  list builder, status Published/Unpublished. Depth is computed from `loadParents()`/`loadTree()`.
- The filter UI is `createSectionFilter()`: a `search` textfield plus hidden `Filter` submit
  (`submitFilter` redirects to `better_taxonomy.list` with `?search=`) and, when filtering,
  a `Clear filter` submit (`submitClearFilter` redirects without `search`).

## Add multiple terms

- Route `better_taxonomy.add_multiple`, gated by `_entity_create_access: taxonomy_term:{taxonomy_vocabulary}`
  (core per-vocabulary term-create access). Action links on the list page come from
  `better_taxonomy.links.action.yml` ("Add term" → core add form; "Add multiple terms").
- `Form\AddMultipleForm::buildForm()`: hidden `vocabulary`, a required `terms` textarea
  (one term per line; a leading single dash `-` per level indicates hierarchy depth), and,
  for vocabularies with depth > 0, a fieldset of **cascading AJAX parent selects** built by
  `BTFormsService::getMultilevelSelects()` (each `level_N` select's `#ajax` calls
  `AddMultipleForm::formSelectCallback()` to rebuild deeper levels).
- Submit → `BTService::addMultipleTerms($values)`:
  - `getBaseTerm()` picks the deepest chosen `level_*` select as the parent tid (0 = root).
  - `parseMultipleTerms()` splits the textarea on `PHP_EOL`, `trim()`s and **`sanitizeName()`**s
    each line (`htmlspecialchars(strip_tags($name), ENT_QUOTES)` then `Html::escape()`),
    truncates to the vocabulary name field's `max_length` (default 255), then `buildNamesTree()`
    converts dash-indentation into a nested `{name, children}` tree.
  - `recursiveCreateTerms()` walks the tree, `Term::create([...])->save()` for each, attaching
    children to their parent tid (top level attaches to the chosen base term).
  - Submit reports "@count term(s) added" and redirects to the vocabulary `overview-form`.

## Delete all terms

- Route `better_taxonomy.delete_all` → `Form\DeleteAllForm` (`ConfirmFormBase`), access via
  `DeleteAllForm::access(Vocabulary, AccountInterface)`: **allow** if the account has
  `administer taxonomy`, else `AccessResult::allowedIfHasPermission($account, "delete terms in $vid")`
  (core's per-vocabulary delete permission). It is a POST confirm form (CSRF-protected), not a
  direct GET action.
- The action link is surfaced in three places, each after an access check so it only appears
  to users who can actually delete:
  - `VocabularyOverrideListBuilder::getDefaultOperations()` — the vocabulary **collection**
    operations dropdown (installed by `entity_type_alter` swapping the list builder).
  - `BetterTaxonomyHooks::formTaxonomyVocabularyFormAlter()` — an action link on the
    vocabulary **edit** form (with a `destination` back to the collection).
  - `ListForm::buildForm()` — a link inside the enhanced **overview** page, shown only when
    `BTService::checkIfTermsInVocabulary()` finds terms AND
    `checkUserAccessToVocabularyRoute('better_taxonomy.delete_all', $vid)` passes.
- Submit → `DeleteAllBatch::initiateBatchProcessing()`: `loadTree($vocabulary, 0, NULL, FALSE)`
  loads every term, `operationCallback()` deletes them one per batch step
  (`Term::load($tid)->delete()`), `finishedCallback()` reports the plural "@count terms were
  deleted." Redirects to the vocabulary `overview-form`.

## Services & helpers

- `better_taxonomy.better_taxonomy_service` → `BTService` (args: `entity_type.manager`,
  `request_stack`, `entity_field.manager`, `access_manager`, `current_user`). Notable methods:
  `getVocabularyMaxDepth($vid)` runs a **recursive CTE** raw SQL over
  `{taxonomy_term_field_data}` / `{taxonomy_term__parent}` (bound `:vid`) returning max hierarchy
  depth; `checkUserAccessToVocabularyRoute()` wraps `access_manager->checkNamedRoute()`.
- `better_taxonomy.better_taxonomy_forms_service` → `BTFormsService` (arg: `entity_type.manager`).
- `better_taxonomy.main_menu_route_subscriber` → `MainMenuRouteSubscriber` (tagged
  `event_subscriber`).
- `Hook\BetterTaxonomyHooks` service (arg: `current_route_match`).

## Operating notes

- Enable and it takes over immediately for **all** vocabularies; nothing to configure.
- Access is entirely core taxonomy permissions: `access taxonomy overview` (view the page),
  per-vocabulary `create terms in {vid}` (bulk add), `administer taxonomy` or
  `delete terms in {vid}` (delete all).
- "Delete all terms" is irreversible; it is a batch process so it scales to large vocabularies.
- Bulk-add hierarchy syntax: no dash = root (or the selected parent), `-` = one level deeper,
  `--` = two levels, etc. Blank lines are dropped; each name is tag-stripped and length-capped.
