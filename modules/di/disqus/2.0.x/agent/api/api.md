<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disqus programmatic API

## `disqus_api()`

`disqus_api()` (in `disqus.module`) returns a configured `\DisqusAPI` instance from the
`disqus/disqus-php` library, using the stored user access token, or NULL if the library isn't
installed. Wrap calls in try/catch — the library throws on API errors.

```php
$disqus = disqus_api();
if ($disqus) {
  try {
    $thread = $disqus->threads->details([
      'forum' => \Drupal::config('disqus.settings')->get('disqus_domain'),
      'thread:ident' => "{$entity->getEntityTypeId()}/{$entity->id()}",
      'thread' => '1',
    ]);
  }
  catch (\Exception $e) { \Drupal::logger('disqus')->error($e->getMessage()); }
}
```

## Automatic thread sync (hooks)

- `hook_entity_update()` — when `advanced.api.disqus_api_update` is on (and a token is set),
  pushes the updated title/URL to the Disqus thread.
- `hook_entity_delete()` — when `advanced.api.disqus_api_delete` is `DISQUS_API_CLOSE` or
  `DISQUS_API_REMOVE`, closes or removes the Disqus thread.

These run only for entities that have a `disqus_comment` field.

## `DisqusCommentManager` (service `disqus.manager`)

`Drupal\disqus\DisqusCommentManagerInterface` — helpers for the comment field and SSO,
including the API-action constants `DISQUS_API_NO_ACTION`, `DISQUS_API_CLOSE`,
`DISQUS_API_REMOVE`. It builds the SSO user payload and the field's default identifier.

## SSO payload hook

```php
/**
 * Implements hook_disqus_user_data_alter().
 * Modify the data sent to Disqus for Single Sign-On.
 * $data keys: id, username, email, url, avatar.
 */
function mymodule_disqus_user_data_alter(array &$data) {
  $data['username'] = my_display_name();
}
```

SSO itself requires `advanced.disqus_publickey` + `advanced.disqus_secretkey` and
`advanced.sso.disqus_sso = TRUE`.

## New-comment notifications

The `disqus.new_comment_subscriber` event subscriber (on the `disqus.new_comment` route,
`/disqus/new-comment/{comment_id}`) sends author notification emails via `hook_mail()` when
`behavior.disqus_notify_newcomment` is enabled and a secret key is present.
