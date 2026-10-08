<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pluggable Entity View Builder (PEVB) overrides a core entity type's view builder so each bundle's output is produced by a per-bundle PHP plugin class — one `build{ViewMode}` method per view mode — instead of preprocess functions and Twig templates.

---

PEVB is a developer rendering framework from Gizra. You turn it on per entity type at `/admin/config/system/pluggable-entity-view-builder` (checkboxes for `block_content`, `comment`, `media`, `node`, `taxonomy_term`, `user`, and `paragraph` when Paragraphs is installed); `hook_entity_type_alter` then swaps that type's view builder class for a PEVB subclass (`NodeViewBuilder`, `ParagraphViewBuilder`, `CommentViewBuilder`, `BlockContentViewBuilder`, or the generic `EntityViewBuilder`). The subclass short-circuits core's `buildMultiple()`: for each entity it looks up a plugin whose id is `"{entity_type}.{bundle}"` (e.g. `node.article`) in the `EntityViewBuilder` plugin type (`Plugin/EntityViewBuilder`, annotation or `#[EntityViewBuilder]` attribute). If a plugin exists it takes over completely — no field formatters, no `entity_view_display`, no other theme hooks run, so the plugin is the single source of the render array. If no plugin matches the bundle, or the plugin has no method for the requested view mode, PEVB falls back to core's default rendering, so adoption can be incremental per bundle. You write a class extending `EntityViewBuilderPluginAbstract` and add a method per view mode: `default` is remapped to `full`, and the view-mode name is title-cased with separators stripped to derive the method (`teaser` -> `buildTeaser`, `search_result` -> `buildSearchResult`). Each method receives `($build, $entity)` and returns a render array. The abstract base pulls in `BuildFieldTrait`, whose helpers read field values (`getTextFieldValue`, `getLinkFieldValue`, `getDateFieldValue`, `getTextListFieldLabelValue`, `getBooleanFieldValue`), build images (`buildImage`, `buildImageStyle`, `buildResponsiveImage`, `getMediaImageAndAlt`), and render referenced/child entities (`buildEntities`, `buildReferencedEntities`, `buildReferencedEntitiesWithViewModes`) — the reference and entity helpers run `access('view')` checks and add each entity's cache dependency. `BuildBlockTrait` adds `buildBlock`/`buildContentBlock` for embedding blocks. Cache metadata is the plugin's responsibility: the base `build()` seeds `$this->cacheableMetadata` from the incoming `$build` and re-applies it at the end, and the field helpers add dependencies to it implicitly — but anything you load yourself (via `entityTypeManager`, entity queries) must be added to `$this->cacheableMetadata` manually or the output caches wrongly. A ships-with PHPStan rule enforces that classes using the build-entities helpers declare the `$cacheableMetadata` property. The Paragraphs example shows the intended headline use: paragraphs become composable, individually themed page-building components, a code-first alternative to Layout Builder. Because PEVB replaces the entire field-rendering pipeline for overridden bundles, it is a deliberate team-wide choice — a codebase split between templates and view builders is harder to work in than either alone.

---

- Render a node bundle from a PHP class instead of a Twig template.
- Build an article's teaser and full view mode in one typed, testable class.
- Adopt component/atomic-design rendering in a headless or design-system build.
- Theme paragraphs as composable page sections (a Layout Builder alternative).
- Replace scattered preprocess hooks with constructor-injected render logic.
- Give a bundle's display logic a single, IDE-navigable home.
- Read field values safely with `getTextFieldValue()` / `getLinkFieldValue()`.
- Build a styled or responsive image from a media/image field in code.
- Render referenced entities with automatic view-access checks.
- Render a paragraph reference field as a set of cards.
- Embed a block or a custom block-content entity inside an entity's output.
- Add per-plugin cache tags/contexts through `$this->cacheableMetadata`.
- Roll out custom rendering one bundle at a time (unmatched bundles fall back to core).
- Enable overriding only for chosen entity types via the settings form.
- Override `media` rendering to control WYSIWYG-embedded media markup.
- Unit/kernel-test a component by asserting on its returned render array.
- Vary output per view mode by adding a `build{ViewMode}` method.
- Invoke another module's build alter manually via `hook_..._build_ENTITY_TYPE_alter`.
- Integrate `paragraphs_edit` contextual quick-links on rendered paragraphs.
- Warn site builders that Manage Display changes are bypassed for overridden bundles.
- Enforce the cache-metadata contract in CI with the bundled PHPStan rule.
- Build a hero header, tag list, and body region as separate reusable methods/traits.
