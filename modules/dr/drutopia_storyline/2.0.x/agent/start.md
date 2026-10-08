<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drutopia Storyline (drutopia_storyline) — agent index

**A configuration-only Drutopia feature: two Storyline Paragraphs types (`storyline_header`, `storyline_item`) with their fields and form/view displays, plus a multi-value `entity_reference_revisions` node field `field_storyline`, for building a simple chronology/timeline. No PHP — no `src/`, `.module`/`.install`, routes, permissions, services, config schema or Drush.**

- **Version:** 2.0.x — **DEV CHECKOUT** on disk (`info.yml` has no `version:`; installed from git branch `2.0.x`). No packaged release version.
- **Distribution:** ships as part of the Drutopia family (`drutopia_storyline.features.yml`: `bundle: drutopia`, `required: true`); requires `drutopia_core` and `drutopia_page`. On this site it FAILED to enable because the full Drutopia dependency chain is absent — that is expected; these docs are written from on-disk source, not a running instance.
- **Core:** `^10.2 || ^11 || ^12` · **Package:** Drutopia · **License:** GPL-2.0-or-later.
- **Depends on:** drutopia_core, drutopia_page, entity_reference_revisions, field, field_group, node, paragraphs, text.
- **Composer require:** drupal/drutopia_core ^2, drupal/drutopia_page ^2, drupal/field_group ^4.

## What it actually ships (12 files in `config/install/`)

- **Two Paragraphs types:** `storyline_header` and `storyline_item` (`paragraphs.paragraphs_type.*.yml`), no description, no behavior plugins.
- **Node field:** `field_storyline` — `entity_reference_revisions` to `paragraph`, cardinality **-1** (unlimited), translatable (`field.storage.node.field_storyline.yml`). No `field.field.*` instance is shipped for it here (the companion module / your own config attaches it to a bundle).
- **Paragraph fields:** `field_storyline_header` (string, on `storyline_header`); `field_storyline_heading` (string) + `field_text` (`text_long`, storage reused from elsewhere) on `storyline_item`.
- **Displays:** default form + default view display for each bundle; the `storyline_item` view display groups heading + text via a `field_group` `html_element` group `group_storyline_content`.
- **No** `src/`, routing, permissions, services, install hooks, config schema, Drush, or documented submodules.

## Companion module (out of scope here)

The project directory also bundles `drutopia_page_storyline/` — a sub-feature that adds `field_storyline` to the **Basic page** node type (`field.field.node.page.field_storyline`) and wires it into the page form/view displays via `config/actions/`. Per campaign scope it is treated as a separate project and documented elsewhere; it is not covered by this document.

## Solution docs

- **The two paragraph types, all fields, storages, form/view displays and the field group** → [paragraphs/storyline.md](paragraphs/storyline.md)

## Operate it

Enable the module (imports the paragraph types, fields and displays). Attach `field_storyline` to a content type — or enable the bundled companion to attach it to Basic page — then let editors add a `storyline_header` followed by repeatable `storyline_item` paragraphs. There is no admin settings form (`configure` is null).
