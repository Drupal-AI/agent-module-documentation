Generate Password (genpass) makes the password field optional or hidden on the admin "Add user" and user-registration forms, generating a strong random password when none is supplied. It can optionally display that password once, at creation time.

---

Genpass decorates Drupal core's `password_generator` service with `GenpassPasswordGenerator`, a stronger generator that draws from four character classes (lower, upper, digits, and an expanded special-character set) and guarantees at least one character from each, at a configurable length (5–32, default 12). All settings live in `genpass.settings` and are edited on the core Account settings form (`/admin/config/people/accounts`, route `entity.user.admin_form`), which the module alters to add three sections: registration behavior, generation parameters, and core-service replacement. `genpass_mode` controls whether users must, may, or cannot type their own password at registration; `genpass_admin_mode` controls whether admins may set passwords when creating/editing accounts; `genpass_display` controls whether the generated password is shown to the admin, the user, both, or nobody. A `GenpassMode` validation constraint interlocks these settings with core's "Require email verification" (`user.settings:verify_mail`) so incompatible combinations are rejected. It ships a "Set new random password" user bulk action and invites three alter hooks (`hook_genpass_user_forms`, `hook_genpass_user_forms_alter`, `hook_genpass_character_sets_alter`). It requires only core `user` and helps meet PCI DSS requirement 8.2.6.

---

- Auto-generate a strong password when an admin creates a user without typing one.
- Let visitors register without choosing a password, generating one for them.
- Force generated-only passwords at registration (`genpass_mode` = restricted).
- Make the registration password field optional rather than required.
- Hide the password field from admins on the user create/edit form.
- Display the generated password once to the admin who created the account.
- Display the generated password once to the user who just registered.
- Increase generated password length up to 32 characters for stronger security.
- Replace core's `DefaultPasswordGenerator` site-wide with the stronger Genpass generator.
- Guarantee every generated password contains upper, lower, digit, and special characters.
- Exclude confusable characters (0/O, 1/I/l, `` ` ``, `|`) from generated passwords.
- Reset one or many users' passwords in bulk via the "Set new random password" action.
- Show each user's newly generated password to the admin after a bulk reset.
- Meet PCI DSS requirement 8.2.6 for system-generated first-use passwords.
- Interlock password mode with core "Require email verification" to avoid invalid setups.
- Generate a strong password from code by calling the `password_generator` service.
- Request a specific password length programmatically via `generate($length)`.
- Add custom character classes to generated passwords via `hook_genpass_character_sets_alter`.
- Apply Genpass password handling to extra user forms via `hook_genpass_user_forms`.
- Adjust which forms Genpass alters via `hook_genpass_user_forms_alter`.
- Keep core's default generator but still control generated length by disabling the override.
- Provision accounts in bulk (e.g. imports) with strong auto-generated passwords.
- Avoid emailing admin-chosen passwords by generating and displaying them instead.
- Standardize password strength across admin-created and self-registered accounts.
