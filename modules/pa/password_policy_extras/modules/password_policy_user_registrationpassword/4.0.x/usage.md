A glue submodule of Password Policy Extras that makes Password Policy validate and display correctly when the User Registration Password module lets users choose their own password during self-registration.

---

The User Registration Password (`user_registrationpassword`) module adds password fields to the registration form and offers a "verify email before password" registration mode. This submodule keeps Password Policy in step with that behavior by subscribing to Password Policy Extras' `CHECK_VISIBILITY` and `CHECK_VALIDATION` events (its subscriber extends the parent `PasswordPolicyExtrasEventSubscriber`, at priority 900). Both callbacks read `user_registrationpassword.settings:registration`: `verify_email_before_password` is set to true only when the registration mode is `default` (i.e. the standard verify-email-first flow), so the policy status table is shown and validation runs during registration only when the user is actually choosing a password at that step. For anonymous registrants it also appends the `authenticated` role to the roles checked, because policies target authenticated users that the new account will become. There is no configuration, permissions, controller, or route — just the event subscriber wired in `services.yml`. Depends on `password_policy_extras` and `user_registrationpassword`.

---

- Show the password policy status table on the User Registration Password registration form.
- Validate a self-chosen registration password against the active password policies.
- Respect the module's "verify email before password" registration mode when deciding to validate.
- Only enforce the policy at registration when the user is actually setting a password then.
- Match policies against the `authenticated` role for anonymous registrants.
- Give new users live password strength feedback during account creation.
- Keep Password Policy behavior consistent across registration and normal user-edit forms.
- Avoid showing an irrelevant policy table when password entry is deferred until after email verification.
- Enforce strong passwords at account creation on sites using User Registration Password.
- Integrate two contrib modules without custom code via the parent's event system.
- Support registration flows where the password is chosen up front vs. after verification.
- Provide a seamless, policy-compliant self-registration experience.
- Reuse Password Policy Extras' AJAX status-table libraries on the registration form.
- Drive visibility and validation entirely from the `registration` mode config value.
- Avoid running policy validation prematurely on verify-email-first registrations.
- Keep role-targeted policies effective for accounts that are anonymous at submit time.
- Let administrators tune the registration password UX via the parent module's settings.
