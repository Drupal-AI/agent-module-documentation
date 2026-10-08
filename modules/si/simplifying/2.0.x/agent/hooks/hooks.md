# Hooks Simplifying invites (`simplifying.api.php`)

Implement these in `your_module.module` to extend what Simplifying hides.

- `hook_simplifying_get_fields_alter(array &$fields, string $type)`
  Alter the list of entity-form field keys Simplifying offers/hides for a given entity `$type`
  (`nodes`, `users`, `comments`, `taxonomy`, `blocks`). Add `'machine_key' => t('Label')` to make a
  new field hideable, or `unset()` one.

- `hook_simplifying_hide_field_alter(array &$form, string &$field)`
  Called as each field is about to be hidden. Set `$field = ''` to cancel hiding it, or hide a
  different element yourself via `$form['my_field']['#access'] = FALSE`.

- `hook_simplifying_hide_toolbar_tabs_alter(array &$tabs)`
  Append your own toolbar tab keys to the hidden-tabs list (`$tabs[] = 'my_tab';`).

Simplifying itself implements many core hooks to do its work (not for you to implement): the five
`hook_form_*_form_alter` (node/user/comment/taxonomy_term/block_content), `hook_toolbar`,
`hook_menu_local_tasks_alter`, `hook_contextual_links_view_alter`, `hook_entity_operation_alter`,
`hook_entity_insert`/`hook_entity_delete` (unread tracking), `hook_page_attachments_alter`, and
`hook_module_implements_alter` (forces its form alters to run last).
