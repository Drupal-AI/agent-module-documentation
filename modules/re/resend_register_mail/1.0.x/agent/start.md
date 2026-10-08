<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# resend_register_mail — agent index

Re-sends a user account's registration / welcome / awaiting-approval mail (or a
password-recovery mail) via core's `_user_mail_notify()`. Two triggers exist: a **bulk
user action** on the People screen (`/admin/people`) that leads to a confirm form where the
operator picks the mail type, and a **submit button added to each user's edit form**.

- Depends on core `user` only. Core requirement: `^10.2 || ^11`.
- No settings page (`configure` = null). No Drush commands. No public services beyond the hook class.
- Defines one permission, one config-installed Action plugin instance, and one config schema key.

Solution docs:
- **Bulk-resend selected users + the confirm form and mail types** → [configure/resend_action.md](configure/resend_action.md)
- **Resend button on a single user's edit form** → [hooks/user_form_button.md](hooks/user_form_button.md)
- **Who may trigger a resend (permission + route access)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permission: `resend account emails` (title "Resend account emails"; defined with `restrict access: true`).
- Route `resend_register_mail_action.resend_email` — path `/admin/user/resend-email`,
  `_form: \Drupal\resend_register_mail\Form\UserMultipleResendEmail`, `_title: 'Resend Email'`,
  requirement `_permission: 'administer users+resend account emails'` (the `+` is OR — either permission grants access).
- Action plugin id `resend_register_mail_action` (`#[Action]`, `type: user`),
  class `Drupal\resend_register_mail\Plugin\Action\ResendRegisterMail`;
  `confirm_form_route_name: resend_register_mail_action.resend_email`.
  Installed as config entity `system.action.resend_register_mail_action` (config/install).
- Hook class `Drupal\resend_register_mail\Hook\FormHooks` (autowired service, registered in
  `resend_register_mail.services.yml`) implements `hook_form_user_form_alter` via `#[Hook('form_user_form_alter')]`;
  `resend_register_mail.module` keeps a `#[LegacyHook]` shim `resend_register_mail_form_user_form_alter()`.
- Private tempstore collection `user_user_operations_resend_email`, keyed by the acting user's id.
- Config schema key `action.configuration.resend_register_mail_action` (type `action_configuration_default`).
- Mail types the confirm form offers: `register_admin_created`, `register_no_approval_required`,
  `register_pending_approval`, `password_reset`. Logger channel: `resend_register_mail`.
