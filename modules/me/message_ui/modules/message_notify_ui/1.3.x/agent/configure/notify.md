# Notify form, route, tab & permission

Set up by `message_notify_ui_entity_type_alter()` and routing/links YAML.

- **Entity form handler:** `notify` → `Drupal\message_notify_ui\Form\MessageNotifyForm`
  (an `EntityForm`; uses `message_notify.sender` + the notifier plugin manager).
- **Link template:** `notify-form` → `/message/{message}/notify`.
- **Route:** `entity.message.notify_form`, path `/message/{message}/notify`,
  `_entity_form: message.notify`, requirement `_permission: 'send message through the ui'`,
  `_admin_route: TRUE`.
- **Local task:** `message.message_notify` (title "Notify", weight 30) on base route
  `entity.message.canonical`.

## Permission

```
send message through the ui   # message_notify_ui.permissions.yml
```

Grant it: `drush role:perm:add <role> 'send message through the ui'`, or in PHP
`$role->grantPermission('send message through the ui')`. Without it the notify route/tab is 403.

## Sender-settings plugin type

The form renders per-notifier extra fields from the plugin type
`message_notify_ui_sender_settings_form`:

- Manager: `plugin.manager.message_notify_ui_sender_settings_form` →
  `MessageNotifyUiSenderSettingsFormManager` (dir `Plugin/MessageNotifyUiSenderSettingsForm`).
- Interface: `MessageNotifyUiSenderSettingsFormInterface` (base
  `MessageNotifyUiSenderSettingsFormBase`).
- Annotation `@MessageNotifyUiSenderSettingsForm` fields: `id`, `label`, `notify_plugin`
  (the Message Notify notifier id this form applies to, e.g. `email`).
- Alter hook: `hook_message_notify_ui_message_notify_ui_sender_settings_form_info_alter()`.

Shipped plugin: `message_notify_ui_sender_settings_form`
(`MessageNotifyUiSenderMailSettingsForm`, `notify_plugin = "email"`) — adds a "Use custom email"
checkbox and a conditional email field. See
[../plugins/sender-settings-form.md](../plugins/sender-settings-form.md).
