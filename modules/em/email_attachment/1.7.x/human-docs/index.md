# Email Attachment Helper — manual setup guide

**Email Attachment Helper** (`email_attachment`) is a small developer helper that
lets modules attach files to the emails Drupal sends. It doesn't send mail itself
and it has no settings — instead it quietly intercepts outgoing messages, and if a
message carries an `attachment` (or `attachments`) entry in its parameters, it
rewrites the message into a proper `multipart/mixed` MIME email with the file(s)
base64-encoded. If no attachment parameter is present, it leaves the mail
completely untouched.

The problem it solves is that Drupal's core mail system has no built-in way to add
file attachments, and hand-building MIME multipart bodies is fiddly and
error-prone. With this module installed, a developer just adds a small array
describing the file — a `filename`, and either `filecontent` (raw bytes) or a path
on disk — to the mail's `params`, and the attachment appears in the delivered
email. Attachments can also be marked **inline** with a `cid` (Content-ID) so they
can be embedded in the HTML body, for example an inline logo or a generated QR
code referenced by `<img src="cid:...">`.

There is nothing to configure and nothing to click — this is code-facing
infrastructure. You benefit from it only when you (or another module) populate the
mail parameters. It ships a small **email_attachment_demo** submodule that
demonstrates the technique end to end.

One important compatibility note: this module hooks into Drupal core's default
**MailManager** via `hook_mail_alter()`. It is **not compatible with Symfony
Mailer, Mailer Plus, or DSM+** — if your site uses one of those mail systems, this
helper won't apply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the demo submodule.

There is **no configuration page** for this module — it has no settings. You use
it entirely from code, as shown in "How to use it" below.

## How to use it

Populate the mail's `params` when you call the core MailManager, and the helper
does the rest. For a single file:

```php
$params['attachment'] = [
  'filecontent' => file_get_contents('temporary://report.pdf'),
  'filename' => 'Report.pdf',
  'filemime' => 'application/pdf', // optional; guessed from the filename if omitted
];
$mail_manager = \Drupal::service('plugin.manager.mail');
$mail_manager->mail($module, $key, $to, $langcode, $params);
```

For several files, use `attachments` with a nested array of the same structure.
The `filecontent` key is optional if `filename` points to an existing file on the
server; the `filemime` key is optional (Drupal guesses it, falling back to
`application/octet-stream`). To embed an image in the HTML body, add `'disposition'
=> 'inline'` and a `'cid'` to the attachment, then reference that same `cid` from
the body. You can also add attachments from another module using
`hook_mail_alter()` — this helper is configured to run **last**, so other modules'
additions to `params` are picked up before it converts the message. For complete,
working examples see the bundled **email_attachment_demo** submodule.
