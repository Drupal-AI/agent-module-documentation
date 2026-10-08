# email_registration — agent start

Lets users register and log in with their **email address** instead of a username; core still
needs a username, so the module auto-generates one from the email (part before `@`, made unique).
Depends only on core `user`. One setting (`login_with_username`) on the core **Account settings**
form (`entity.user.admin_form`, `/admin/config/people/accounts`). Defines **no** permissions.

- Login/registration behavior, the `login_with_username` setting, the bulk "Update username"
  action → [configure/email_registration.md](configure/email_registration.md)
- Username-generation service & helper functions to call in code →
  [api/email_registration.md](api/email_registration.md)
- Customize the generated username via `hook_email_registration_name_alter()` →
  [hooks/email_registration.md](hooks/email_registration.md)
- Submodule `email_registration_username` (use the full email as the username + display-name
  override) → [../../modules/email_registration_username/2.0.x/agent/start.md](../../modules/email_registration_username/2.0.x/agent/start.md)
