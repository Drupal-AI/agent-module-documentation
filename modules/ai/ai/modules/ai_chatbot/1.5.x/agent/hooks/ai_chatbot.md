# hooks — alter Deep Chat rendering (`ai_chatbot.api.php`)

Three procedural hooks let you customise the chatbot without overriding the block or
templates. They fire while `DeepChatFormBlock` builds its `#deepchat_settings`.

## `hook_deepchat_settings(array &$deepchat_settings)`

Alter the array of attributes passed to the `<deep-chat>` element (invoked via
`moduleHandler->invokeAll('deepchat_settings', [&$deepchat])`). Use it to tweak the inline
`style`, colours, layout, `avatars`, `htmlClassUtilities`, etc. Reference:
https://deepchat.dev/docs/styles.

```php
function mymodule_deepchat_settings(array &$deepchat_settings) {
  $deepchat_settings['style'] .= 'background-color: #000;';
}
```

## `hook_deepchat_buttons_alter(array &$buttons)`

Add/alter the action buttons rendered under each assistant message (the copy icon is one
such button). Each entry: `svg`, `alt`, `title`, `weight`, optional `url` / `class`.

```php
function mymodule_deepchat_buttons_alter(array &$buttons) {
  $buttons[] = [
    'svg' => '/path/to/icon.svg',
    'alt' => 'Alt text',
    'title' => 'Title text',
    'weight' => 0,
    'url' => \Drupal\Core\Url::fromRoute('node.add', ['node_type' => 'page']),
  ];
}
```

## `hook_deepchat_prepend_message($message, $type, $assistant_id, $thread_id)`

Return a string to prepend to an outgoing assistant message. Params: `$message` (text),
`$type` (`text`/`html`), `$assistant_id`, `$thread_id`.

## Alter: `hook_ai_chatbot_style_modules(array &$module_list)`

Not in `api.php` but invoked in the block: add your module's machine name so its
`deepchat_styles/*.yml` presets are offered in the block's Style select (themes are scanned
automatically). See [theming/ai_chatbot.md](../theming/ai_chatbot.md).

> These are the only extension points ai_chatbot defines. Deeper request/response
> customisation belongs to the underlying `ai` core (events) and `ai_assistant_api`.
