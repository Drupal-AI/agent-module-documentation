Message Notify UI adds a "Notify" (Send) form to Message entities so an editor can dispatch a message to a recipient through the UI using Message Notify's notifier plugins.

---

This submodule of Message UI bridges [Message Notify](https://www.drupal.org/project/message_notify) into the web UI. It alters the `message` entity type to add a `notify` entity-form handler (`Drupal\message_notify_ui\Form\MessageNotifyForm`) and a `notify-form` link template at `/message/{message}/notify`, and registers a "Notify" local task tab on the message canonical page. The route `entity.message.notify_form` is gated by a single permission, `send message through the ui`. The form lets the user pick how the message is delivered and, per notifier, shows extra sender settings supplied by a small plugin type, `message_notify_ui_sender_settings_form` (manager `plugin.manager.message_notify_ui_sender_settings_form`); the shipped plugin `message_notify_ui_sender_settings_form` targets the `email` notifier and adds a "use custom email" toggle and an email address field. It depends on `message`, `message_ui`, `message_notify` and `views`, has no settings page and no config object of its own.

---

- Send a Message entity to its recipient from `/message/{message}/notify` in the UI.
- Add a "Notify" tab to each message's page for one-click sending.
- Deliver a message by email using Message Notify's email notifier from the form.
- Restrict who can send messages via the `send message through the ui` permission.
- Let support staff notify a user of an event without writing code.
- Override the recipient email with a custom address at send time.
- Use the message owner's email as the default notification target.
- Choose the notifier plugin (delivery channel) when sending a message.
- Extend the sender form for a custom notifier by adding a sender-settings plugin.
- Provide channel-specific options (e.g. email fields) only when that notifier is selected.
- Trigger notifications as part of an editorial workflow from the message view page.
- Grant the send permission to a dedicated "notifier" role.
- Resend an existing message instance to its recipient on demand.
- Integrate email notifications into a message-based activity log UI.
- Give admins a manual "send now" action for queued or draft messages.
- Test message templates by sending a real notification from the UI.
- Combine with Message UI's create form to author then immediately notify.
- Surface a Notify operation alongside view/edit/delete on message rows (notify contextual link plugin).
- Let editors pick between multiple configured notifiers per send.
- Add sender settings UI for an SMS or push notifier via the plugin type.
