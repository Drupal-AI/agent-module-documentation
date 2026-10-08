# Email Attachment Helper — agent index

A **developer helper**: attaches files to emails sent via the core MailManager by rewriting the
message into **`multipart/mixed`** when `$message['params']['attachment']` or `['attachments']`
is set. No UI, config, routes, permissions, or Drush.

Key facts:
- You never call it directly — you set `attachment` / `attachments` in the **`$params`** you pass
  to `MailManager::mail()`. Its `hook_mail_alter()` does the conversion.
- One attachment = an array: **`filename`** (required), optional **`filecontent`** (raw bytes; if
  omitted the file at `filename` is read), optional **`filemime`** (guessed if omitted).
- It deliberately runs its `mail_alter` **last** (`hook_module_implements_alter`) so other modules
  can add attachments to `params` first.
- Submodule **email_attachment_demo** (nested) shows the pattern by attaching a file to the core
  contact form mail.

Docs:
- **Attachment param structure + multipart mechanism** → [api/attachments.md](api/attachments.md)
