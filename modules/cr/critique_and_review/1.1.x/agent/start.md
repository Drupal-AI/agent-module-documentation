<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Critique And Review Content (critique_and_review) — agent index

A structured **peer-review workflow for node content**. Reviewers fill a template of *Review Items*
(titled sections with basic_html bodies) in a block-placed form; finished reviews come back to the
content author on the node edit form. Version **1.1.2**. Core `^9 || ^10 || ^11`. License
GPL-2.0-or-later. No composer deps; no declared module dependencies (uses core `node`, `user`,
`block`, `system` implicitly).

- **Settings form, config object + schema, Review Items, the admin route** →
  [config/settings.md](config/settings.md)
- **The review block, the review form, storage table, and the node-edit-form display** →
  [block/review-workflow.md](block/review-workflow.md)

## What it actually is

- **One block plugin**: `CritiqueAndReviewBlock` (id **`critique_and_review_block`**, label *"Critique
  And Review Block"*), `src/Plugin/Block/CritiqueAndReviewBlock.php`. Placed via block layout on node
  pages. Renders the review form to authenticated non-authors; shows the author a status message +
  edit link.
- **Two forms**: `TemplateCritiqueAndReviewForm` (`FormBase`, id `review_template_review_form`) is the
  reviewer's templated form embedded by the block; `CritiqueAndReviewSettingsForm` (`ConfigFormBase`,
  id `critique_and_review_admin_settings`) is the admin config form.
- **One route**: `critique_and_review.admin_settings` → `/admin/config/content/critique_and_review`,
  `_permission: 'administer critique_and_review module'` (see caveat below). Menu link under
  Configuration → Content authoring (`*.links.menu.yml`).
- **One config object**: `critique_and_review.settings` (schema `config/schema/*.schema.yml` labels it
  `review.settings`; install defaults in `config/install/*.settings.yml`).
- **One custom DB table**: `critique_and_review_reviews` (`hook_schema` in `*.install`) — reviews are
  plain table rows keyed by uid/nid/vid, **not** a Drupal entity. No revisioning of the row itself.
- **Procedural helpers** in `*.module`: `critique_and_review_get_reviewer()`,
  `_get_user_reviews()`, `_get_reviews()` (direct `db->select()` queries with `->condition()` — no
  string concatenation), plus `hook_form_alter()` and `hook_help()`.
- **One library**: `critique_and_review/critiqueFormScript` (`js/critique_and_review.js` toggles the
  submit button label Save Draft ↔ Finalise Review; `css/critique_and_review.css`). Depends on
  `core/drupal`, `core/jquery`. Attached only when the `add_css` setting is on.
- **No permissions.yml**, no Drush, no services, no plugin types, no entity types, no submodules.

## Caveats worth knowing

- The admin route requires permission **`administer critique_and_review module`**, but the module ships
  **no `*.permissions.yml`** — that permission is undefined, so no role grants it and only user 1 (the
  superuser bypass) can reach the settings form. Config can also be set via `drush cset` / config import.
- Reviews live in `critique_and_review_reviews` and are removed only by the reviewer's own delete
  checkbox; **uninstall (`hook_schema`) drops the table** but nothing prunes rows when a node is deleted.
