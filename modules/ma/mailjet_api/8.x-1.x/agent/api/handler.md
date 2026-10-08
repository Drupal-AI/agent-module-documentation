# Mail handler + Mail plugin API

## Service `mailjet_api.mail_handler`

`Drupal\mailjet_api\MailjetApiHandler` implements `MailjetApiHandlerInterface`. Constructed with
`@config.factory`, `@logger.channel.mailjet_api`, `@email.validator`, `@event_dispatcher`. It
builds a Mailjet client for the configured keys against Send API `v3.1`.

| Method | Signature | Behavior |
|--------|-----------|----------|
| `buildMessagesBody` | `(array $message): array` | Maps a Drupal message array to the Mailjet v3.1 payload `['Messages' => [ … ]]`. Dispatches the pre/post-build events. |
| `sendMail` | `(array $body): bool` | Checks API settings, `POST`s to `Resources::$Email`. Returns `TRUE` only on HTTP status 200; catches exceptions and logs errors. |
| `status` | `(bool $showMessage = FALSE): bool` *(static)* | `checkLibrary() && checkApiSettings()`. |
| `checkLibrary` | `(bool $showMessage = FALSE): bool` *(static)* | TRUE if `\Mailjet\Client` exists (SDK installed). |
| `checkApiSettings` | `(bool $showMessage = FALSE): bool` *(static)* | FALSE if either key is empty or `validateKey()` fails. |
| `validateKey` | `(string $public, string $secret): bool` *(static)* | Live `GET` on the Mailjet `Apikey` resource; TRUE if reachable. |

## Mail plugin `mailjet_api_mail`

`Drupal\mailjet_api\Plugin\Mail\MailjetApiMail` (annotation `@Mail`, label "Mailjet API mailer").

- `format($message)` — joins/sanitizes the body (`check_markup` with `format_filter`, else
  `Xss::filter` on `a em strong cite blockquote code ul ol li dl dt dd p br`), optionally renders
  through the `mailjet` theme (`use_theme`) and inlines images (`embed_image`).
- `mail($message)` — `buildMessagesBody()` then, if `use_queue`, pushes an item to the
  `mailjet_api_cron_worker` queue and returns TRUE; otherwise calls `sendMail()` immediately.

## Message array / `params` the handler honors

`buildMessagesBody()` reads these from the standard Drupal `$message` array:

| Source | Mailjet field |
|--------|---------------|
| `from` → `params['from']` → `params['from_mail']` → `system.site` mail (first valid) | `From.Email` |
| `params['from_name']` (empty string removes it), else site name | `From.Name` |
| `to` (comma-separated, each validated) | `To[].Email` |
| `subject` | `Subject` |
| `body` (string or array joined) | `HTMLPart`; `TextPart` from `message['plain']` or Html2Text of the body |
| `params['cc']`, `params['cc_mail']` | `Cc[].Email` |
| `params['bcc']`, `params['bcc_mail']` | `Bcc[].Email` |
| `reply-to` (valid) else the From address | `ReplyTo.Email` |
| `params['attachments']` (array with `filecontent`/`filepath`+`filename`+`filemime`, or a path string) | `Attachments[]` (base64) |
| `params['InlinedAttachments']` | `InlinedAttachments[]` |
| `params['TemplateId']` (only if config `mailjet_templates`) | `TemplateID` + `TemplateLanguage: true` (body ignored) |
| `params['CustomCampaign']` (only if config `custom_campaign`) | `CustomCampaign` |
| `params['DeduplicateCampaign']` (only if config `deduplicate_campaign` + a custom campaign) | `DeduplicateCampaign: true` |
| `params['Variables']` | `Variables` |
| config `template_error` + `template_error_email` | `TemplateErrorReporting` + `TemplateErrorDeliver: true` |
| config `sandbox_mode` | payload `SandboxMode: true` |

`cc_mail` / `bcc_mail` exist to support the Webform module's parameter names.

## Sending programmatically

Normal path — configure Mail System to the Mailjet mailer, then use the mail manager:

```php
\Drupal::service('plugin.manager.mail')->mail(
  'my_module', 'my_key', 'to@example.com', 'en',
  ['subject' => 'Hi', 'body' => ['<p>Hello</p>'], 'params' => ['TemplateId' => 123]]
);
```

Direct handler call (bypasses Mail System routing):

```php
$handler = \Drupal::service('mailjet_api.mail_handler');
$body = $handler->buildMessagesBody([
  'to' => 'to@example.com',
  'from' => 'site@example.com',
  'subject' => 'Hi',
  'body' => '<p>Hello</p>',
  'langcode' => 'en',
  'params' => [],
]);
$handler->sendMail($body);
```

## Queue / cron

QueueWorker `mailjet_api_cron_worker` (`cron = {"time" = 10}`) calls `sendMail()` per item and
throws `RequeueException` on failure so the item is retried. Only used when `use_queue` is on.
`hook_mail()` handles the `test_form_email` key (used by the test form's Mail Manager mode).
