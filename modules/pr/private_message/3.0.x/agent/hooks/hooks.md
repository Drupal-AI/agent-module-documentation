<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Message — hooks

Documented in `private_message.api.php`. (The plugin-info alter
`hook_private_message_config_form_info_alter()` is covered in the plugins doc.)

## `hook_private_message_new_message(PrivateMessageInterface $privateMessage, PrivateMessageThreadInterface $thread): void`
Invoked (via `module_handler->invokeAll`) every time a message is added to a thread through
`PrivateMessageThreadManager::saveThread()`. Use it for counters, integrations, logging, or
notifications. This is exactly how the `private_message_notify` submodule sends email.
```php
function my_module_private_message_new_message(PrivateMessageInterface $pm, PrivateMessageThreadInterface $thread): void {
  \Drupal::logger('my_module')->info('PM @id posted to thread @tid', [
    '@id' => $pm->id(), '@tid' => $thread->id(),
  ]);
}
```

## `hook_private_message_view_alter(array &$build, EntityInterface $privateMessage, $viewMode)`
Alter a single private message's render array before output — e.g. add an author-specific class.
```php
function my_module_private_message_view_alter(array &$build, $privateMessage, $viewMode) {
  $build['wrapper']['#attributes']['class'][] = 'pm-author-' . $privateMessage->getOwnerId();
}
```

Both hooks receive the module's own entity interfaces
(`Drupal\private_message\Entity\PrivateMessageInterface` /
`PrivateMessageThreadInterface`).
