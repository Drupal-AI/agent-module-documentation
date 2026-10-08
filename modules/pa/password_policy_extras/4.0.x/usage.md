Password Policy Extras enhances the Password Policy module's live validation UX — auto-refreshing the constraint status table as the user types, optionally showing only failed rules, hiding core's password suggestions, plus accessibility fixes — and adds submodules that make Password Policy work with the User Registration Password, PRLP, and Password Separate Form modules.

---

The module refines how Password Policy's constraint status table behaves on password forms. It attaches JavaScript that re-checks the password via AJAX after a configurable delay while typing, and provides admin toggles (config object `password_policy_extras.settings`, form at `/admin/config/security/password-policy/extras/settings`, gated by `administer site configuration`) to disable the AJAX throbber, display only failed rule messages instead of the full three-column table, hide Drupal core's default password suggestions, move the status display below the main password field, and show the table on password-field focus. Technically it replaces Password Policy's `password_confirm` element `#process` callback with its own (so validation works even when a user entity isn't present in form state), decorates the `password_policy.validation_manager` service with `PasswordPolicyExtrasValidationManager`, and introduces two events — `CHECK_VISIBILITY` and `CHECK_VALIDATION` — that let subscribers decide whether the status table should show and whether validation should run for the current route/user/roles. A base `PasswordPolicyExtrasEventSubscriber` supplies the default answers (respecting `user.settings:verify_mail` and the `user.reset` route). Three optional submodules extend this event system to integrate Password Policy with the `user_registrationpassword`, `prlp` (Password Reset Landing Page), and `change_pwd_page` (Password Separate Form) contrib modules. The project positions itself as a "sandbox" for Password Policy and tracks its major version.

---

- Auto-refresh the password constraint status table via AJAX as the user types.
- Set the typing debounce delay (milliseconds) before the status re-checks.
- Show only the failed password-rule messages instead of the full three-column policy table.
- Hide Drupal core's built-in password strength suggestions.
- Move the policy status display directly below the main password field.
- Reveal the status table only when the password field receives focus.
- Disable the AJAX throbber/progress indicator during status refresh.
- Improve accessibility of the password policy status feedback.
- Make Password Policy validate correctly on forms lacking a user entity in form state.
- Show live policy feedback on the user registration form.
- Integrate Password Policy with the User Registration Password module (via submodule).
- Enforce and display password policy on the Password Reset Landing Page (PRLP) form (via submodule).
- Enforce and display password policy on the Password Separate Form / change_pwd_page (via submodule).
- Validate the reset-landing-page password against the policy and reset expiration fields on save.
- Decide per-route whether the policy status table should be visible via a subscribable event.
- Decide per-route/user whether password validation should run via a subscribable event.
- Skip policy validation before email verification when core `verify_mail` is enabled.
- Provide a consistent password-policy experience across custom and contrib password forms.
- Reuse the module's status-table render helper (`_password_policy_extras_status_item`) in other modules.
- Give administrators fine-grained control over how strict/verbose the password UI feels.
