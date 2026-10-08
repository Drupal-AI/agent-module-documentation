Disable Account Emails lets administrators selectively suppress specific automated user-account emails that Drupal core's user module would otherwise send.

---

The module adds a "Disable Account Emails" checkbox fieldset to the core Account settings page (`/admin/config/people/accounts`, route `entity.user.admin_form`) via `hook_form_FORM_ID_alter()`. Each checkbox corresponds to one of nine core user email keys; checking a box records it as disabled in the `disable_account_emails.settings` config object. At send time, `hook_mail_alter()` inspects every message whose `module` is `user`, and if that message's `key` is marked disabled it sets `$message['send'] = FALSE`, so Drupal builds but never delivers the mail. There is no separate configuration page, no route, permission, service, or plugin of its own — the UI reuses the core account-settings form (already gated by core's "Administer account settings" permission), and `hook_uninstall()` deletes the config on removal.

---

- Prevent Drupal from emailing new users when accounts are created by an administrator (`register_admin_created`).
- Suppress the "welcome, awaiting approval" email to users who self-register on approval-required sites (`register_pending_approval`).
- Stop the "a user is awaiting approval" notification that would otherwise go to admins (`register_pending_approval_admin`).
- Suppress the "welcome, no approval required" email on open-registration sites (`register_no_approval_required`).
- Disable the account activation email when accounts are activated (`register_activate`).
- Silence the "your account has been blocked" email (`status_blocked`).
- Silence the account cancellation confirmation email (`cancel_confirm`).
- Silence the "your account has been deleted" email (`status_deleted`).
- Disable the password recovery email on sites where password reset is handled elsewhere (`password_reset`).
- Quiet Drupal's account emails on a site that authenticates users through LDAP, SSO, or OAuth and communicates through those systems instead.
- Route all user notifications through a custom or third-party workflow while keeping core from sending duplicates.
- Reduce inbox noise in a staging or QA environment where account emails are unwanted.
- Turn off admin-notification emails while leaving user-facing welcome emails intact (mix and match per key).
- Keep welcome emails but disable password-recovery mail when a bulk-import provisions many accounts.
- Prevent activation and password emails during a large migration or bulk user creation, then re-enable them afterward.
- Manage all suppression from the familiar Account settings screen instead of a separate admin page.
- Roll settings across environments as configuration (the schema-backed `disable_account_emails.settings` object exports/imports cleanly).
- Re-enable any email later simply by unchecking its box and saving.
- Temporarily disable all nine email types on a site that handles every user communication externally.
- Leave third-party and custom-module emails untouched — only core `user`-module mail is affected.
- Cleanly remove all module configuration by uninstalling (no manual cleanup needed).
