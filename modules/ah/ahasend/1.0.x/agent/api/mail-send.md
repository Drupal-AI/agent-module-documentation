<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AhaSend — mail plugin & send handler

## The Mail plugin: `AhaSendMail`

`src/Plugin/Mail/AhaSendMail.php`, `@Mail(id = "ahasend_mail")`, implements `MailInterface` and
`ContainerFactoryPluginInterface`. `create()` injects the `ahasend.settings` config, the `ahasend`
logger channel, and the `ahasend.mail_handler` service.

- **`format(array $message)`** — joins `$message['body']` (array) with `"\n\n"`. If config
  `format_filter` is set, runs `check_markup($body, $format, $langcode)`. Returns the message.
- **`mail(array $message)`** — builds a payload and calls `AhaSendHandler::sendMail()`:
  - `from` = `$message['from']`, `to` = `$message['to']`, `subject` = `$message['subject']`,
    `html` = `$message['body']`.
  - `text`: uses `$message['plain']` if set, else derives it from the HTML body via
    `Html2Text\Html2Text::getText()`.
  - `cc` / `bcc` from `$message['headers']['Cc']` / `['Bcc']`; `reply-to` from `$message['reply-to']`.
  - Attachments: for each `$message['params']['attachments']` entry that `file_exists()`, adds
    `['filePath' => $path]` under `$payload['attachment']`.

## The send handler: `AhaSendHandler::sendMail(array $params)`

`src/AhaSendHandler.php`, service `ahasend.mail_handler`
(args: `config.factory`, `logger.channel.ahasend`, `stream_wrapper_manager`, `entity_type.manager`,
`http_client`). Reads `api_key`, `from_name`, `debug_mode` from `ahasend.settings`.

**Payload assembly** (AhaSend API `email` object):

- Address parsing: `getContactObjects($line)` uses `pear/mail`'s `Mail_RFC822` parser to split an
  address list into `{name, email}` objects. `from` is the first parsed contact of `$params['from']`
  (falling back to `system.site` `mail`); `recipients` = all parsed contacts of `$params['to']`.
  If a from contact has no name, it gets `from_name` (or the site name).
- `content` = `{subject, text_body, html_body}`. `html_body` is only set when `html` is present and
  `text` is empty; `text_body` is set when `text` is present.
- `cc` / `bcc` are placed under `content.headers`; `reply_to` under `content.reply_to` (parsed, or
  a raw `{email}` if parsing fails).
- Attachments: for a stream URI, loads the managed `file` entity by URI and base64-encodes its
  contents (`data`, `base64: true`, `file_name`, `content_type`); for a plain path, reads the file
  directly; for in-memory `filecontent`, uses it as-is (`base64` = mime is not `text/plain`).
  `content_id` is copied through for inline/embedded images.

**Transport:**

```
$this->httpClient->post(
  'https://api.ahasend.com/v1/email/send',
  ['json' => $email, 'headers' => ['X-Api-Key' => $api_key]]
);
```

Uses the core Guzzle `http_client` with default TLS verification (no `verify` override); the API
key travels in the `X-Api-Key` request header, not in the URL.

**Result handling:** treats HTTP **201** as success. `400`/`403`/`500`/any-other status throw an
exception carrying the response body; the `catch` logs an `error` to the `ahasend` channel and
`sendMail()` returns `FALSE`. On success with `debug_mode` on, logs a `notice` with the parsed
response (message id, etc.). Returns `TRUE` on success.
