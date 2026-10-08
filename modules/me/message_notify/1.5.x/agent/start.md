# Message Notify — agent index

Developer framework that **renders a Message entity and delivers it** to a user via a
pluggable notifier (email built in). No admin UI (`configure: null`), no permissions, no
Drush, no config schema. Depends on `message`. Submodule: `message_notify_example`.

- **Send a notification in code: the `message_notify.sender` service, `send()` signature, options** →
  [api/send.md](api/send.md)
- **The Notifier plugin type: implement your own (email/sms), view modes, alter hook** →
  [plugins/notifier.md](plugins/notifier.md)
- **How notifications render: the `mail_subject` / `mail_body` view modes & per-bundle displays** →
  [configure/rendering.md](configure/rendering.md)

Key facts:
- Service id `message_notify.sender` →
  `send(MessageInterface $message, array $options = [], string $notifier_name = 'email'): bool`.
- Plugin type: `@Notifier` in `Plugin/Notifier`, base `MessageNotifierBase`, manager service
  `plugin.message_notify.notifier.manager` (alter hook `hook_message_notifier_info_alter`).
- Built-in notifier ids: `email` (works). `sms` is a stub (throws — needs SMS Framework).
- Email options: `mail`, `from`, `language override`; base options: `save on success`
  (default TRUE), `save on fail` (default FALSE), `rendered fields`.
- Module auto-creates Message view modes `mail_subject` / `mail_body` and per-bundle view
  displays (subject shows `partial_0`, body shows `partial_1`).
