Lets site visitors log in with a short per-user access code instead of a username and password, either on a dedicated login form or through a one-click auto-login link.

---

Access code provides an alternative, low-friction authentication method for Drupal user accounts. An administrator assigns each account an alphanumeric access code (up to 20 characters, optionally auto-generated) on the standard user add/edit form, with an optional expiration date. The visitor can then either type that code into the module's own login form at `/user/ac`, or follow an auto-login access link of the form `/ac/{code}` that logs them in the moment it is opened. Successful validation calls core's `user_login_finalize()`, so the visitor ends up with a normal authenticated Drupal session. Both entry points are protected by core's user flood control (per-IP failed-login limits), codes can be blocked for chosen roles, expired codes and blocked/inactive accounts are rejected, and codes must be unique across users. It is aimed at accounts that will be accessed only a few times, where setting up a full password is not worth the friction; the maintainers explicitly note it is significantly less secure than password login.

---

- Give short-lived reviewer or client accounts a single access code instead of a username/password to hand out.
- Email a one-click access link (`/ac/{code}`) that logs the recipient straight into their account.
- Onboard event or conference attendees who only need to sign in a couple of times.
- Distribute printed or verbally-communicated codes to users who struggle with passwords.
- Provide guest access to a members-only area without provisioning full credentials.
- Auto-generate a unique code (4–12 characters, numbers / letters / alphanumeric, optional prefix) per account.
- Let a chosen admin pick a memorable custom code for a specific user (requires the "administer users" permission).
- Allow users to regenerate their own random access code without being able to type an arbitrary one.
- Set codes to expire after a preset period (one day up to ten years) so temporary access is revoked automatically.
- Enforce a default expiration window on every newly created code from one settings page.
- Block whole roles (e.g. administrators, editors) from ever using access-code login for defence in depth.
- Invalidate a user's access by clearing the code field, back-dating its expiration, or blocking the account.
- Add an access-code login option alongside the normal login block via the `/user/ac` form.
- Rate-limit brute-force guessing of codes using Drupal's existing per-IP login flood configuration.
- Surface a user's current access code and expiration in tokens (`[user:access-code]`, `[user:access-code-expiration]`) for use in notification emails.
- Show the ready-made access link on the user edit form so admins can copy and share it.
- Choose whether the login field masks input (password style) or shows the typed code in clear text.
- Keep codes unique automatically so two users can never share the same code.
- Clean up a user's stored access code automatically when the account is deleted.
- Provide temporary vendor or contractor access that self-expires without manual cleanup.
- Support kiosk or shared-terminal sign-in where typing a full password is impractical.
- Give support staff a quick way to grant a customer time-boxed access to their own account.
