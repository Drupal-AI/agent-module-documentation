<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Diba carousel (`diba_carousel`)

The module's only surface. `Drupal\diba_carousel\Plugin\Block\DibaCarousel` (annotation
`@Block(id = "diba_carousel", admin_label = "Diba carousel", category = "Content")`) extends
`BlockBase` and implements `ContainerFactoryPluginInterface`. Place it at
**Structure → Block layout** (or via `block_content`/`drush`), one instance per carousel. All
behaviour is driven by the block's own configuration — see
[configure/settings.md](../configure/settings.md) for the full key reference.

## What it does
Queries entities of one fieldable content-entity type, then renders each as a slide built from
that entity's fields. No dedicated slide entity/view exists — the block *is* the whole
mechanism.

## Render pipeline
`build()` returns a render array with `#theme => 'block__diba_carousel'`, plus `items`
(the slides), `id` (`Html::getUniqueId('diba_carousel')`) and the full `config`.

1. **`getQueriedEntities($config)`** — builds an entity query on `entity_selected` (default
   `node`):
   - Bundle filter: `content_types` (validated against existing bundles via `getValidBundles()`
     so a deleted bundle can't crash the query); empty = all bundles.
   - `skip_content_without_image` → `condition(image_field, NULL, 'IS NOT NULL')`.
   - `publishing_options` → one `condition($key, 1)` per checked key (`status`, `promote`,
     `sticky`, plus any `custom_pub` option ids for nodes).
   - Single ad-hoc filter: `condition(filter_by_field, filter_by_field_value, operator)` — see
     "Filter field" below.
   - Order: `order_direction` `RANDOM` adds tag `random_order`; otherwise `sort(order_field,
     ASC|DESC)`.
   - `range(0, limit)`.
   - **Access-checked**: `->accessCheck()->execute()` (note: called with no argument, i.e.
     default access checking enabled).
2. **`getItems($config)`** — loads the entities, and for each one that passes
   `$entity->access('view')` (a second, explicit access gate), resolves the current-language
   translation, then produces one or more slides according to `image_multi_strategy`:
   - `first` (default): one slide, image index 0.
   - `all`: one slide per image value in a multivalue image field.
   - `last`: one slide with the last image.
   - `rand`: one slide with a random image (`random_int`).
3. **`composeSlide($config, $entity, $image_num)`** — returns
   `['image','image_width','image_height','title','url','url_image','description']`:
   - `title`: `strip_tags($entity->{title_field}->value)`.
   - `description`: entity-reference field → comma-joined referenced-entity labels; otherwise the
     field `->value`, then optional truncation (`Unicode::truncate`, word-boundary), optional
     `See more` canonical link, UTF-8 normalisation.
   - `image`: file URI of the chosen image delta; falls back to the field's `default_image`;
     applies `image_style` (building the derivative on demand); reads width/height via
     `image.factory`.
   - `url` / `url_image`: see "Link options".

## Filter field (`filter_by_field*`)
One equality/comparison condition. `filter_by_field_operator` is an allowlisted select:
`=`, `<>`, `CONTAINS`, `>`, `>=`, `<`, `<=`, and date variants `date_g/ge/l/le` (the value is run
through `strtotime()` and the operator mapped to `>/>=/</<=`). The value is applied through the
entity query's parameterised `condition()`.

`filter_by_field_value` supports two tokens resolved at render time from the current request:
- `[query:arg]` → `$request->query->get('arg')` (e.g. `example.com?arg=23`).
- `[argument:N]` → the Nth path segment, 0-indexed (e.g. `/foo/bar` → `[argument:1]` = `bar`).

Relational/taxonomy fields expect the target entity id / tid as the value.

## Link options (`url`, `url_image`)
`getSlideUrl()` maps the selected option to a URL:
- `canonical` (or legacy `nid`) → `$entity->toUrl('canonical')`.
- `image_file` → absolute file URL of the original image (`file_url_generator`).
- any **link** field name → that field's first value URL.
- empty (`- None -`) → no link.

## Caching
- `getCacheContexts()`: parent + `user`, `languages:language_interface`, `url` (so per-user
  access, language and the request-token filters vary correctly).
- `getCacheTags()`: parent + `node_list`, `config:block.block.diba_carousel`.
- `blockSubmit()` also invalidates `config:block.block.diba_carousel` on save.

## Form structure
`blockForm()` builds a `diba_carousel_settings` fieldset with four groups: **Content selection
and ordering**, **Slide fields**, **Carousel styling**, and a nested **Class attributes**
details. The entity-type select uses an AJAX callback (`ajaxFormSettingsCallback`) that rebuilds
the whole settings wrapper so bundle/field selects repopulate for the chosen entity type.
`blockSubmit()` flattens the grouped values back into the flat config keys.

## Notes for integrators
- Selectable entity types = every `ContentEntityType` that has a `field_ui_base_route` (i.e.
  fieldable): nodes, users, comments, media, taxonomy terms, etc.
- Field option lists are filtered by field type: image field = `image`; title = `string`;
  description = `text`, `text_long`, `text_with_summary`, `string`, `string_long`,
  `entity_reference`; order field = `integer`, `created`, `changed`, `datetime`, `string`.
- There is no cardinality/paging beyond `limit`; the carousel shows exactly the queried set.
