<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The alter hook, the mail backend, attachments & debug

## `hook_mail_alter()` — `src/Hook/MailAlter.php`

`phpmail_alter_mail_alter(array &$message)` (in `.module`) calls `MailAlter::hook($message)`:

1. If config `from` is set and `$message['headers']` is an array → `headers['From'] = from`.
2. If config `reply` is set, `$message['reply-to']` is empty, and headers is an array →
   `headers['Reply-to'] = reply`.
3. If config `phpmail` is on **and** `$message['id'] !== 'register_no_approval_required'` →
   `$message['send'] = !\Drupal::service('phpmail_alter')->mail($message);`

Step 3 means: the module sends the message itself and, on success, flips `send` to FALSE so
Drupal's configured mail plugin does not send it a second time. The `register_no_approval_required`
message id is deliberately excluded (left to the default sender).

## Backend service `phpmail_alter` — `src/Service/PhpMail.php`

`class PhpMail implements PhpMailInterface`. Public API: `mail(array $message): bool` and
`format(array $message): string`. It is a fork of core's `Drupal\Core\Mail\Plugin\Mail\PhpMail`
calling PHP's native `mail()`.

### `mail()`

- Normalises headers via private `headers()` (string keys/values only).
- Envelope `Return-Path`: extracted; passed later as `-f` only when `isShellSafe()` passes.
- If `Reply-to` is set → adds `List-Unsubscribe: <mailto:REPLY>`.
- Builds `$mimeheaders`: for **`From`** it runs `mimeEncodeFromValue()` (MIME-encodes the
  display-name part before ` <`), fires `moduleHandler->alter('phpmail_alter_from', $value)`, then
  appends `From: <value>` **verbatim**. Every **other** header value is encoded through
  Symfony Mime `UnstructuredHeader('subject', $value)->getBodyAsString()` (RFC-2047 folding/encoding).
  `Content-Type: text/html` is expanded to `text/html; charset=utf-8`.
- Subject → `UnstructuredHeader` encoded. Body → `format()`.
- Calls `appendAttachments()` (may rewrite body + headers into `multipart/mixed`).
- `@mail($to, $subject, $body, $headers, $additional_headers)` where `$to` = stringified
  `$message['to']` and `$additional_headers` = `-f RETURN_PATH` when shell-safe.
- On failure: `messenger->addError(...)` and `debugService->log()`. Always calls
  `debugService->debug()`. Returns the `mail()` bool.

### `format()`

Joins `$message['body']` parts with blank lines; inserts CRLF after `<br>`; soft-wraps lines
longer than 400 chars at the next space. If the Content-Type is **not** `text/html`, converts to
plain text via `MailFormatHelper::htmlToText()` + `wrapMail()`; otherwise wraps the body in
`<html>…</html>`. Normalises line endings to `Settings::get('mail_line_endings', PHP_EOL)`.

### Attachments — `getFilesToAttach()` / `appendAttachments()` / `addAttachment()`

Only active when `$message['params']['contact_message']` is a `FieldableEntityInterface` (a core
**Contact** submission). It iterates the entity's **file-type** fields, collects referenced
`FileInterface` entities, and for each builds a `multipart/mixed` part: reads the managed file's
URI with `file_get_contents`, base64/`chunk_split` encodes it, and sets RFC-2184-encoded
`name`/`filename` from `basename()` of the file URI, with MIME type from
`@file.mime_type.guesser` (fallback `application/octet-stream`). A random 16-byte hex boundary
(`bin2hex(random_bytes(16))`) is used. Files are read only from managed file entities the contact
message already references — not from any request- or config-supplied path.

### `isShellSafe()`

Guards the envelope `-f` argument (per CVE-2016-10045 pattern): rejects if
`escapeshellcmd`/`escapeshellarg` alter the string or if it matches `/[^a-zA-Z0-9@_\-.]/`.

## Debug service `phpmail_alter.debug` — `src/Service/DebugService.php`

- `log(array $message, string $mail_headers)`: on send failure, logs `"$recipient $subject <pre>$headers</pre>"`
  at **error** level to the `phpmail_alter` channel.
- `debug(array $message, string $mail_headers, string $mail_subject, string $mail_body, string $additional_headers)`:
  when config `debug` is on, `print_r`-dumps `{to, subject{encoded,decoded}, body, headers,
  additional_headers}` at **notice** level to the same channel. Keep off in production — it logs
  full message bodies and recipients.

## Alter hook you can implement

`hook_phpmail_alter_from(&$value)` — fired inside `PhpMail::mail()` (and `appendAttachments()`)
just before the `From` header line is emitted, letting another module rewrite the final From value.

## Deprecated shim — `src/Controller/PhpMail.php`

`PhpMail::mail(array $message): bool` (static) logs `"Deprecated: …"` warning and delegates to the
`phpmail_alter` service. Kept for backward compatibility only; call the service directly instead.
