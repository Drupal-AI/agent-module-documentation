<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Designated Proxy User (dpxu) supports scenarios where one person administers accounts on behalf of others — e.g. a carer, guardian or coordinator managing several member logins.

---

It defines paired roles: `dpxu_manager` (the person in charge) and `dpxu_managed` (accounts they look after, linked via a `field_dpxu_manager_uid` reference). A manager can create managed accounts at `/user/add/managed-user` (up to a configurable per-manager cap) and edit their own managed users at `/user/{manager}/edit/managed-user/{user}`. Managed accounts may have no real email; the module can generate a placeholder `@no-mail.invalid` address and can intercept/reroute system emails (e.g. password resets) to the manager instead, stripping one-time-login links before forwarding. Managed users can send their manager a message via a contact form. A settings form configures the cap, message templates, email interception and placeholder generation.

Access is enforced at two layers: routes carry permissions (`create dpxu users`, `edit dpxu users`, `administer dpxu configuration`, etc.), and the service additionally verifies ownership — `getManagedUserEditForm()` checks the current user is the named manager and is actually the manager of the target account (or has `administer users`), redirecting otherwise, so a manager cannot edit accounts they do not own. The manager-UID field is edit-protected via `hook_entity_field_access`. Note managed-user password reset and other flows depend on email interception being configured correctly. Setup: enable, assign the `dpxu_manager` role, set the cap and templates on the settings form, and create managed users.

---
- Let a coordinator create login accounts for people they support.
- Cap how many managed accounts each manager may create.
- Edit a managed user's account as their designated manager.
- Reroute system emails for managed users to their manager.
- Strip one-time-login links from intercepted emails.
- Generate placeholder emails for accounts without a real address.
- Let a managed user message their manager via a contact form.
- Flag a manager (via tempstore) that a managed user made contact.
- Protect the manager-UID field from edits by non-privileged users.
- Restrict manager configuration to `administer dpxu configuration`.
- List a manager's managed users in a dedicated view.
- Disable new managed-account creation without uninstalling.
- Customize the manager notification/contact email templates.
- Set a fallback email for unassigned managed users.
- Anonymize account emails for privacy-sensitive members.
- Prevent managers editing accounts they do not manage.
- Grant `administer users` holders broader managed-account edit.
- Provide a "New Managed User" link in the managed-users view.
- Handle password-reset requests through the manager.
- Support guardianship/carer account models on a Drupal site.
