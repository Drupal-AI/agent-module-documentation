A glue submodule of Password Policy Extras that makes the Password Policy live status table appear on the dedicated password-change form provided by the Password Separate Form (`change_pwd_page`) module.

---

The Password Separate Form module moves password changes to their own form (`change_pwd_form`) instead of the full user edit form, which means Password Policy's status table isn't attached there by default. This submodule implements `hook_form_change_pwd_form_alter()`: when a `user` route parameter is present and `password_policy.validation_manager->tableShouldBeVisible()` returns true, it calls the parent module's `_password_policy_extras_add_libraries_and_settings_to_form()` helper to attach the AJAX status-table libraries and settings to that form. It also uses `hook_module_implements_alter()` to ensure its `form_alter` runs after Password Policy's, and its `hook_install()` sets the module weight to 30 (so it loads after `password_policy_extras` at 20 and PRLP). No configuration, permissions, services, or routes of its own — it depends on both `password_policy_extras` and `change_pwd_page`.

---

- Show the password policy constraint status table on the Password Separate Form change-password page.
- Enable live AJAX password validation feedback on `change_pwd_form`.
- Apply the parent module's failed-only / hide-suggestions / focus display settings to the separate form.
- Keep password policy enforcement consistent when using a dedicated password-change page.
- Attach the policy status libraries only when a policy actually applies to the target user.
- Ensure hook ordering so the policy table integrates correctly after Password Policy runs.
- Let sites using `change_pwd_page` retain the enhanced Password Policy Extras UX.
- Provide password strength feedback to users changing their password on the standalone form.
- Support administrators changing another user's password via the separate form with policy feedback.
- Avoid a missing/empty status table on the separate password form.
- Reuse the parent module's AJAX status-table libraries and drupalSettings without extra code.
- Debounce live re-validation on the separate form using the parent's `status_refresh_delay` setting.
- Hide the AJAX throbber on the separate change-password form when configured in the parent.
- Ensure the separate form module loads after `password_policy_extras` (weight 30) so hooks run in order.
- Support sites that replace the core user-edit password fields with a dedicated change page.
- Attach failed-messages-only display to the standalone change-password form when enabled.
