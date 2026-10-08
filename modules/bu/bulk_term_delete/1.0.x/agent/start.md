<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Term Delete (bulk_term_delete) — agent index

Adds a **"Bulk Delete Terms"** button to the core taxonomy overview page and provides a
select-then-confirm flow to permanently delete many taxonomy terms at once. Package `Taxonomy`.
Depends only on core **`taxonomy`**. Core requirement `^10.3 || ^11`. License GPL-2.0-or-later.
Version 1.0.6. **No config, no own permissions, no Drush, no plugins.**

- **Routes, forms, the alter hook, and how the flow operates** → [api/flow.md](api/flow.md)

## What it actually is

- Two form routes (`bulk_term_delete.routing.yml`), both `_permission: 'administer taxonomy'`,
  both `methods: [GET, POST]`:
  - `bulk_term_delete.term_bulk_delete` — `/admin/structure/taxonomy/bulk-delete/{vocabulary}`,
    form `BulkTermDeleteForm` (select terms).
  - `bulk_term_delete.term_bulk_delete_confirm` —
    `/admin/structure/taxonomy/bulk-delete/{vocabulary}/confirm/{tids}`, form
    `BulkTermDeleteConfirmForm` (confirm + delete).
- One OOP hook class `src/Hook/BulkTermDeleteHooks.php` (service, `autowire: true`), implementing
  `#[Hook('form_taxonomy_overview_terms_alter')]` to inject the button. The legacy procedural
  wrapper + the button's submit callback (`bulk_term_delete_redirect_submit`) live in
  `bulk_term_delete.module`.
- No entities, no config schema, no `*.permissions.yml`, no libraries, no services beyond the hook
  class.

## Mechanism (from source)

- `BulkTermDeleteHooks::formTaxonomyOverviewTermsAlter()` returns early unless the current user
  `hasPermission('administer taxonomy')` and a `taxonomy_vocabulary` is on the route; if the
  vocabulary has terms it adds a `submit` button (`#submit => ['bulk_term_delete_redirect_submit']`,
  `#weight 110`) carrying `#vocabulary`.
- `bulk_term_delete_redirect_submit()` redirects to the selection form for that vocabulary.
- `BulkTermDeleteForm::buildForm()` loads `loadTree($vocabulary)`, builds a `tableselect` (columns
  name/tid, names prefixed by `str_repeat('— ', depth)`); `submitForm()` `array_filter`s the
  checked tids and redirects to the confirm route with `tids` = comma-joined ids. A `?tids=` query
  param pre-checks rows (`array_map('intval', explode(',', …))`).
- `BulkTermDeleteConfirmForm` extends core `ConfirmFormBase` (so the apply step is a POST confirm
  form with a form token). `getDescription()` lists each term, escaped via `Html::escape`.
  `submitForm()` `loadMultiple($this->tids)` and calls `$term->delete()` per term, then logs a
  `notice` to channel `bulk_term_delete` (user name, uid, term labels), shows a status message, and
  redirects to `entity.taxonomy_vocabulary.overview_form`.

## Notes / caveats

- Deletion is **permanent** and cascades per core taxonomy term delete (children reparented, field
  references cleared) — there is no dry-run or undo.
- `tids` are cast with `intval`/`loadMultiple`; unknown/foreign ids simply load nothing. The whole
  flow is gated by the core `administer taxonomy` permission (a restricted admin permission).
