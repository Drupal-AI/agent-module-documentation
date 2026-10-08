Email confirmer user applies the Email confirmer service to user accounts: when a user changes their email address the new address must be confirmed via a signed link before it takes effect, and existing verified addresses are synced into the confirmed-email database on first login / one-time login.

---

The submodule wires `email_confirmer` into user account events (all logic in `email_confirmer_user.module`). On `hook_ENTITY_TYPE_presave` for a user whose email changed: unless the actor holds `email confirmer user bypass email change`, it stashes the new address in `user.data` (key `email_change_new_address`), reverts the user's stored email to the old one, and launches a `private` confirmation in realm `email_confirmer_user` whose confirm-response URL is the user's edit form; optionally it notifies the current address. When that confirmation is confirmed, `hook_email_confirmer('confirm', …)` sets the user's email to the pending address (guarding against duplicate emails and against re-triggering the confirmation loop via a `drupal_static` flag). If the new address had already been confirmed before (optionally limited to the module's own realm), the change is accepted immediately. It also alters the user form to show a "pending change / resend / cancel" message with links, adds a `/user/{user}/email-change/cancel` route (access via a custom `_email_confirmer_user_email_pending_change` check that requires the target to have a pending change and the current user to have update access to that account), and on `hook_user_login` records a confirmed confirmation for brand-new accounts on first access or for users arriving through a one-time login link (so core's own verification is reflected in the database). Settings live at `/admin/config/system/email-confirmer/user` (`administer site configuration`).

---

- Require email re-confirmation whenever a user edits their account email address.
- Keep the user's current (old) email active until the new address is confirmed.
- Let a privileged role change a user's email without confirmation (bypass permission).
- Accept a new email immediately if that address was already confirmed for the user.
- Notify the user's current address that an email-change request was made.
- Show a "pending confirmation" notice with resend/cancel links on the user edit form.
- Let users cancel a pending email change via `/user/{user}/email-change/cancel`.
- Let users resend the confirmation email for a pending change.
- Sync core's registration email verification into the confirmed-email database on first login.
- Record a confirmed address when a user logs in via a one-time (password reset) link.
- Prevent an attacker who changed the form email from taking over an address they don't control.
- Keep a single site-wide record of confirmed addresses shared with other email_confirmer realms.
- Reject a pending change if the target address is already taken by another account.
- Scope "already confirmed" checks to the module's own realm (optional `limit_user_realm`).
- Log a warning when a user rejects (cancels) a requested email change from the new address.
- Configure which login events (new account, one-time link) trigger confirmation sync.
