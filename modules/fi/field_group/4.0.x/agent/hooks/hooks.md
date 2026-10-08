# Hooks — `field_group.api.php`

Alter grouping, rendering and settings without subclassing a formatter.

| Hook | When | Use for |
|---|---|---|
| `hook_field_group_pre_render(&$element, &$group, &$rendering_object)` | Before a group is rendered (view) | Attach JS/`drupalSettings`, set `#weight`, call the format plugin's `preRender`. |
| `hook_field_group_pre_render_alter(&$element, &$group, &$rendering_object)` | After pre_render build | Tweak `#theme_wrappers`, attributes, classes of one group. |
| `hook_field_group_build_pre_render_alter(&$element)` | On the whole entity view build | Move groups between regions, adjust `#fieldgroups`. |
| `hook_field_group_form_process(&$element, &$group, &$complete_form)` | Processing a group on a form | Add `#states`, alter the form element for the group. |
| `hook_field_group_form_process_alter(&$element, &$group, &$complete_form)` | After process | Same, as an alter pass. |
| `hook_field_group_form_process_build_alter(&$element, FormStateInterface $form_state, &$complete_form)` | After all groups processed | Cross-group form logic (e.g. conditional `#states` on a named group). |
| `hook_field_group_delete_field_group($group)` | A group is deleted | Extra cleanup for state tied to that group. |
| `hook_field_group_formatter_info_alter(&$info)` | Plugin info build | Add extra annotation keys / adjust available formats. |

```php
function mymodule_field_group_pre_render_alter(array &$element, &$group, &$rendering_object) {
  if ($group->format_type === 'html_element') {
    $element['#attributes']['class'][] = 'my-decorated-group';
  }
}
```

`$group` is a value object exposing `format_type`, `format_settings`, `label`, `mode`,
`context`, `children`, `parent_name`, `region`, `weight`.
