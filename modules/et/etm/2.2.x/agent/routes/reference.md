<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes & permissions reference

All routes in `enhanced_taxonomy_manager.routing.yml`. `{taxonomy_vocabulary}` upcasts to a
`taxonomy_vocabulary` entity; `{taxonomy_term}` to a `taxonomy_term`. All carry
`options._admin_route: TRUE`. Unless noted, access is `_etm_access: 'TRUE'` (→
`EtmAccessCheck::access`, i.e. `administer taxonomy` OR per-vocabulary `etm manage terms in {vid}`;
for term-scoped routes the vid is derived from the term's bundle).

## Pages / forms

| Route | Path | Handler | Access |
|---|---|---|---|
| `.dashboard` | `/admin/structure/taxonomy/etm-dashboard` | `dashboard_controller:dashboard` | `_permission: administer taxonomy` |
| `.settings` | `/admin/config/content/enhanced-taxonomy-manager` | `Form\SettingsForm` | `_permission: administer taxonomy` |
| `.vocabulary_overview` | `/admin/structure/taxonomy/{taxonomy_vocabulary}/tree` | `tree_controller:vocabularyOverview` | `_etm_access` |
| `.add_term` | `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/add-term` | `Form\TermForm` | `_etm_access` |
| `.term_edit` | `/admin/structure/taxonomy/term/{taxonomy_term}/edit-ajax` | `Form\TermEditForm` | `_etm_access` |
| `.term_delete` | `/admin/structure/taxonomy/term/{taxonomy_term}/delete-ajax` | `_entity_form: taxonomy_term.delete` | `_entity_access: taxonomy_term.delete` (core) |
| `.term_merge` | `/admin/structure/taxonomy/term/{taxonomy_term}/merge` | `Form\MergeTermsForm` | `_etm_access` |
| `.normalize_weights` | `/admin/structure/taxonomy/{taxonomy_vocabulary}/normalize-weights` | `Form\NormalizeWeightsForm` | `_etm_access` |
| `.restore_snapshot` | `/admin/structure/taxonomy/{taxonomy_vocabulary}/restore-snapshot/{snapshot_id}` | `Form\RestoreSnapshotForm` | `_etm_access` (`snapshot_id: \d+`) |

## Term AJAX (mutations are POST; each validates the `X-CSRF-Token` header against the `taxonomy_manager` token via `EtmControllerBase::validateCsrfToken`)

| Route | Path (method) | Controller method |
|---|---|---|
| `.term_update` | `.../term/{taxonomy_term}/update-tree` (POST) | `term_controller:updateTermPosition` |
| `.save_order` | `.../manage/{taxonomy_vocabulary}/save-order` (POST) | `term_controller:saveOrderBatch` |
| `.term_rename` | `.../term/{taxonomy_term}/rename` (POST) | `term_controller:renameTerm` |
| `.create_term_json` | `.../manage/{taxonomy_vocabulary}/create-term-json` (POST) | `term_controller:createTermJson` |
| `.update_term_json` | `.../term/{taxonomy_term}/update-json` (POST) | `term_controller:updateTermJson` |
| `.clone_term` | `.../term/{taxonomy_term}/clone` (POST) | `term_controller:cloneTerm` |
| `.find_replace_execute` | `.../manage/{taxonomy_vocabulary}/find-replace` (POST) | `term_controller:findAndReplaceExecute` |
| `.term_data` | `.../term/{taxonomy_term}/data` (GET) | `term_controller:getTermData` |
| `.term_usage` | `.../term/{taxonomy_term}/usage` (GET) | `term_controller:getTermUsage` |
| `.usage_counts` | `.../manage/{taxonomy_vocabulary}/usage-counts` (GET) | `term_controller:getUsageCounts` |
| `.term_description` | `.../term/{taxonomy_term}/description` (GET) | `term_controller:getTermDescription` |
| `.find_replace_preview` | `.../manage/{taxonomy_vocabulary}/find-replace-preview` (GET) | `term_controller:findAndReplacePreview` |

## Tree / analysis AJAX (`tree_controller`)

`.term_children` (GET `/term/{taxonomy_term}/children`), `.load_more` (GET
`.../{taxonomy_vocabulary}/load-more`), `.search_terms` (GET `.../search-terms`), `.filter_terms`
(GET `.../filter-terms`), `.vocab_stats` (GET `.../stats`), `.health_check` (GET `.../health-check`),
`.recently_modified` (GET `.../recently-modified`), `.find_duplicates` (GET `.../find-duplicates`),
`.fix_orphans` (POST `.../fix-orphans`, CSRF-checked in the method).

## Snapshots / undo AJAX (`snapshot_controller`)

`.save_snapshot` (POST), `.get_snapshots` (GET), `.delete_snapshot` (POST), `.delete_all_snapshots`
(POST), `.undo_revision` (POST), `.get_revisions` (GET), `.undo_count` (GET), all under
`/admin/structure/taxonomy/{taxonomy_vocabulary}/…`. POST routes validate the CSRF header.

## Export / import (`export_import_controller`)

| Route | Path (method) | Access |
|---|---|---|
| `.export_csv` | `.../manage/{taxonomy_vocabulary}/export-csv` (GET) | `_custom_access: EtmAccessCheck::exportAccess` |
| `.export_list` | `.../manage/{taxonomy_vocabulary}/export-list` (GET) | `_custom_access: EtmAccessCheck::exportAccess` |
| `.bulk_import` | `.../manage/{taxonomy_vocabulary}/bulk-import` (POST) | `_custom_access: EtmAccessCheck::importAccess` (CSRF-checked) |
| `.bulk_operation` | `.../manage/{taxonomy_vocabulary}/bulk-operation` (POST) | `_etm_access` (CSRF-checked) |

`exportAccess` grants `administer taxonomy` or `etm manage terms in {vid}` or `etm export terms in
{vid}`; `importAccess` grants `administer taxonomy` or `etm manage terms in {vid}` or `etm import
terms in {vid}`.

## Menu / task / action links

`.links.menu.yml` (dashboard + settings under system config), `.links.task.yml` (local tasks),
`.links.action.yml` (an "Add term" action on the tree page).
