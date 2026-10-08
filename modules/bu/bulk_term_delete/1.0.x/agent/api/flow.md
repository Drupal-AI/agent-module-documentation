<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Term Delete — routes, forms & delete flow

Everything the module does. No config objects, no permissions of its own, no services beyond one
hook class. Install with `drush en bulk_term_delete -y`; it needs only core `taxonomy`.

## Entry point — the alter hook

`src/Hook/BulkTermDeleteHooks.php` (registered as an autowired service in
`bulk_term_delete.services.yml`) implements:

```
#[Hook('form_taxonomy_overview_terms_alter')]
public function formTaxonomyOverviewTermsAlter(&$form, $form_state, $form_id)
```

- Reads `taxonomy_vocabulary` from the route match; **returns early** unless it is present AND
  `currentUser->hasPermission('administer taxonomy')`.
- If `loadByProperties(['vid' => $vocabulary->id()])` is non-empty, adds
  `$form['actions']['bulk_delete_redirect']` — a `submit` button labeled "Bulk Delete Terms",
  `#weight 110`, `#submit => ['bulk_term_delete_redirect_submit']`, `#vocabulary => $vocabulary->id()`.

`bulk_term_delete.module` holds the D11 `#[LegacyHook]` procedural wrapper (delegates to the class)
and the button callback `bulk_term_delete_redirect_submit()`, which does
`$form_state->setRedirect('bulk_term_delete.term_bulk_delete', ['vocabulary' => …])` from the
triggering element's `#vocabulary`.

## Routes (`bulk_term_delete.routing.yml`)

Both routes require `_permission: 'administer taxonomy'` and allow `[GET, POST]`.

| Route id | Path | Form |
|---|---|---|
| `bulk_term_delete.term_bulk_delete` | `/admin/structure/taxonomy/bulk-delete/{vocabulary}` | `BulkTermDeleteForm` |
| `bulk_term_delete.term_bulk_delete_confirm` | `/admin/structure/taxonomy/bulk-delete/{vocabulary}/confirm/{tids}` | `BulkTermDeleteConfirmForm` |

`{vocabulary}` is the vocabulary machine name (plain string, not an entity upcast). `{tids}` is a
comma-separated list of term ids.

## Step 1 — selection form (`src/Form/BulkTermDeleteForm.php`)

- `buildForm($form, $form_state, $vocabulary)`:
  - Optional pre-selection: `?tids=` query param → `array_map('intval', explode(',', …))`, used as
    `#default_value`.
  - `entityTypeManager->getStorage('taxonomy_term')->loadTree($vocabulary)` builds the option list;
    each row is `name` (prefixed `str_repeat('— ', $term->depth)` for hierarchy) and `tid`.
  - Renders a `#type => 'tableselect'` (`terms_table`) with a `danger`-styled "Delete selected
    terms" submit button.
- `submitForm()`: `array_filter($form_state->getValue('terms_table'))`. If nothing checked → warning
  "No terms selected." and return. Otherwise redirect to the confirm route with
  `tids => implode(',', array_keys($selected))` and the vocabulary from the request attributes.

## Step 2 — confirm form (`src/Form/BulkTermDeleteConfirmForm.php`)

Extends core `ConfirmFormBase`, so the apply action is a standard POST confirmation form (Drupal
form token / CSRF protection applies).

- `buildForm(…, $vocabulary, $tids)`: stores `$this->vocabulary` and
  `$this->tids = array_map('intval', explode(',', $tids))`.
- `getQuestion()` → "Are you sure you want to delete the following terms?".
- `getDescription()`: `loadMultiple($this->tids)` and builds an escaped `<ul>` list — each item is
  `Html::escape($term->label()) . ' (TID: ' . (int) $term->id() . ')'`, wrapped with
  `Markup::create()`. Label output is escaped; ids are int-cast.
- `getConfirmText()` → "Delete". `getCancelUrl()` returns to the selection form with the tids
  preserved as a query param.
- `submitForm()`:
  - `loadMultiple($this->tids)`, then per term: record `label (TID: id)` and call `$term->delete()`
    (core cascade — children reparented, references cleaned).
  - Logs `notice` to the `bulk_term_delete` channel: `User "@user" (UID: @uid) deleted terms:
    @terms` (via `LoggerChannelFactoryInterface`, injected in the constructor).
  - `messenger()->addStatus('@count term(s) deleted.')` and
    `setRedirect('entity.taxonomy_vocabulary.overview_form', ['taxonomy_vocabulary' => $vocabulary])`.

## Operating notes

- The button only appears for users with `administer taxonomy` and only when the vocabulary has at
  least one term. The routes enforce the same permission independently, so deep-linking the URLs
  gains nothing without the permission.
- Deletion is immediate and permanent on confirm; there is no batch API, so very large selections
  delete synchronously in one request (watch request time on huge vocabularies).
- No config, no schema, no install/uninstall hooks, no libraries. Uninstalling removes only the
  routes/button; existing terms are untouched.
