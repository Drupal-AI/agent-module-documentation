<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-view reorder: form, storage, query injection, multilingual

## Enabling a display
`entity_weight_views_form_entity_weight_settings_form_alter()` adds a *Views Reorder* fieldset to the
parent settings form (`/admin/config/entity-weight`), listing every enabled view's non-default
displays as `view_id:display_id` checkboxes. Its submit handler
(`entity_weight_views_settings_form_submit`) saves the chosen keys into
`entity_weight_views.settings:enabled_views`. No view config is mutated — the order is applied at
runtime.

## Storage — `entity_weight_views_order`
Table from `entity_weight_views.install` `hook_schema`: `view_id`, `display_id`, `entity_id` (unsigned
int), `weight` (int), `langcode` (varchar 12). Primary key (view_id, display_id, entity_id, langcode);
indexes `view_display` and `weight`. Update hook 10003 promotes prior per-language rows: the site
default language becomes the shared `und` order, other stray rows are dropped.

## Reorder form — `ViewOrderForm` (`src/Form/ViewOrderForm.php`)
`FormBase`, id `entity_weight_views_order_form`, route `entity_weight_views.order`, perm
`assign entity weight`. Injects `entity_type.manager`, `language_manager`, `database`.

`buildForm()`:
1. Guards missing params, and returns an error when `view_id:display_id` is not in `enabled_views`.
2. Loads the view (`Views::getView`), sets the display, captures the display's `items_per_page`, then
   forces `setItemsPerPage(0)` + `setCurrentPage(0)` and `execute()` — so **all** matching rows load
   (pager overridden), letting any item be dragged into the top positions.
3. Resolves the base entity type, the current **content** language, and whether this language is
   customized (`isCustomized()` checks `entity_weight_views.settings:customized`). `edit_langcode` =
   the language when customized, otherwise the shared `und`.
4. Extracts entity ids from `$view->result` (`$row->_entity->id()`, or `$row->nid`), loads them,
   switches to the content-language translation when present, reads saved weights via
   `loadViewWeights()` (a `db->select` on the custom table filtered by view/display/edit-langcode; a
   freshly customized language starts from the shared rows), and `uasort()`s by weight.
5. Builds a `#tabledrag` table (group `view-weight-order-weight`). Row label is escaped
   (`htmlspecialchars`); each row has a `#type => weight` element and operations (**View** only when
   canonical link + `access('view')`, **Edit** only when edit-form link + `access('update')`).
6. When the display has a limit and there are more rows than the limit, adds a *Display status* column
   ("Visible" / "Below display limit") and attaches `entity_weight_views/cutoff`
   (drupalSettings `entityWeightViews.displayLimit`) so JS keeps the status in sync while dragging.
7. On multilingual sites adds a per-language control: *Customize the order for <lang>* / *Reset <lang>
   to the shared order*, plus a "Back to view" link for page displays.

## Save & language handlers
- `submitForm()` writes to `edit_langcode`: it deletes existing rows for
  (view_id, display_id, langcode) and re-inserts one row per submitted entity via the DB API
  (`->condition()` / `->fields()`/`->values()` — parameterized). Then `invalidateOrder()` and a
  redirect back to the same page (`reloadForm()` strips `?destination`).
- `customizeForLanguage()` adds `view_id:display_id:langcode` to `customized` config so this language
  gets its own order.
- `resetToShared()` removes that key from `customized` and deletes the language's own rows so it falls
  back to the shared `und` order.
- `invalidateOrder()` invalidates cache tags `entity_weight_views_order:<view>:<display>`,
  `config:views.view.<view>`, and `<entity_type>_list`.

## Applying the order — `hook_views_query_alter`
For an enabled `view:display`, `entity_weight_views_views_query_alter()` adds two standard joins to
`entity_weight_views_order` (one for the current content language, one for shared `und`, matched on
view_id/display_id/langcode via join `extra`), then **prepends** an orderby
`COALESCE(<lang>.weight, <shared>.weight, 0) ASC` before the view's existing orderbys — so the custom
order takes precedence, with the language order winning over the shared order, and 0 for unordered
items. `hook_views_post_render()` adds the `entity_weight_views_reorder` contextual link and the
`languages:content` cache context + the order cache tag.

## Optional visible button — `ReorderLink`
Views area plugin id `entity_weight_reorder_link` (`hook_views_data` in
`entity_weight_views.views.inc`). `render()` returns nothing unless the current user has
`assign entity weight`, then renders a button linking to `entity_weight_views.order` for the current
view/display. Add it to a view's header/footer/empty region.
