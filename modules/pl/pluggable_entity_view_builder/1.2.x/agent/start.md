<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pluggable Entity View Builder (pluggable_entity_view_builder) — agent index

Developer rendering framework (from Gizra, "PEVB"). Overrides a core entity type's **view builder**
so each **bundle** is rendered by a **per-bundle plugin class** — a method per view mode — returning
an ordinary render array, instead of preprocess functions + Twig templates. Version **1.2.7**,
core `^10.4 || ^11 || ^12`. GPL-2.0-or-later. No runtime dependencies (Paragraphs optional).

## Mechanism (verified from source)

1. **Opt-in per entity type.** Settings form at `/admin/config/system/pluggable-entity-view-builder`
   (route `pluggable_entity_view_builder.settings_form`) stores `enabled_entity_types` in
   `pluggable_entity_view_builder.settings`. All default to off.
2. **View-builder swap.** `pluggable_entity_view_builder_entity_type_alter()` calls
   `setViewBuilderClass()` on each enabled type, mapping to a PEVB subclass:
   `node`→`NodeViewBuilder`, `paragraph`→`ParagraphViewBuilder` (if Paragraphs installed),
   `comment`→`CommentViewBuilder`, `block_content`→`BlockContentViewBuilder`,
   `media`/`taxonomy_term`/`user`→generic `EntityViewBuilder`. (Cache rebuild required after change.)
3. **Dispatch.** Every subclass uses `EntityViewBuilderTrait` and overrides `buildMultiple()` →
   `doBuildMultiple()` → `doBuild()`. For each entity it builds `$plugin_id = "{entity_type}.{bundle}"`
   and asks the `EntityViewBuilderPluginManager` for it. **Match → plugin fully owns the output**
   (core field formatters, `entity_view_display`, and other hooks are deliberately NOT run).
   **No match, or `ViewModeNotFoundException` → falls back to `parent::buildMultiple()`** (core default).
   So adoption is incremental per bundle.
4. **Plugin type.** `EntityViewBuilder` plugin (`Plugin/EntityViewBuilder`, `@EntityViewBuilder`
   annotation or `#[EntityViewBuilder]` attribute). Base class `EntityViewBuilderPluginAbstract`.
   `build()` remaps view mode `default`→`full`, title-cases the view mode and strips `_ - space` to
   derive the method (`teaser`→`buildTeaser`); missing method throws `ViewModeNotFoundException`.

## What it provides

- **Plugin type:** `EntityViewBuilder` (see `agent/plugins/`).
- **`BuildFieldTrait`** (auto-used by the abstract base) — access-checked field/image/reference
  render helpers (see `agent/api/`).
- **`BuildBlockTrait`** — `buildBlock()`, `buildContentBlock()` for embedding blocks.
- **Cache-metadata contract** — managed `$this->cacheableMetadata`; a bundled **PHPStan rule**
  enforces the property on classes using the build-entities helpers.
- **Alter hook** `hook_pluggable_entity_view_builder_build_ENTITY_TYPE_alter(&$build, $entity)` —
  PEVB does not alter render arrays itself, this lets you invoke another module's alter (e.g.
  `paragraphs_edit`).
- **Submodules:** `pluggable_entity_view_builder_example` (Article node builder, Tailwind demo),
  `pluggable_entity_view_builder_paragraphs_example` (paragraphs-as-components).

## Config / access

- One config object: `pluggable_entity_view_builder.settings` (`enabled_entity_types` sequence).
- No routes take user input; the only route is the admin settings form. **No `*.permissions.yml`
  ships**, though the route requires `administer pluggable_entity_view_builder configuration` — an
  undeclared permission, so the form is effectively reachable only by user 1 / superuser. No Drush
  commands, no public-facing endpoints.

## Read next

- `agent/plugins/` — writing an `EntityViewBuilder` plugin, view-mode method naming, registration.
- `agent/api/` — `BuildFieldTrait` / `BuildBlockTrait` helper reference and the cache-metadata contract.
