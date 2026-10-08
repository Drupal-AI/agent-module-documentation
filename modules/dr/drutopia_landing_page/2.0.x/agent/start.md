<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Landing Page (drutopia_landing_page) — agent index

A **config-only Features module** from the **Drutopia distribution** that installs a
`landing_page` content type and its supporting configuration. Package `Drutopia`. Features file
marks it `bundle: drutopia`. Core `^10.2 || ^11 || ^12`. License GPL-2.0-or-later.

**DEPRECATED:** the module's own name is "Drutopia Landing Page (DEPRECATED)" and its description
says "Use Page instead." Do not choose it for new builds; these docs cover it for legacy/audit use.

**Dev checkout:** `drutopia_landing_page.info.yml` has **no `version:` line**, so this is a
dev-branch checkout; the version dir `2.0.x` tracks the 2.0.x dev branch. It normally installs via
the Drutopia distribution, and enabling it standalone needs its full dependency chain. On this site
it did **not** enable because those deps are absent — that is expected and does not affect the docs,
which are grounded in the on-disk source.

## What it actually is

- **No `src/`, no routes, no services, no hooks, no `*.permissions.yml`, no `config/schema/`.**
  Everything is shipped YAML config under `config/install/` and `config/actions/` (~9 files).
- Provides a **Landing page node type** (`node.type.landing_page`) with two configured fields
  (`field_body_paragraph`, `field_meta_tags`), one form display, and three view displays
  (`default`, `full`, disabled `teaser`).
- Provides a **pathauto pattern** (`[node:title]`), a **promote base-field override** (defaults to
  Off), a **menu_ui** binding to the `main` menu, and an **exclude_node_title** config action.
- Ships **two config actions** that grant landing-page permissions to the Drutopia `editor` and
  `manager` roles.

## Solution doc

- **The Landing Page content type — fields, form/view displays, pathauto, exclude-node-title, and
  the editor/manager role grants** →
  [config/landing-page.md](config/landing-page.md)

## Dependencies (info.yml)

Core: field, menu_ui, node, path, user. Drutopia: drutopia_core, drutopia_seo. Contrib: ds,
entity_reference_revisions, exclude_node_title, metatag, paragraphs, pathauto. Composer also
requires `cweagans/composer-patches` and `drupal/token`.
