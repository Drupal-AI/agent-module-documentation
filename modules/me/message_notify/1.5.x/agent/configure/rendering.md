# How notifications render (view modes & displays)

Message Notify has no settings form. What a notification *contains* is controlled by two
Message entity **view modes** the module manages, and the per-bundle **entity view displays**
for them.

## The two view modes

Installed by the module (`config/install/`):
- `core.entity_view_mode.message.mail_subject`
- `core.entity_view_mode.message.mail_body`

The `email` notifier declares `viewModes = { "mail_subject", "mail_body" }`, so it renders the
Message in each and uses `mail_subject` as the email subject (tags stripped) and `mail_body`
as the body.

## Per-bundle displays (auto-created)

`message_notify_entity_bundle_create()` runs whenever a **new message bundle (template)** is
created (unless config is syncing). For that bundle it creates:
- `core.entity_view_display.message.<bundle>.mail_subject` — content region shows the
  **`partial_0`** message text field, hides `partial_1`.
- `core.entity_view_display.message.<bundle>.mail_body` — content region shows
  **`partial_1`**, hides `partial_0`.

`partial_0` / `partial_1` are the first and second deltas of the Message template's text
(subject line and body). So by default the first text line becomes the subject and the rest
becomes the body.

## Customize what a notification shows

Edit the bundle's **mail_subject** / **mail_body** view displays
(`/admin/structure/message/manage/<bundle>/display/mail_subject` etc., or the
`entity_view_display` config) to add/remove fields, reorder, or change formatters — exactly
like any entity view display. The notifier renders whatever those displays output.

## Read it back

```bash
drush cget core.entity_view_display.message.<bundle>.mail_body content
# -> partial_1 in the content region
drush cget core.entity_view_mode.message.mail_subject
```

## Note

If you create message templates by importing config (config sync), the auto-setup is skipped
(the hook bails when `\Drupal::isConfigSyncing()`), so ship the `mail_subject`/`mail_body`
displays in your config export too.
