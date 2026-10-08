<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia People (drutopia_people) — agent index

A **config-only Features module** from the **Drutopia distribution** that installs a `people`
(label "Person") content type and all its supporting configuration. Package `Drutopia`. Features
file marks it `bundle: drutopia`, with `core.entity_view_display.node.people.search_index` listed
as `required`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.

**Dev checkout:** `drutopia_people.info.yml` has **no `version:` line**, so this is a dev-branch
checkout; the version dir `2.0.x` tracks the 2.0.x dev branch. It normally installs via the
Drutopia distribution, and enabling it standalone requires its full dependency chain
(drutopia_core, drutopia_seo, ds, field_group, paragraphs, pathauto, metatag, search_api,
focal_point, entity_reference_revisions, ctools, menu_ui, views_plain, and core — see the info.yml
/ `data.json`). On this site it did not enable because those deps are absent; that is expected and
does not affect the docs, which are source-grounded from on-disk config.

## What it actually is

- **No `src/`, no routes, no services, no `*.permissions.yml`, no `config/schema/`.** The only PHP
  is **`drutopia_people.install`** (one update hook). Everything else is shipped YAML config under
  `config/install/` and `config/actions/`.
- Provides a **Person node type** (`node.type.people`, name "Person") with fields, one form
  display, and **seven view displays** (default, full, teaser, card, simple_card, small_card,
  search_index).
- Provides a **Search API index** (`people`, database server) and two views: **`views.view.people`**
  (page `/people` "Our people", grouped by People type) and **`views.view.content_by_author`**
  (lists nodes referencing a person via `field_authors`; has a `block_author` block display).
- Provides **two pathauto patterns**, the **`people_type` taxonomy vocabulary**, and an
  **"Add person"** action link on the listing page.
- Ships **three config actions** that grant people permissions to Drutopia roles
  (contributor / editor / manager).
- **`drutopia_people_update_8201()`** installs the `views_plain` dependency; there is no
  `hook_install` and no other update logic.

## Solution docs

- **The Person content type — fields, form display, the seven view displays, and the `.install`
  hook** → [config/people-content-type.md](config/people-content-type.md)
- **The people & content-by-author views, Search API index, pathauto, taxonomy vocabulary, and the
  role permission grants** → [config/listing-and-roles.md](config/listing-and-roles.md)

## Dependencies (info.yml)

Core: ctools, field, menu_ui, node, path, taxonomy, text, user, views. Drutopia: drutopia_core,
drutopia_seo. Contrib: ds, entity_reference_revisions, field_group, focal_point, metatag,
paragraphs, pathauto, search_api, views_plain. Composer `require` (2.0.x): drupal/drutopia_core
^2, drupal/drutopia_seo ^2, drupal/ds ^3, drupal/field_group ^4, drupal/pathauto ^1,
drupal/paragraphs ^1, drupal/views_plain ^1.
