# Message Digest — invited hooks

From `message_digest.api.php`. Both fire while a user's digest is being assembled.

## `hook_message_digest_aggregate_alter(array &$context, UserInterface $account, MessageNotifierInterface $notifier)`
Adjust grouping/order of messages before rendering. `$context` keys:
- `data` — raw result row from the `message_digest` table.
- `entity_type` / `entity_id` — the grouping entity; set both to `''` to switch to a single global (un-grouped)
  digest.
- `messages` — ordered array of messages for the digest (re-order/sort as needed).

Example (aggregate everything into one weekly digest for opted-in users):
```php
function mymodule_message_digest_aggregate_alter(array &$context, $account, $notifier) {
  if ($account->aggregate_content->value && $notifier->getPluginId() === 'message_digest:weekly') {
    $context['gid'] = 0;
  }
}
```

## `hook_message_digest_view_mode_alter(array &$context, MessageNotifierInterface $notifier, UserInterface $account)`
Change render view modes or veto delivery. `$context` keys:
- `view_modes` — array of message view mode names used to render (add/remove to change output).
- `deliver` — bool, default TRUE; set FALSE to stop delivery (the digest is still marked sent).
- `entity_type` / `entity_id` — grouping entity (empty strings for global digests).
- `messages` — message IDs being assembled.

Example (don't email blocked users; drop the subject view mode):
```php
function mymodule_message_digest_view_mode_alter(array &$context, $notifier, $account) {
  unset($context['view_modes']['mail_subject']);
  if ($account->isBlocked()) {
    $context['deliver'] = FALSE;
  }
}
```
