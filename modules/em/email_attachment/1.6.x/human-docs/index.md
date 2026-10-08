# Email Attachment Helper — manual setup guide

**Email Attachment Helper** (`email_attachment`) is a small developer helper that
lets you attach files to emails Drupal sends through the core mail system. Drupal's
`MailManager` has no built-in way to add MIME attachments; this module fills that
gap. When a message being sent carries an `attachment` (or `attachments`) entry in
its `params`, the module rewrites the email into a proper `multipart/mixed` message —
the original body becomes the first part, and each file is appended, base64-encoded,
as an attachment.

This is a module **for developers**, not editors: there is no UI, no settings page,
no permission, and no routes. You never call the module directly. Instead, when your
code (or another module's mail handler) sends mail through the core MailManager, you
add an attachment description to the `$params` array. Each attachment is a small
array with a required `filename` and optional `filecontent` (raw bytes — if omitted,
the file at `filename` is read from disk, including stream wrappers like `public://`)
and `filemime` (guessed from the filename when omitted). Typical uses are attaching a
generated PDF or CSV to a notification, sending an invoice or `.ics` calendar file
with a confirmation email, or emailing a one-off export to a user.

The module deliberately runs its work *last* among mail alterations, so other modules
can add attachments to a message's `params` before it converts them. It has no
dependencies beyond Drupal core. It ships one optional submodule,
**`email_attachment_demo`**, which demonstrates the pattern by attaching a file to
the core contact form's email — install it only if you want the worked example.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the demo submodule.

## Where it lives in the admin menu

Nowhere — there is no admin page, settings form, or permission. The module works
purely through code, by acting on the mail `params` your code passes to the
MailManager.

## How to use it

Populate `attachment` or `attachments` in the `$params` you pass to the core mail
manager. There is nothing else to call:

```php
\Drupal::service('plugin.manager.mail')->mail(
  'my_module',       // module
  'my_key',          // mail key — your hook_mail() builds the subject/body
  'to@example.com',
  'en',
  [
    // a single attachment:
    'attachment' => [
      'filename'    => 'report.pdf',      // REQUIRED (display name, or path/URI to read)
      'filecontent' => $bytes,            // optional raw content; if omitted, read from disk
      'filemime'    => 'application/pdf', // optional; guessed from the name if omitted
    ],
    // or several at once:
    'attachments' => [
      ['filename' => 'a.csv', 'filecontent' => $a],
      ['filename' => 'public://exports/b.csv'],  // read from disk (no filecontent)
    ],
  ],
);
```

Per-attachment fields:

- **`filename`** (required) — the display name, and when `filecontent` is absent, the
  path or stream-wrapper URI to read from disk. A missing `filename` throws an
  exception; a `filename` with no `filecontent` that isn't a real file also throws.
- **`filecontent`** (optional) — raw bytes to attach. If set, nothing is read from
  disk.
- **`filemime`** (optional) — the Content-Type. If omitted it is guessed, from the
  file itself when possible, otherwise from the filename's extension.

If neither `attachment` nor `attachments` is set, the module does nothing and the
email is sent as normal.
