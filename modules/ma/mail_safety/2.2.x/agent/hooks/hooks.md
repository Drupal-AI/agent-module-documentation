<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks Mail Safety invites

Declared in `mail_safety.api.php`. The documented purpose is handling **attachments** (which do
not survive a plain `serialize()` of the message), but you can use them for any mail transformation.
Two are true `hook_..._alter` hooks (invoked with `moduleHandler()->alter()` /
`invokeAllWith()`), so implement them accordingly.

| Hook | When | Signature / mechanism | Typical use |
|---|---|---|---|
| `hook_mail_safety_pre_insert(array $message)` | Before a caught mail is stored to the dashboard. Invoked via `\Drupal::moduleHandler()->alter('mail_safety_pre_insert', $message)`. | Implement as `mymodule_mail_safety_pre_insert_alter(&$message)` OR return-style per api.php; save attachment file contents out of `$message['params']` and stash file refs. | Persist attachments as managed files before serialization. |
| `hook_mail_safety_load(array $message)` | Each time a stored mail is loaded (`MailSafetyController::load()`). Invoked via `invokeAllWith('mail_safety_load')`; the returned array replaces `$mail['mail']`. | Return the (possibly modified) `$message`. | Flag/derive extra data, e.g. `$message['has_attachments'] = TRUE`. |
| `hook_mail_safety_pre_send(array $message)` | Before a caught mail is resent (from the dashboard). | Return the modified `$message`. | Re-attach files that were extracted on insert so the resent mail carries them again. |
| `hook_mail_safety_table_structure_alter(array $table_structure)` | While building the dashboard table. | Modify `$table_structure['header']` / `$table_structure['rows']`. | Add a column (e.g. an attachments/file-link column) to the dashboard listing. |

## Example (attachment persistence, condensed from api.php)

```php
function mymodule_mail_safety_pre_insert(array $message) {
  foreach ($message['params']['attachments'] ?? [] as $key => $attachment) {
    $file = \Drupal::service('file.repository')->writeData(
      $attachment['content'], 'public://' . time() . '-' . $attachment['filename']);
    $message['attachments'][$key] = $file;
  }
  unset($message['params']['attachments']);
  return $message;
}
```

No hooks are required to use the module — these only matter if you need attachment handling or a
custom dashboard column.
