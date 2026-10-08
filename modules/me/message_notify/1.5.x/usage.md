Message Notify is a developer notification framework for the Message module: it takes a Message entity, renders it, and delivers it to a user through a pluggable "notifier" (email out of the box), optionally saving the rendered output.

---

Message Notify adds no admin UI (`configure: null`); it is a code-facing framework. The entry point is the `message_notify.sender` service (`MessageNotifier::send($message, $options, $notifier_name = 'email')`), which looks up a notifier plugin by id, instantiates it with the Message entity and an options array, checks `access()`, and calls `send()`. Notifiers are `@Notifier` annotated plugins in `Plugin/Notifier`, extending `MessageNotifierBase` and implementing `deliver(array $output)`. The base class renders the Message once per view mode declared in the plugin's `viewModes` and passes the rendered strings to `deliver()`; after delivery `postSend()` logs failures, honours the `save on success` / `save on fail` config flags, and can write rendered output back into message fields via the `rendered fields` option. The shipped **Email** notifier (id `email`) renders the `mail_subject` and `mail_body` view modes, strips tags from the subject, resolves the recipient (`mail` option or the message owner's email), and sends through core's Mail manager via `message_notify_mail()` (`hook_mail`). On install and whenever a new message bundle is created, the module auto-creates two Message view modes — `mail_subject` and `mail_body` — and per-bundle entity view displays that split the message text partials (subject display shows `partial_0`, body display shows `partial_1`). An `Sms` notifier class exists but is a stub requiring the SMS Framework. Notifier definitions can be altered via `hook_message_notifier_info_alter()`.

---

- Send an email to a user when a Message entity records an event (comment, order, signup).
- Build a custom notifier plugin (push, Slack, webhook, SMS) by extending `MessageNotifierBase`.
- Deliver a notification with an explicit recipient address via the `mail` option instead of the message owner.
- Override the "From" address of a notification email via the `from` option.
- Force a notification to render in the message's own language using the `language override` option.
- Render a message's subject and body through the `mail_subject` / `mail_body` view modes.
- Save the rendered subject/body back into message fields using the `rendered fields` option.
- Control whether a message is saved after a successful send (`save on success`, default TRUE).
- Persist failed-send messages for retry by setting `save on fail` to TRUE.
- Trigger notifications from an entity hook (e.g. send to node author on new comment — see the example submodule).
- Send the same Message through multiple notifiers by calling the service once per notifier id.
- Programmatically check `access()` before delivering to gate who receives a notification.
- Customize which message fields appear in a notification by editing the `mail_subject`/`mail_body` view displays.
- Log delivery failures to the `message_notify` logger channel for monitoring.
- Alter or add notifier plugin definitions with `hook_message_notifier_info_alter()`.
- Integrate transactional email (welcome, password, receipt) built on Message templates.
- Queue notifications by wrapping `message_notify.sender->send()` in a queue worker.
- Send activity-stream digest emails composed from Message entities.
- Localize notification content per recipient's preferred language (default email behavior).
- Reuse one Message template to notify several users by looping over recipients.
- Unit/integration test notification delivery via the notifier plugin manager.
- Extend the framework with a notifier that delivers to a third-party API from `deliver()`.
