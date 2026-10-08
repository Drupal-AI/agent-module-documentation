# Courier system — agent index

Courier submodule that **replaces core user/account emails with Courier template collections**. When
an override is enabled, `hook_mail_alter` cancels the core mail and sends the matching Courier
`courier_system.<mail_id>` global template collection instead. Depends on `courier`. Config:
`courier_system.config` at `/admin/config/communication/courier_system` (permission core `administer
account settings`).

- **The settings form, the override map, import/copy behaviour, hook_mail_alter, supported mail ids** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config `courier_system.settings` = `{ override: { <mail_id>: bool, ... } }` (schema lists the 8
  supported user mail ids).
- Overridden mail ids (core `user.module`): `user_cancel_confirm`, `user_password_reset`,
  `user_status_activated`, `user_status_blocked`, `user_status_canceled`, `user_register_admin_created`,
  `user_register_no_approval_required`, `user_register_pending_approval`.
- Each override uses a `GlobalTemplateCollection` id `courier_system.<mail_id>`; `hook_mail_alter`
  loads it, sets the `user` token + `user_mail_tokens` callback, and calls `courier.manager->sendMessage()`.
- No own permissions; management gated by core `administer account settings` (restricted). Also grants
  the collections' `templates` entity operation to that permission via `hook_entity_access`.
- Only user mails are supported today (`copyCoreToCourierEmail()` reads `user.mail` config).
