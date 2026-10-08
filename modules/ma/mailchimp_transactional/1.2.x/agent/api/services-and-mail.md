# Services, mail plugins, and the send path

## Services (`mailchimp_transactional.services.yml`)

| Service id | Class | Role |
|---|---|---|
| `mailchimp_transactional` | `Api` (`ApiInterface`) | Low-level API client wrapping the `mailchimp/transactional` PHP library: `send()`, `sendTemplate()`, `getMessages()`, `getTemplates()`, `getSubAccounts()`, `getUser()`, `getTagsAllTimeSeries()`, `isLibraryInstalled()`. |
| `mailchimp_transactional.service` | `Service` (`ServiceInterface`) | Higher-level helper: `getMailSystems()`, `getReceivers()`, `send()` (queues or sends). Used by the mail plugin. |
| `mailchimp_transactional.test` | `TestApi` | API stand-in for tests (no live calls). |
| `mailchimp_transactional.test.service` | `TestService` | Service stand-in for the test mailer. |
| `cache.mailchimp_transactional` | cache bin | Cache bin (used by the reports submodule). |
| `access_check.mailchimp_transactional.configuration` | `ConfigurationAccessCheck` | `_mailchimp_transactional_configuration_access_check` — API key present. |
| `access_check.mailchimp_transactional.mailer` | `MailerAccessCheck` | `_mailchimp_transactional_mailer_access_check` — Mail System default sender is this mailer. |

Call the API directly, e.g.:

```php
$user = \Drupal::service('mailchimp_transactional')->getUser();      // account stats or NULL
$result = \Drupal::service('mailchimp_transactional.service')->send($message);
```

## Mail plugins (`@Mail`)

- `mailchimp_transactional_mail` → `Plugin\Mail\TransactionMail` (real).
- `mailchimp_transactional_test_mail` → `Plugin\Mail\TestMail` (extends TransactionMail, swaps in
  `mailchimp_transactional.test.service`; does not hit the live API).

These are **Drupal Mail plugins**, selected through Mail System — not a plugin type this module
defines.

## How a message is built and sent (`TransactionMail::mail()`)

1. Optional `log_defaulted_sends` notice if the key used this mailer only as the default.
2. Apply `filter_format` to the body via `check_markup()` if set.
3. Build headers; default **Reply-To** to `from_email` when a module didn't set one.
4. Collect attachments from `$message['attachments']` (file paths) and Mime Mail-style
   `$message['params']['attachments']` (uri or `filecontent`). Types validated by
   `isValidContentType()` (image/*, text/*, application/pdf, application/x-zip; extendable via
   `hook_mailchimp_transactional_valid_attachment_types_alter`).
5. Resolve To/Cc/Bcc via `Service::getReceivers()`.
6. Assemble the Mailchimp message array: html/text (text via `MailFormatHelper::htmlToText`),
   subject, from, tracking (`track_opens`/`track_clicks`), `url_strip_qs`, analytics, `subaccount`,
   `tags` = `[message id]`, `view_content_link` (false for `mail_key_denylist` keys), `metadata`.
   `$message['params']['mailchimp_transactional']['overrides']` and `['header']` let callers
   override fields/headers.
7. `\Drupal::moduleHandler()->alter('mailchimp_transactional_mail', $params, $message)`.
8. If `process_async`: `queue('mailchimp_transactional_queue', TRUE)->createItem($params)` and
   return TRUE (optionally logging). Else call `Service::send($params['message'])` immediately.

## Queue worker

`Plugin\QueueWorker\QueueProcessor`, id `mailchimp_transactional_queue`,
`cron = {time = 60}`. `processItem($data)` calls `Service::send($data['message'])`.
`hook_queue_info_alter()` overrides the cron time with `queue_worker_timeout` when async is on.

## Constants (`MailchimpTransactionalInterface`)

`MAILCHIMP_TRANSACTIONAL_QUEUE = 'mailchimp_transactional_queue'`,
`MAILCHIMP_TRANSACTIONAL_EMAIL_REGEX` (parses `Name <email>`),
`MAILCHIMP_TRANSACTIONAL_TEST_API_KEY = 'undefined'`.
