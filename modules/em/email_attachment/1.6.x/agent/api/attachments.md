# Attaching files to email

## The contract

Populate the mail `$params` you pass to the core MailManager. There is nothing else to call.

```php
\Drupal::service('plugin.manager.mail')->mail(
  'my_module',            // module
  'my_key',               // mail key (your hook_mail builds subject/body)
  'to@example.com',
  'en',
  [
    // one attachment:
    'attachment' => [
      'filename'    => 'report.pdf',                 // REQUIRED
      'filecontent' => $bytes,                       // optional raw content
      'filemime'    => 'application/pdf',            // optional (guessed if omitted)
    ],
    // OR several:
    'attachments' => [
      ['filename' => 'a.csv', 'filecontent' => $a],
      ['filename' => 'public://exports/b.csv'],      // read from disk if no filecontent
    ],
  ],
);
```

Both `attachment` (single) and `attachments` (array) are honored; you can use either or both.

## Per-attachment fields

- **`filename`** (required): display name and, when `filecontent` is absent, the path/URI to read
  (`is_file()` + `file_get_contents()` — supports stream wrappers like `public://`). Missing
  `filename` throws `InvalidArgumentException`; a `filename` with no `filecontent` that is not a
  real file throws `FileNotExistsException`.
- **`filecontent`** (optional): raw bytes to attach. If set, the file is **not** read from disk.
- **`filemime`** (optional): Content-Type. If omitted it is guessed — via
  `file.mime_type.guesser` when `filename` is a real file, else
  `file.mime_type.guesser.extension` from the name.

## What the module does (mechanism)

`hook_mail_alter()` (in `EmailAttachmentHooks::mailAlter`) fires only when `params.attachment`
or `params.attachments` is non-empty, then `_email_attachment_convert_to_multipart()`:

1. Generates a MIME boundary `uid` and sets
   `headers['Content-Type'] = 'multipart/mixed; boundary="<uid>"'`.
2. Makes the **original body** the first MIME part (keeping its original Content-Type).
3. Appends each attachment as a part with `Content-Transfer-Encoding: base64`, a
   `Content-Disposition: attachment` header, and the content `base64`-encoded + `chunk_split`.
   Filenames are transliterated (`PhpTransliteration`) and RFC 2184-encoded in `name`/`filename`.
4. Replaces `$message['body']` with the assembled multipart string.

`hook_module_implements_alter()` moves this module's `mail_alter` to run **last**, so other
modules' `mail_alter` implementations can add to `params['attachment(s)']` before conversion.

## Notes for an agent

- If neither `attachment` nor `attachments` is set, the module does nothing — a plain email.
- The conversion is driven entirely by `params`; there is no config, service, or route to touch.
- To verify behavior on a live site without sending real mail, build a `$message` array with
  `headers`, `body`, and `params`, then call
  `\Drupal::service(\Drupal\email_attachment\Hook\EmailAttachmentHooks::class)->mailAlter($message)`
  and inspect `$message['headers']['Content-Type']` and `$message['body']`.
