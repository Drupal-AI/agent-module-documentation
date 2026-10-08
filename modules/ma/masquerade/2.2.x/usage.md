Masquerade lets privileged users temporarily switch into another user's account ("become" that user) and then switch back to their own, without knowing the target's password.

---

Masquerade adds a safe, permission-gated way for administrators and support staff to impersonate other accounts so they can see the site exactly as that user does. Access is controlled by two static permissions (`masquerade as any user except super user`, `masquerade as super user`) plus a dynamically generated per-role permission (`masquerade as <role>`) for every role, so you can grant "become an editor" without granting "become an admin". Users switch via the `/masquerade` form (also available as a "Masquerade" block), a "Masquerade" tab/link on a user's profile (`/user/{user}/masquerade`), and switch back through `/unmasquerade` or an account-menu "Unmasquerade" link. Switching regenerates the session ID (guarding against fixation), fires the normal `user_logout`/`user_login` hooks, and records the impersonation in the log. A session cache context (`session.is_masquerading`) and a `_user_is_masquerading` route requirement let other code react to the masquerading state. Modules can veto or grant a particular impersonation with `hook_masquerade_access()`, and the `masquerade` service (`switchTo()`, `switchBack()`, `isMasquerading()`) exposes the behavior to code. Its only settings are an optional block "show unmasquerade link" checkbox and a `update_user_last_access` config flag.

---

- Debug a bug that only one specific user can reproduce by seeing the site as them.
- Provide customer support by viewing a member's account exactly as they see it.
- Verify that role-based permissions grant the access you intended.
- Test that a newly created role sees the correct menus and content.
- Check how content, blocks, or views appear to an anonymous-adjacent low-privilege role.
- Confirm a paywall or members-only section is hidden from the right users.
- Reproduce a "I can't access X" support ticket without asking for the user's password.
- QA an editorial workflow from the perspective of an author vs. an editor.
- Grant support staff the ability to impersonate editors but never administrators.
- Explicitly gate impersonating the super user (UID 1) behind its own permission.
- Let a helpdesk role masquerade only as a specific "customer" role.
- Add a "Masquerade" block to a sidebar for quick user switching during testing.
- Place an "Unmasquerade / Switch back" link in the account menu.
- Switch into a user directly from a "Masquerade" tab on their profile page.
- Audit who impersonated whom via the logged masquerade messages.
- Preview a decoupled/personalized experience as a particular account.
- Demonstrate different role experiences during a client demo.
- Validate that commerce discounts or pricing show correctly for a customer role.
- Confirm email/notification settings behave for a given user before go-live.
- React to masquerading state in custom code via the `session.is_masquerading` cache context.
- Deny impersonation of certain sensitive accounts with `hook_masquerade_access()`.
- Trigger the user switch programmatically from custom code via the `masquerade` service.
- Restrict a route to only render while masquerading using `_user_is_masquerading`.
- Optionally keep the target user's "last access" time from updating during impersonation.
- Train new staff by letting them safely explore lower-privilege accounts.
