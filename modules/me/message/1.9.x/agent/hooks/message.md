<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (message.api.php)

Implement in `your_module.module` unless noted.

| Hook | When / purpose |
|---|---|
| `hook_message_view(Message $message, $view_mode, $langcode)` | Add elements to `$message->content` before rendering (like `hook_entity_view()`). |
| `hook_message_view_alter(array &$build)` | Alter the assembled render array after content is built; add `#post_render`, tweak weights. |
| `hook_default_message_template()` | Return an array of default `message_template` entities keyed by machine name (seed templates from code/install). |
| `hook_default_message_template_alter(array &$defaults)` | Alter those default templates before they are created. |
| `hook_form_message_template_form_alter(array &$form, array &$form_state)` | Alter the message template add/edit form (or the bundle-specific `hook_form_message_template_edit_BUNDLE_form_alter()`). |
| `hook_default_message_category()` / `..._alter()` | Provide/alter default message *category* entities (only if a category module is present). |
| `hook_message_purge_alter()` | Alter discovered `message_purge` plugin definitions (see `plugins/purge.md`). |

Example — seed a default template from code:

```php
function my_module_default_message_template() {
  $defaults = [];
  $defaults['welcome'] = \Drupal::entityTypeManager()
    ->getStorage('message_template')
    ->create([
      'template' => 'welcome',
      'label' => 'Welcome',
      'text' => [['value' => 'Welcome, [message:author:name]!', 'format' => 'basic_html']],
    ]);
  return $defaults;
}
```

Messages are ordinary content entities, so the standard `hook_ENTITY_TYPE_*` hooks
(`hook_message_presave`, `hook_message_insert`, `hook_entity_view` for `message`, …) also fire.
