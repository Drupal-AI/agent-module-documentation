<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sending API: manager, renderer, hook_mail, tokens, logging

The module ships **no route or UI that sends mail**. Sending is a developer API: your code obtains
a prepared message from the manager and calls `mailMessage()`.

## Services (`email_messages.services.yml`)

- `email_messages.manager` → `Drupal\email_messages\EmailMessageManager`, args
  `@entity_type.manager`, `@language_manager`, `@plugin.manager.mail`, `@email_messages.renderer`.
- `email_messages.renderer` → `Drupal\email_messages\EmailMessageRenderer`, args
  `@theme.manager`, `@theme.initialization`, `@theme_handler`, `@renderer`.

## `EmailMessageManager::getMessage($id, $tokens = [], $langcode = NULL)`

- Sets the config override language to `$langcode` (defaults to current language) so the loaded
  `email_message` config entity comes back translated, then restores the previous override language.
- Loads the entity via `entity_type.manager` storage `email_message`; returns `NULL` if missing,
  or the entity unchanged if `$tokens` is empty.
- Normalises each token value: strings pass through; a render array (has `#type`/`#theme`) is
  rendered with the renderer service; anything else becomes `''`.
- Replaces placeholders in the body and subject with `Drupal\Component\Render\FormattableMarkup`
  (`$message['value']` and `subject`), then `set()`s them back on the entity. Because it uses
  `FormattableMarkup` with `@variable`-style placeholders, substituted values are escaped. Returns
  the (in-memory, not saved) entity.

## `EmailMessageManager::mailMessage($message, $to, $params = [], $module = NULL, $key = NULL, $reply = NULL, $send = TRUE)`

- Defaults `$module` to `email_messages` and `$key` to `notification`.
- If not supplied, sets `$params['subject']` from `$message->getSubject()` and `$params['message']`
  to a `processed_text` render element built from the body value/format.
- Renders `$params['message']` through `EmailMessageRenderer::render()` (front-end theme), then
  calls `mail_manager->mail($module, $key, $to, $message->language()->getId(), $params, $reply, $send)`.
- If `$message->logsMessage()` is TRUE, creates and saves an `email_message_log` from
  `$params['log_message_values']` (optional caller-supplied fields) merged with `rendered_message`
  (value+format), `email` = `$to`, `message` = the message id, `language`. Returns the mail result.

## `email_messages_mail($key, &$message, $params)` (`email_messages.module`)

Sets `Content-Type: text/html`. For key `notification`: `from` = `system.site` mail, `subject` =
`$params['subject']`, appends `$params['message']` to the body.

## `EmailMessageRenderer::render(array $build)`

Temporarily swaps the active theme to the default front-end theme
(`theme_handler->getDefault()` via `theme.initialization`), renders `$build` inside a fresh
`RenderContext` with `renderer->executeInRenderContext()`, then restores the original theme. This
ensures emails use the site theme, not the admin theme, and that render metadata does not leak.

## Typical call

```php
$mgr = \Drupal::service('email_messages.manager');
$msg = $mgr->getMessage('welcome', ['@name' => $account->getDisplayName()], $langcode);
$mgr->mailMessage($msg, $account->getEmail());
```

`hook_views_data_alter()` also swaps the log view's `uid` filter to `user_name` and its `message`
filter to the `email_message` Views filter plugin (see entities/message_log.md).
