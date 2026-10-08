# Better Messages — agent index

Restyles Drupal's status/warning/error messages as animated, positionable popups (auto-close,
draggable, resizable, per-page visibility). Depends on `jquery_ui_draggable` +
`jquery_ui_resizable`. Configure route `better_messages.settings_form` →
`/admin/config/user-interface/better-messages` (permission `configure better messages`). Its only
persistent state is the `better_messages.settings` config object.

- **All settings keys, the admin form/route/permission, defaults, reading/writing config** →
  [configure/settings.md](configure/settings.md)
- **The `message_type` Condition plugin + `better_messages.context` context provider** →
  [plugins/condition.md](plugins/condition.md)

Key facts: config object `better_messages.settings`; key settings `position`, `vertical`,
`horizontal`, `fixed`, `width`, `autoclose`, `disable_autoclose`, `show_countdown`,
`hover_autoclose`, `opendelay`, `popin.{effect,duration}`, `popout.{effect,duration}`,
`jquery_ui.{draggable,resizable}`, `visibility` (condition plugin config). Permission `configure
better messages`. Condition plugin id `message_type`; context provider service
`better_messages.context`.
