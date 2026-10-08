Courier system (a submodule of Courier) replaces Drupal core's user/account emails (password reset, welcome, account blocked/cancelled, etc.) with Courier template collections, so those notifications flow through the Courier framework instead of core's `hook_mail`.

---

The submodule maps each supported core user mail id (from `user.module` — `user_password_reset`,
`user_status_activated`, `user_status_blocked`, `user_status_canceled`, `user_register_admin_created`,
`user_register_no_approval_required`, `user_register_pending_approval`, `user_cancel_confirm`) to a
**GlobalTemplateCollection** named `courier_system.<mail_id>`. An admin settings form
(`courier_system.config`, `/admin/config/communication/courier_system`, permission core `administer
account settings`) lets you create the missing collections, copy the current Drupal email text into the
Courier email template (converting `[user:name]` → `[identity:label]` and `nl2br`-ing the body), and
enable/disable/delete each override. When an override is enabled, `hook_mail_alter()` cancels the core
mail (`$message['send'] = FALSE`) and instead loads the matching global collection, sets the `user`
token to the recipient `User`, adds the `user_mail_tokens` callback (so `[user:one-time-login-url]` /
`[user:cancel-url]` resolve), and calls `courier.manager->sendMessage()` to deliver it through Courier's
channel/queue machinery. `hook_entity_access()` grants the `templates` operation on these collections to
holders of `administer account settings`. It stores only an `override` map in `courier_system.settings`
(one boolean per mail id). Depends on `courier`.

---

- Route core account emails (password reset, welcome, blocked/cancelled) through Courier.
- Send the password-reset email as a Courier-managed, multi-channel-capable message.
- Edit the welcome/activation email using Courier's template editor instead of the core user-mail form.
- Copy existing Drupal user email text into a Courier email template as a starting point.
- Enable a Courier override for selected user mails while leaving the rest on core mail.
- Disable an override to restore Drupal's native email for a given notification.
- Delete a Courier override collection you no longer need.
- Convert `[user:name]` placeholders to Courier's `[identity:label]` automatically on import.
- Keep one-time-login and cancel URLs working via the `user_mail_tokens` callback.
- Centralise account-notification content alongside other Courier messages.
- Queue account emails for background delivery through Courier's queue.
- Manage all account-mail overrides from one table at *Config › Communication › Courier system*.
- Add missing template collections for user mails in bulk from the settings form.
- Gate override management behind core's `administer account settings` permission.
- Prepare account mails to later gain an SMS (or other) channel by adding an IdentityChannel plugin.
