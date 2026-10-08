# Password Policy for User Registration Password — agent index

Glue submodule: keeps Password Policy's table visibility and validation correct when the
**User Registration Password** (`user_registrationpassword`) module lets users pick a password at
self-registration. No config, permissions, controllers, or routes — just an event subscriber. Depends on
`password_policy_extras` + `user_registrationpassword`.

How it works
(`src/EventSubscriber/PasswordPolicyUserPasswordRegistrationEventSubscriber.php`, extends the parent's
`PasswordPolicyExtrasEventSubscriber`, priority 900):
- Reads `user_registrationpassword.settings:registration`; sets `verify_email_before_password = (mode ===
  'default')` in both `skipVisibility` (CHECK_VISIBILITY) and `skipValidation` (CHECK_VALIDATION) —
  so the policy table shows / validation runs during registration only when a password is chosen then.
- For anonymous registrants, appends the `authenticated` role to `user_roles` so role-targeted policies
  match the account-to-be.

Parent reference: [api/events.md](../../../../4.0.x/agent/api/events.md) for the events and their parameters.
