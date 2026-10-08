# email_registration_username — agent start

Submodule of **email_registration**. Makes the username the user's **full email address** (not just
the part before `@`) and keeps username↔email in sync; adds a **display-name override** to reduce
the email-disclosure risk. Requires `email_registration` and `token`. Config lives on the core
**Account settings** form (`entity.user.admin_form`, `/admin/config/people/accounts`). No own
permissions.

- Display-name override settings (`username_display_override_mode`, `username_display_custom`) and
  the swapped bulk action → [configure/email_registration_username.md](configure/email_registration_username.md)
- How it hooks username generation, sync, and display (`hook_email_registration_name_alter`,
  `hook_user_format_name_alter`) → [hooks/email_registration_username.md](hooks/email_registration_username.md)
- Parent module → [../../../../2.0.x/agent/start.md](../../../../2.0.x/agent/start.md)
