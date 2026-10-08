<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform User Registration provides a Webform handler that creates a Drupal user account upon submission, with admin-configured roles and optional email verification.

---

Webform User Registration provides a Webform handler that creates a Drupal user account when a
webform is submitted — mapping submitted fields to the new user's properties and assigning
administrator-configured roles (`selected_roles`), with optional email-verification messaging. It lets
site builders turn any webform into a registration flow (event signup that creates an account, custom
registration forms) without code. It depends on the Webform module.

**Security caveat — the created account receives the roles the handler is configured with.** Those
roles are chosen by the administrator configuring the handler, not by the submitter, so the control is
sound *as long as the configured roles are appropriate*: because a webform can be public (anonymous),
whatever role the handler assigns is effectively granted to anyone who submits that form. **Never
configure the handler to assign privileged roles on a publicly-submittable webform**, and confirm the
created account's active/blocked state and any email-verification step match your intent (so accounts
aren't auto-activated with elevated access). Used with a non-privileged role (e.g. authenticated), it is
a convenient registration mechanism. It validates that at least one role is selected.

---

- Create a user on webform submission.
- Turn a webform into a registration flow.
- Map submitted fields to user properties.
- Assign admin-configured roles to new users.
- Add optional email verification.
- Depend on the Webform module.
- Build event-signup account creation.
- Create custom registration forms.
- Never assign privileged roles on public forms.
- Confirm the account's active/blocked state.
- Match verification to intent.
- Avoid auto-activating elevated access.
- Use a non-privileged role (e.g. authenticated).
- Validate at least one role is selected.
- Configure the handler on a webform.
- Register users without code.
- Understand roles apply to any submitter.
- Gate registration appropriately.
- Handle field-to-user mapping.
- Treat public-form registration carefully.
