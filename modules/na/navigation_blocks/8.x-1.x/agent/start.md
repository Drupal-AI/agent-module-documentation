<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation Blocks (navigation_blocks) — agent index

Front-end **block plugins** for site wayfinding: a configurable back button (referer/entity/reference driven) and a client-side table of contents. Installed version **8.x-1.0-alpha27** (version dir `8.x-1.x`). `core_version_requirement: ^9 || ^10 || ^11`.

## What it is
- Placed and configured entirely through **core's Block UI**. No custom routes, permissions, config entities, or config schema.
- Dependencies: `drupal:block`, `drupal:link` (core). CKEditor plugin targets **CKEditor 4** (`Drupal\ckeditor`), which is not present on default D10/D11.

## Block plugins (`src/Plugin/Block/`)
- `back_button` — `BackButton`. Generic/referer back button. Config: `preferred_paths`, `link` (url/text fallback), `use_preferred_page_title`, `preferred_link_text`, `use_javascript`.
- `entity_canonical_back_button` (derived per entity type) — `EntityCanonicalBackButton` → links to context entity's canonical URL; suppressed on canonical routes.
- `entity_reference_back_button` (derived) — `EntityReferenceBackButton` → follows a chosen entity-reference field forward.
- `reversed_entity_reference_back_button` (derived) — `ReversedEntityReferenceBackButton` → finds an entity referencing the context entity.
- `toc` — `TocBlock`. Table of contents; config: `max_heading_level`, `wrapper`, `only_allowed`, `list_class`, `link_class`.

## Plugin derivers (`src/Plugin/Deriver/`)
`EntityBackButtonDeriverBase` derives one block per entity type that has a view builder; subclasses set the admin label. Adds an `entity` context definition per type.

## Services (`navigation_blocks.services.yml`)
- `navigation_blocks.path_matcher` → `PathMatcher` (referer/path-alias/wildcard matching).
- `navigation_blocks.back_button_manager` → `BackButtonManager` (builds the back link, referer handling, link attributes).
- `navigation_blocks.entity_button_manager` → `EntityButtonManager` (entity-reference field discovery + resolution).
- `navigation_blocks.toc_builder` → `TocBuilder` (fluent builder for the TOC render array + drupalSettings).

## JS libraries (`navigation_blocks.libraries.yml`)
- `history-back` — click handler for `a.js-history-back`.
- `toc` — bundled `bootstrap-toc.js` + behavior; reads `drupalSettings.navigation_blocks.toc`.

## Solution docs
- [Back button blocks](plugins/back-buttons.md) — the four back-button plugins, derivers, config keys, referer/entity logic.
- [Table of contents block](plugins/toc.md) — `toc` block, `TocBuilder`, JS, CKEditor button.
- [Services & helper API](api/services.md) — the four services and how to reuse them.
