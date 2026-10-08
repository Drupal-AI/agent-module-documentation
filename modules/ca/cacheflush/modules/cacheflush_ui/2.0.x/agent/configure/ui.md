# Routes, preset form, menu field & actions

## Routes (all require a cacheflush_ui permission)

| Route | Path | Purpose |
|---|---|---|
| `entity.cacheflush.collection` | `/admin/structure/cacheflush` | list presets (`cacheflush administer`) |
| `entity.cacheflush.add_form` | `/admin/structure/cacheflush/add` | add preset (`cacheflush create new`) |
| `entity.cacheflush.canonical` | `/cacheflush/{cacheflush}` | view (`_entity_access cacheflush.view`) |
| `entity.cacheflush.edit_form` | `/cacheflush/{cacheflush}/edit` | edit (`_entity_access cacheflush.update`) |
| `entity.cacheflush.delete_form` | `/cacheflush/{cacheflush}/delete` | delete (`_entity_access cacheflush.delete`) |
| `cacheflush.settings` | `/admin/structure/cacheflush/settings` | settings tab placeholder |
| `cacheflush.multiple_delete_confirm` | `/admin/structure/cacheflush/delete` | bulk delete confirm |

`hook_entity_type_alter()` wires these by setting the access handler, list builder, views_data
handler, add/edit/delete form classes, `field_ui_base_route`, and link templates on the `cacheflush`
entity.

## The preset form

`CacheflushEntityForm` (used for add + edit) renders:
- a `title` field, and
- `presetForm()`: a `vertical_tabs` element whose tabs come from **`hook_cacheflush_ui_tabs()`**
  (each tab: `name`, a `validation` callback, `weight`). cacheflush_ui declares
  `vertical_tabs_core` (Core cache tables), `vertical_tabs_functions` (Other core cache options),
  `vertical_tabs_custom` (Contrib cache tables), `vertical_tabs_often` (Other contrib cache options).
- Every option from `cacheflush.api::getOptionList()` becomes a checkbox in its option's `category`
  tab (contrib-only options in `vertical_tabs_often` show only if the providing module is enabled).

On save the form **sets status = TRUE** (published) and stores the ticked options' functions into the
preset's `data` (`$entity->setData($form_state->getStorage()['presets'])`), then redirects to the
collection. Tab validation callbacks (`cacheflush_ui_tab_validation`, and the advanced/cron ones)
move the selected options' functions into `storage['presets']`.

## The `menu` base field

`hook_entity_base_field_info()` adds a boolean **`menu`** field to the `cacheflush` entity. When a
preset is **published and `menu = 1`**, `hook_menu_links_discovered_alter()` adds a menu link
`cacheflush.presets.<id>` under `cacheflush.presets` that points at the clear-by-id route — i.e. the
preset shows up as a clickable item in the Cacheflush admin menu. Toggle it with the
**Add menu / Remove menu** actions or by setting the field.

```php
// Expose an existing preset in the admin menu.
$preset->set('menu', 1)->save();
```

## Actions & Views

Action plugins (in `config/install`, schema in `config/schema/cacheflush_ui.schema.yml`):
`cacheflush_publish_action`, `cacheflush_unpublish_action`, `cacheflush_delete_action`,
`cacheflush_menu_action` (add menu), `cacheflush_nomenu_action` (remove menu). A `CacheflushBulkForm`
Views field and the optional `views.view.cacheflush_content` view expose these as bulk operations.
`hook_views_query_alter()` removes the owner filter for users with `cacheflush view any`.
