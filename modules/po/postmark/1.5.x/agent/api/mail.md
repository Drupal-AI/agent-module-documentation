# Postmark — mail plugin & handler service

## Mail plugin `postmark_mail` (`PostmarkMail`)

`src/Plugin/Mail/PostmarkMail.php`, `@Mail(id = "postmark_mail")`. Selected through Mail System,
not instantiated directly. Two methods matter:

- `format($message)` — joins the `body` array into a string; if `format_filter` config is set,
  runs it through `check_markup($body, $format, $langcode)`.
- `mail($message)` — builds a Postmark message array:
  - `from` ← `$message['from']`, `to`, `subject`, `html` ← `$message['body']`.
  - `text` ← `$message['plain']` if set, else generated from the HTML with `Html2Text`.
  - `cc` / `bcc` ← `$message['headers']['Cc' / 'Bcc']` if present.
  - `reply-to` ← `$message['reply-to']` if present.
  - `attachment` ← `$message['params']['attachments']` (array of file paths; only paths that
    `file_exists()` are forwarded as `['filePath' => …]`).
  - then delegates to `postmark.mail_handler`'s `sendMail()`.

> Note: `PostmarkHandler::sendMail()` overrides the message From with the configured
> `postmark_sender_signature` (Postmark requires a verified signature), so the per-message `from`
> is effectively ignored on the wire.

## Service `postmark.mail_handler` (`PostmarkHandler`)

Constructor args: `@config.factory`, `@logger.channel.postmark`. Instantiates a
`\Postmark\PostmarkClient` with `postmark.settings:postmark_api_key`.

### `sendMail(array $params): bool`

Expects keys `to`, `subject`, `html`, `text`, and optional `reply-to`, `cc`, `bcc`. Behavior:
- Returns FALSE (and logs) if `checkApiSettings()` fails (empty key/signature or client construction throws).
- If `postmark_debug_no_send` is set, adds a status message and returns TRUE without sending.
- If `postmark_debug_mode` + `postmark_debug_email` are set, sends to the debug address instead of `to`.
- Calls `PostmarkClient::sendEmail(signature, to, subject, html, text, tag=NULL, trackOpens=FALSE, replyTo, cc, bcc)`.
- Catches `PostmarkException` / generic exceptions, logs to the `postmark` channel, returns FALSE.

### Static helpers

- `PostmarkHandler::checkLibrary($showMessage=FALSE)` — is the `wildbit/postmark-php` class present.
- `PostmarkHandler::checkApiSettings($key, $signature, $showMessage=FALSE)` — both non-empty and key valid.
- `PostmarkHandler::validateKey($key)` — tries to construct a `PostmarkClient`.

### Send programmatically

Prefer core mail so plugin selection/formatting apply:

```php
\Drupal::service('plugin.manager.mail')->mail('mymodule', 'key', 'to@example.com', $langcode, $params);
```

Or call the handler directly (bypasses Mail System formatting):

```php
\Drupal::service('postmark.mail_handler')->sendMail([
  'to' => 'to@example.com', 'subject' => 'Hi', 'html' => '<p>Body</p>', 'text' => 'Body',
]);
```
