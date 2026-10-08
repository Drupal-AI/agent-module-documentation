# The mime_mail Mail plugin

`Drupal\mimemail\Plugin\Mail\MimeMail` (id `mime_mail`, label "Mime Mail mailer") extends
core `PhpMail`. This is the plugin you select in Mail System, not a plugin *type* you extend.

- `format()` — renders the message through the `mimemail_message` theme hook, inlines CSS,
  embeds images and produces a MIME multipart (HTML + plaintext alternative) body.
- `mail()` — inherited from `PhpMail`; sends via PHP `mail()`. To deliver over SMTP, keep
  Mime Mail as the **formatter** in Mail System but pick an SMTP **sender** plugin.
- Honors `mimemail.settings`: `textonly` (force plain text), `linkonly` (link vs embed
  images), sender `name`/`mail`, and the per-user plaintext opt-out field.

You normally never instantiate it — it is dispatched by `MailManagerInterface` once Mail
System routes a module/key to `mime_mail`.
