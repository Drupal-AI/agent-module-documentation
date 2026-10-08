# The viewsreference field

`ViewsReferenceItem` (`src/Plugin/Field/FieldType/ViewsReferenceItem.php`) extends core
`EntityReferenceItem`. `target_type` is always `view`.

## Plugins registered
| Kind | id | Notes |
|---|---|---|
| FieldType | `viewsreference` | default_widget `viewsreference_autocomplete`, default_formatter `viewsreference_formatter` |
| FieldWidget | `viewsreference_autocomplete` | extends entity_reference_autocomplete |
| FieldFormatter | `viewsreference_formatter` | renders the view display inline |
| FieldFormatter | `viewsreference_lazy_formatter` | renders via a lazy-builder placeholder (better cache) |

## Stored properties (beyond the referenced view)
- `target_id` — the View config entity id.
- `display_id` — chosen display (e.g. `block_1`, `page_1`).
- `data` — serialized blob of per-instance ViewsReferenceSetting values (argument, title, pager…).

## Field settings (schema `field.field_settings.viewsreference`)
- `plugin_types` — allowed View display plugin ids editors may pick (default `['block']`).
- `preselect_views` — optional allow-list of View ids.
- `enabled_settings` — which ViewsReferenceSetting controls appear on the widget.

## Reading a value in code
```php
$item = $entity->get('field_my_view')->first();
$view = \Drupal\views\Views::getView($item->target_id);
$view->setDisplay($item->display_id);
// per-embed settings live in unserialize($item->data)
$build = $view->buildRenderable($item->display_id);
```
The formatters apply enabled ViewsReferenceSetting plugins (arguments, title, pager, …) to the
`ViewExecutable` before rendering; `hook_views_pre_view` / `hook_views_pre_render` in
`viewsreference.module` wire the token-based arguments and title overrides.
