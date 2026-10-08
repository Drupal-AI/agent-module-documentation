<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Send User Notification — action plugin & mail

## Action plugin
- Class: `Drupal\usernotification\Plugin\Action\SendUserNotification`.
- Annotation: `@Action(id = "usernotification_action", label = "Send User Notification Message", type = "user")`.
- Config-entity instance shipped in `config/install/system.action.usernotification_action.yml` (id `usernotification_action`, label "Send notification message to user(s)", type `user`), which surfaces it in the Actions dropdown on `/admin/people`.
- Injected services: `config.factory`, `messenger`, `plugin.manager.mail`.

### `execute($account)`
For a passed user account it builds `$params` and calls the mail manager:
- `to` = `$account->getEmail()`
- langcode = `$account->getPreferredLangcode()`
- `from` and `reply-to` header = `system.site` `mail`
- headers: `Content-Type: text/html; charset=UTF-8;`, `Content-Transfer-Encoding: 8Bit`, `MIME-Version: 1.0`
- `\Drupal::service('plugin.manager.mail')->mail('usernotification', 'user_notification_email', $to, $langcode, $params)`

If no account is passed it shows an error message via Messenger instead of mailing.

### `access($object, $account, ...)`
Returns allowed only when the operator has `status` field `edit` access **and** `update` access on the target user entity — i.e. you can only mail users you may edit.

## Mail hook
`usernotification_mail($key, &$message, $params)` (in `usernotification.module`):
- Reads `usernotification.settings` (`subject`, `message`).
- `$message['subject']` = `PlainTextOutput::renderFromHtml(token replace of subject)` — plain text.
- `$message['body'][]` = token replace of the message body.
- Token replace uses `['langcode' => ..., 'callback' => 'user_mail_tokens', 'clear' => TRUE]` with `['user' => $params['account']]`.
- `$message['from']` = `$params['from']`; recipient headers merged from `$params['headers']`.

## No public services
The module registers no `*.services.yml`, exposes no callable service, no Drush commands, and no custom permissions. Programmatic use = execute the `usernotification_action` action plugin against user entities (e.g. via Views Bulk Operations or `\Drupal::service('plugin.manager.action')`).
