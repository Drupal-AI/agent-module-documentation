<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Babel Brush — search & delete source strings

Everything Babel Brush does lives in one form plus one service.

## Install & enable

- `drush en babel_brush` (or via the UI). Core **`locale`** is a hard dependency and is enabled
  automatically. Works on Drupal 10 and 11.
- Grant **`administer babel brush search form`** (People → Permissions) to a trusted role. It is
  declared `restrict access: TRUE`, so Drupal warns it is a security-sensitive permission.
- Open **Configuration → Regional and language → Babel Brush**
  (`/admin/config/babel_brush/search`). There are no other settings — no config form, no config
  objects, no schema.

## Route & permission

- Route `babel_brush.search_form` (`babel_brush.routing.yml`):
  `path: /admin/config/babel_brush/search`, `_form: \Drupal\babel_brush\Form\BabelBrushSearchForm`,
  `_permission: 'administer babel brush search form'`.
- Menu link `babel_brush.search_form` (`babel_brush.links.menu.yml`) parents to
  `system.admin_config_regional`, weight 100.

## The form — `BabelBrushSearchForm` (`src/Form/BabelBrushSearchForm.php`)

- Extends `FormBase`; `getFormId()` = `babel_brush_search_form`; `create()` injects
  `babel_brush.service`.
- `buildForm()`:
  - required `keyword` textfield + `Search` submit.
  - `search_results` container at `#weight => 100`.
  - When the form has a triggering element, it reads `keyword` and calls
    `BabelBrushService::getAllSourcesStringsByKeyword()`. For non-empty results it adds
    **Select all** / **Deselect all** buttons, then one `#type => checkbox` per row keyed
    `lid_<lid>` whose `#title` is the source string, plus (when the row has a `context`) a
    `#markup` line `"<small>Context: …</small>"`, and a hidden **Delete** submit button
    (`#submit => ['::deleteSourcesStrings']`, `id => delete-button`, initially
    `display: none;`). No matches → a "no results found" message.
  - Always attaches library `babel_brush/select_toggle`.
- `submitForm()` (the Search button) just sets `$form_state->setRebuild(TRUE)` so results render.
- `deleteSourcesStrings()` (the Delete button) walks `$form_state->getValues()`, keeps every key
  containing `lid` whose value is truthy, strips the `lid_` prefix to get the lid, and calls
  `BabelBrushService::deleteSourceStringByLids()`. Standard Form API POST — CSRF token enforced by
  core; there is no confirmation step and no undo.

## The JS — `js/select_toggle.js`

`Drupal.behaviors.selectToggle` binds Select all (checks every checkbox, shows the Delete button)
and Deselect all (unchecks all, hides the Delete button). Library depends on
`core/jquery`, `core/drupal`, `core/drupalSettings`. Note the button selectors query the whole
document, so it assumes a single form instance on the page.

## The service — `BabelBrushService` (`src/Service/BabelBrushService.php`)

Service id `babel_brush.service`; constructor injects `@database` (`Connection`) and
`@logger.factory` (channel `babel_brush`).

- `getAllSourcesStringsByKeyword(string $keyword): array` —
  `select('locales_source','ls')` → `leftJoin('locales_target','lt','ls.lid = lt.lid')`,
  `fields('ls', ['lid','source','context'])`,
  `condition('ls.source', '%'.$this->database->escapeLike($keyword).'%', 'LIKE')`,
  returns `fetchAll()`. The keyword is parameterized and `escapeLike`-escaped (so `%`/`_` in the
  input are literal).
- `deleteSourceStringByLids(array $lids): bool` — try/catch wrapper that calls the two protected
  deletes; on exception logs `getTraceAsString()` to the `babel_brush` channel and returns FALSE,
  else TRUE.
- `deleteSourceStringInLocalesSourceTable()` / `deleteSourceStringInLocalesTargetTable()` —
  `delete('locales_source' | 'locales_target')->condition('lid', $lids, 'IN')->execute()`.
  Lids are bound as an IN-array (parameterized). Because both tables are cleared, deleting a source
  string also removes all of its translations.

## Operating notes / caveats (alpha)

- **Destructive & irreversible.** Delete runs immediately with no confirm dialog and no undo;
  removed source strings and their translations are gone until the next locale re-scan re-imports
  any that still exist in code/`.po` files.
- Empty search returns nothing actionable; the keyword is a substring `LIKE` match on the source
  text only (not on translations or context).
- Provides no import/export, no batching (all matches load at once — a very broad keyword can
  build a large form), and no config to tune. This is a minimal alpha maintenance tool.
