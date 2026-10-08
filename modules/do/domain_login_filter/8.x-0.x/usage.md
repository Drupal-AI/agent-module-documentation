<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Login Filter blocks users from logging in on a Domain (Domain Access) they are not assigned to, on a multi-domain Drupal site.

---

Domain Login Filter (`domain_login_filter`) is a tiny, single-`.module` add-on for the Domain / Domain Access ecosystem. It implements `hook_form_alter()` to inject a validation handler (`_domain_login_filter_domain_check`) onto the core login form (`user_login_form`) and the password-reset-request form (`user_pass`). At validation time the handler loads the account by the typed username or email, reads its Domain Access assignments via the `domain_access.manager` service (`getAccessValues()`), reads the current request's active domain via the `domain.negotiator` service, and — if the active domain is not among the user's assigned domains — sets a form error so the login form submission does not complete. User 1 (the superuser) and unknown usernames are skipped. The module has no settings form, no permissions, no routes, no services and no config of its own; its behaviour is driven entirely by each user's Domain Access assignments. It declares a dependency on `domain` and, in practice, needs the `domain_access` submodule enabled (it calls the `domain_access.manager` service). Package: Domain. Not covered by Drupal's security advisory policy; the documented release is a release candidate (8.x-0.1-rc4).

---

- Restrict interactive login so a user can only sign in on the domain(s) they are assigned to in Domain Access.
- Run one Drupal codebase across several hostnames while keeping each site's user sign-in scoped per domain.
- Give per-domain editorial teams a login that only works on their own domain.
- Prevent an account created for affiliate site A from logging in through affiliate site B's login form.
- Block a user from requesting a password reset email on a domain they are not assigned to.
- Show a clear "not activated / blocked on this domain" message when a user tries to log in on the wrong domain.
- Keep the superuser (user 1) able to log in on every domain regardless of assignments.
- Let a user assigned to multiple domains log in on any of those domains.
- Manage all of this purely through each user's existing Domain Access assignments — no extra config screen.
- Add per-domain login scoping to an existing Domain Access site without writing custom code.
- Enforce the restriction against both the username field and the email field on the login form.
- Complement Domain Access content grants (which control what each domain shows) with a matching login-side control.
- Enable it on install and have it take effect immediately, with no configuration step.
- Adjust who can log in where simply by changing users' domain assignments.
- Combine it with Domain Access's per-user assignment UI to onboard/offboard users per domain.
- Use it on staging to model a production multi-domain login policy before go-live.
