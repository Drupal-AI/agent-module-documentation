<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Page (drutopia_page) — agent index

A **config-only Features module** from the **Drutopia distribution** that installs a `page`
(Basic page) content type and its supporting configuration. Package `Drutopia`. Features file
marks it `bundle: drutopia`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later. It is the
**recommended replacement for the deprecated `drutopia_landing_page`**.

**Dev checkout:** `drutopia_page.info.yml` has **no `version:` line**, so this is a dev-branch
checkout; the version dir `2.0.x` tracks the 2.0.x dev branch. It normally installs via the
Drutopia distribution, and enabling it standalone requires its full dependency chain. On this
site it did not enable because those deps are absent; that is expected and does not affect the
docs, which are grounded in the on-disk source.

## What it actually is

- **No `src/`, no routes, no services, no hooks, no `*.permissions.yml`, no `config/schema/`.**
  Everything is shipped YAML config under `config/install/` and `config/actions/` (~12 files).
- Provides a **Page node type** (`node.type.page`) with four fields (`field_summary`,
  `field_body_paragraph`, `field_meta_tags`, `body`), one form display, and **three view
  displays** (default, full, teaser) built on Display Suite (`ds_1col`).
- Provides a **`promote` base-field override**, a **pathauto pattern** (`node_page` → `[node:title]`),
  and an **RDF mapping** (`schema:WebPage`).
- Ships **three config actions** that grant page permissions to Drutopia roles
  (contributor / editor / manager) — **create/edit only, no delete**.
- Ships **no field storages** of its own; all field storages come from core / Drutopia deps.

## Solution docs

- **The Page content type — fields, form display, and the three DS view displays** →
  [config/page-content-type.md](config/page-content-type.md)
- **Pathauto pattern, promote override, RDF mapping, and the role permission grants** →
  [config/urls-and-roles.md](config/urls-and-roles.md)

## Dependencies (info.yml)

Core/contrib: drutopia_core, drutopia_seo, ds, entity_reference_revisions, field, menu_ui,
metatag, node, paragraphs, path, pathauto, rdf, system, text, user. Composer `require`:
`drupal/drutopia_seo ^2`, `drupal/ds ^3`, `drupal/pathauto ^1`, `drupal/token ^1`.
