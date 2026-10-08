<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The mail plugin and the send API

## Mail plugin `govuk_notify_mail`

`src/Plugin/Mail/GovUKNotifyMail.php`, `@Mail(id = "govuk_notify_mail", label = "Gov Notify mailer")`,
implements `MailInterface` + `ContainerFactoryPluginInterface`. Injected: the
`govuk_notify.notify_service`, core `email.validator`, `config.factory`,
`govuk_notify.logger_channel`.

### `format($message)`

- Decides email vs SMS by `isEmail($message['to'])` = `email.validator->isValid($to)`. If it is an
  email, the default template is `default_template_id`; otherwise `default_sms_template_id`.
- Fills `template_id` from that default when the message didn't set one; ensures `params` is an array.
- If `force_temporary_failure` is set, rewrites `to` to `temp-fail@simulator.notify` (Notify's
  test-key simulator address) and logs a notice. (`force_permanent_failure` rerouting is a `@todo`,
  not implemented here.)

### `mail($message)`

1. Fetches the template via `notifyService->getTemplate($message['template_id'])`.
2. If the caller didn't supply `params['subject']` but the message has a `subject` and the template's
   subject contains `((subject))` (checked by `checkReplacement()`), it copies `subject` into
   `params['subject']`. Same logic maps Drupal's `body` (via `current($message['body'])`) into
   `params['message']` when the template body contains `((message))`.
3. Validates: bails (logs a warning, returns FALSE) if `to`, `template_id` or `params` are missing;
   and if the **default** template is in use it additionally requires both `params['subject']` and
   `params['message']`.
4. Chooses `sendEmail` vs `sendSMS` again via `isEmail($to)` and calls
   `notifyService->{$sendMethod}($to, $template_id, $params)`, returning the API response (or FALSE).

So: a **specific** Notify template just needs `to`, `template_id`, and matching `params`
placeholders; the **default** template path lets Drupal supply `subject`/`message` and renders
through Notify's `((subject))`/`((message))` tokens.

## Sending programmatically

Through the mail manager (uses the plugin above):

```php
$params = ['subject' => 'Hello', 'message' => 'Body text'];      // default template
// or ['template_id' => '…', 'reference' => '…', 'name' => '…'] personalisation for a specific template
\Drupal::service('plugin.manager.mail')
  ->mail('govuk_notify', $key, $to, $langcode, $params);
```

Directly through the service (`Drupal\govuk_notify\NotifyService\GovUKNotifyService`):

```php
$notify = \Drupal::service('govuk_notify.notify_service');
$notify->sendEmail($to, $template_id, $params);   // wraps client->sendEmail
$notify->sendSms($to, $template_id, $params);      // wraps client->sendSms
```

Both wrap the `alphagov` client call in try/catch, log an `ApiException`/`Exception` warning to the
`govuk_notify` channel, and return FALSE on any failure (or if the client failed to construct).

## Service methods (`NotifyServiceInterface`)

- `sendEmail($to, $template_id, $params)` / `sendSms($to, $template_id, $params)` — see above.
- `getTemplate($template_id)` — returns template metadata. Caches under
  `cache.data` key `govuk_notify_template:{id}` (`Cache::PERMANENT`, tag `govuk_notify_template:{id}`)
  and memoizes per-request with `drupal_static`. The settings form invalidates that tag when the
  default template id changes.
- `checkReplacement($value, $replacement)` — `strpos($value, "(($replacement))") !== FALSE`; used to
  test whether a template component contains a placeholder before injecting a value.
- `listNotifications($filter = [])` — passes the filter straight to the client's `listNotifications`
  (used by the views backend submodule; note this method does not wrap the call in try/catch).

## Operating notes

- If the client can't be built (bad/empty API key), `notifyClient` is NULL; `sendEmail`/`sendSms`
  throw internally, are caught, logged, and return FALSE — mail silently fails, check the
  `govuk_notify` log channel.
- Recipient type is inferred purely from `email.validator`: a non-email `to` is always attempted as
  an SMS against `default_sms_template_id`.
- Test-key simulator addresses/failure modes come from Notify's integration-testing docs; the
  `force_temporary_failure` flag only rewrites the recipient for temporary-failure simulation.
