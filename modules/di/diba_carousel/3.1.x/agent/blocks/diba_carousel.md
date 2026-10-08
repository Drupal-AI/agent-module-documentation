<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Diba carousel (`diba_carousel`)

The module's only surface. `Drupal\diba_carousel\Plugin\Block\DibaCarousel`
(`@Block(id = "diba_carousel", admin_label = "Diba carousel", category = "Content")`) extends
`BlockBase`, implements `ContainerFactoryPluginInterface` and `ContextAwarePluginInterface`, and
declares a `ContextDefinition("entity")` (`required = FALSE`) so it can pick up the current entity
in Layout Builder / paragraph layouts. Place it at **Structure → Block layout** (or via `drush`),
one instance per carousel. All behaviour is driven by the block's own configuration — see
[configure/settings.md](../configure/settings.md) for the full key reference.

The block itself is thin: `create()` injects the four services and `build()` delegates the query
and slide building. See [api/services.md](../api/services.md) for the service internals.

## Render pipeline
`build()` returns a render array (themed by `block__diba_carousel`) whose `content` holds:
`items` (the slides, from `CarouselSlideBuilder::getItems()`), `id`
(`Html::getUniqueId('diba_carousel')`, wrapped as `['#markup' => ...]`) and the full `config`.
No `#theme` is set in `build()` — `BlockViewBuilder` applies the `block` base hook around it.

1. **`getLayoutBuilderContextEntity()`** (private) — returns the context value for the first of
   `entity` / `node` / `paragraph` context keys that resolves to something with
   `getEntityTypeId()`, else `NULL`.
2. **`CarouselQueryBuilder::getQueriedEntities($config, $context_entity)`** — builds an entity
   query:
   - Entity type = `entity_selected` if set; else the context entity's type; else `node`.
   - Bundle filter: `content_types` validated against existing bundles via
     `CarouselOptionsProvider::getValidBundles()` (a deleted bundle can't crash the query);
     empty = all bundles.
   - `skip_content_without_image` → `condition(image_field, NULL, 'IS NOT NULL')`.
   - `publishing_options` → one `condition($key, 1)` per checked key (`status`, `promote`,
     `sticky`, plus any `custom_pub` option ids for nodes).
   - Single ad-hoc filter: `condition(filter_by_field, filter_by_field_value, operator)` — see
     "Filter field" below.
   - Order: `order_direction` `RANDOM` adds tag `random_order`
     (`diba_carousel_query_random_order_alter()` → `orderRandom()`); otherwise
     `sort(order_field, ASC|DESC)`.
   - `range(0, limit)`.
   - Executed with `->accessCheck(FALSE)->execute()` (grants-only query access is disabled on
     purpose so that bypass permissions are honoured; per-entity `view` access is enforced in the
     next step — see the inline comment in `CarouselQueryBuilder`).
3. **`CarouselSlideBuilder::getItems($config, $entities)`** — for each entity that passes
   `$entity->access('view')` (the real access gate), resolves the current-language translation,
   then produces one or more slides per `image_multi_strategy`:
   - `first` (default): one slide, image index 0.
   - `all`: one slide per image value in a multivalue image field.
   - `last`: one slide with the last image.
   - `rand`: one slide with a random image (`random_int`).
4. **`CarouselSlideBuilder::composeSlide($config, $entity, $image_num)`** — returns
   `['image','image_render','image_width','image_height','title','url','url_image','description']`
   (see [api/services.md](../api/services.md) for the field-resolution and description-sanitising
   detail).

## Filter field (`filter_by_field*`)
One equality/comparison condition. `filter_by_field_operator` is an allowlisted select:
`=`, `<>`, `CONTAINS`, `>`, `>=`, `<`, `<=`, and date variants `date_g/ge/l/le` (the value is run
through `strtotime()`/`date('Y-m-d H:i:s')` and the operator mapped to `>/>=/</<=` via an exact
lookup). The value is applied through the entity query's parameterised `condition()`.

`filter_by_field_value` supports two tokens resolved at render time from the current request:
- `[query:arg]` → `$request->query->get('arg')`.
- `[argument:N]` → the Nth path segment, 0-indexed (`/foo/bar` → `[argument:1]` = `bar`).

Relational/taxonomy fields expect the target entity id / tid as the value.

## Link options (`url`, `url_image`)
`CarouselSlideBuilder::getSlideUrl()` maps the selected option to a URL:
- `canonical` (or legacy `nid`) → `$entity->toUrl('canonical')` (only if the entity has a
  canonical link template; paragraphs, which have none, get no link).
- `image_file` → absolute file URL of the original image (`file_url_generator`).
- any **link** field name → that field's first value URL.
- empty (`- None -`) → no link.

## Form
`blockForm()` tracks any in-progress AJAX entity-type selection (via `NestedArray::getValue()` on
`settings.diba_carousel_settings.content_selection.entity_selected`), defaults the *form-building*
entity type to `node` when the stored value is empty (an empty stored value means "use context"),
then calls `CarouselFormBuilder::buildSettingsForm()`. The entity-type select gets an AJAX
callback (`ajaxFormSettingsCallback`) that rebuilds the whole `diba_carousel_settings` wrapper so
bundle/field selects repopulate for the chosen type. `blockSubmit()` walks
`CarouselFormBuilder::getConfigFieldMap()` (the single source of truth for each key's nested form
path) to flatten grouped values back into flat config keys, then invalidates
`config:block.block.diba_carousel`.

## Caching
- `getCacheContexts()`: parent + `user`, `languages:language_interface`, `url` (so per-user
  access, language and the request-token filters vary correctly).
- `getCacheTags()`: parent + `node_list`, `config:block.block.diba_carousel`.

## Notes for integrators
- Selectable entity types = every `ContentEntityType` that has a `field_ui_base_route` (i.e.
  fieldable): nodes, users, comments, media, taxonomy terms, etc.
- Field option lists are filtered by field type: image field = `image` fields plus
  media-image entity-reference fields; title = `string`; description = `text`, `text_long`,
  `text_with_summary`, `string`, `string_long`, `entity_reference`; order field = `integer`,
  `created`, `changed`, `datetime`, `string`.
- There is no cardinality/paging beyond `limit`; the carousel shows exactly the queried set.
