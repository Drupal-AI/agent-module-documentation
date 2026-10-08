<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper traits and the cache-metadata contract

`EntityViewBuilderPluginAbstract` uses `BuildFieldTrait` automatically. `BuildBlockTrait` is opt-in.
All method names below are `protected`.

## BuildFieldTrait — reading field values

- `getTextFieldValue($entity, $field_name): string` — first value via `FieldItemList::getString()`
  (plain string). `getTextFieldValues()` returns all values as `string[]`.
- `getTextListFieldLabelValue($entity, $field_name): string` — allowed-value **labels** for a
  list field, comma-joined; falls back to the raw stored value if the key is no longer allowed.
- `getBooleanFieldValue($entity, $field_name): bool`.
- `getDateFieldValue($entity, $field_name, $date_format): string` (single date field only, not
  date_range). `getDateFieldValues()` for multi-value.
- `getLinkFieldValue($entity, $field_name): ?array` — `['url' => Url, 'title' => string]`.
  **Runs `Url::access()`** and returns `NULL` for links the current user cannot reach or `<nolink>`;
  adds the access result to cache metadata. `getLinkFieldValues()` for multi-value.

> These string getters return the **stored** value. They do not run per-field access
> (`hook_entity_field_access`) and do not pass through a text format — output them inside a normal
> render array (which auto-escapes) or a field formatter, and see `agent`-level security notes about
> field-level access control.

## BuildFieldTrait — images and media

- `getImageAndAlt($entity, $field_name = 'field_image', $image_style = ''): ?array` — `uri`, `url`,
  `alt`, `title` from an image field. (Loads the referenced file with **access check disabled** —
  normal for a file attached to an already-view-checked entity.)
- `getMediaImageAndAlt($entity, $field_name, $image_style = ''): array` — resolves a Media reference
  to its `field_media_image`; access-checks the Media entity and adds its cache dependency.
- `buildImage()` / `buildImageStyle($entity, $image_style, ...)` — render arrays (`#theme => image` /
  `image_style`).
- `buildMediaResponsiveImage()` / `buildResponsiveImage($entity, $field_name, $responsive_image_style_id)`
  — requires core Responsive Image; applies entity + image cache dependencies.

## BuildFieldTrait — referenced / child entities

- `getReferencedEntityFromField($entity, $field_name, $access_check = TRUE): ?EntityInterface` and
  `getReferencedEntitiesFromField(...)` — resolve a reference field. **Each referenced entity is
  `access('view')`-checked** (skipped if `$access_check` is FALSE) and its **access result is added to
  `$this->cacheableMetadata`**; results are translated to the parent's language via
  `entityRepository->getTranslationFromContext()`.
- `buildEntities($entities, $view_mode = 'full', $langcode = NULL): array[]` — for each entity: adds
  its cache dependency, runs `access('view')`, and (if allowed) renders it through its own view
  builder. Cache metadata of **excluded** (e.g. unpublished) entities is still propagated, so
  publishing one correctly invalidates the parent.
- `buildReferencedEntities($reference_field, $view_mode, $langcode)` — convenience over a reference
  field.
- `buildEntitiesWithViewModes($entities, $view_modes, $langcode)` /
  `buildReferencedEntitiesWithViewModes(...)` — per-bundle view-mode map (`['bundle' => 'view_mode']`,
  default `full`).

## BuildBlockTrait — embedding blocks

Opt-in (`use BuildBlockTrait;` and inject `plugin.manager.block` as `$this->blockManager`).

- `buildBlock($block_id, $config = []): array` — instantiate a block plugin; **honours the block's
  `access()`** (returns `[]` if forbidden) and returns `->build()`.
- `buildContentBlock($uuid, $title = [], $langcode = NULL): array` — load a `block_content` by UUID
  and render it through its view builder, wrapped for contextual links.

## Cache-metadata contract

- `EntityViewBuilderPluginAbstract::build()` seeds `$this->cacheableMetadata` from the incoming
  `$build`, runs your `build{ViewMode}()`, then **merges** the accumulated metadata back onto the
  returned array (merge + `applyTo`, so `#cache` entries you set directly are not lost).
- The `BuildFieldTrait` helpers add dependencies to `$this->cacheableMetadata` for you.
- **Anything you load yourself** (via `entityTypeManager`, entity queries, `loadMultiple`, etc.) is
  **not** tracked automatically — call `$this->cacheableMetadata->addCacheableDependency($entity)` or
  `->addCacheTags(['node_list'])` yourself, or the output caches stale. Entity queries carry no cache
  metadata at all.
- A bundled **PHPStan rule** (`BuildFieldTraitCacheableMetadataRule`, auto-registered via
  phpstan/extension-installer) fails the build if a class calling `buildEntities()` /
  `buildReferencedEntities()` / `*WithViewModes()` does not declare a
  `protected CacheableMetadata $cacheableMetadata` property.

## Alter hook

`hook_pluggable_entity_view_builder_build_ENTITY_TYPE_alter(array &$build, EntityInterface $entity)`
fires in `doBuildMultiple()` before the plugin runs. PEVB does not alter render arrays itself; use
this to manually invoke another module's view-alter (the module ships an implementation that wires up
`paragraphs_edit` contextual links). Note PEVB has renamed view mode `default` to `full`, so map it
back when loading the `entity_view_display`.
