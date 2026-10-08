# Display Suite hooks

Declared in `ds.api.php`. Implement in `my_module.module`.

| Hook | Purpose |
|---|---|
| `hook_ds_fields_info_alter(&$plugins)` | Modify DsField plugin definitions after discovery. |
| `hook_ds_field_templates_info_alter(&$plugins)` | Modify DsFieldTemplate plugin definitions. |
| `hook_ds_field_format_summary($field)` | Return the summary string shown on the Field UI for a custom field with settings. |
| `hook_ds_layout_settings_alter($record, $form_state)` | Alter layout settings just before they are saved. |
| `hook_ds_pre_render_alter(&$layout_render_array, $context, &$vars)` | Alter the layout render array / add classes before render (`$context`: entity, entity_type, bundle, view_mode). |
| `hook_ds_layout_region_alter($context, &$region_info)` | Add/alter region options shown on the field-placement UI. |
| `hook_ds_label_options_alter(&$field_label_options)` | Add field label placement options. |
| `hook_ds_views_view_mode_alter(&$view_mode, $context)` | Change the view mode used by the DS Views entity row plugin. |
| `hook_ds_views_row_render_entity($entity, $view_mode)` | Fully override how a Views row renders an entity (return render array). |
| `hook_ds_views_row_render_entity_alter(&$build, $context)` | Alter the built entity from the Views row plugin. |
| `hook_ds_classes_alter(&$classes, $name)` | Provide additional region/layout CSS classes (e.g. `$name == 'ds_classes_regions'`). |
| `hook_ds_field_operations_alter(&$operations, $field)` | Alter row operations on the dynamic custom-field overview page. |
| `hook_ds_onclick_url_alter(Url $url)` | Alter the on-click URL used in DS admin UI. |
