# Message Notify UI — agent index

Submodule of **Message UI**. Adds a **Notify (Send)** form to Message entities, wiring
[Message Notify](https://www.drupal.org/project/message_notify) into the UI. Depends on
`message`, `message_ui`, `message_notify`, `views`. No settings page, no config object.

- **The notify route, tab, permission, and the sender-settings plugin type** →
  [configure/notify.md](configure/notify.md)
- **Implementing a sender-settings plugin for a notifier** →
  [plugins/sender-settings-form.md](plugins/sender-settings-form.md)

Key facts: route `entity.message.notify_form` = `/message/{message}/notify`, form handler
`message.notify` (`MessageNotifyForm`), permission **`send message through the ui`**, local
task "Notify" (`message.message_notify`). Plugin type `message_notify_ui_sender_settings_form`
(manager `plugin.manager.message_notify_ui_sender_settings_form`); shipped plugin id
`message_notify_ui_sender_settings_form` targets `notify_plugin = "email"`.
