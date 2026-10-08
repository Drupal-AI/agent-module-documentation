<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Request adds a request→approve workflow for users to be granted roles.

---

Role Request allows users (with `request role`) to request one or more roles, and a role manager (with `administer role requests`) to approve or deny each request; on approval the requested roles are granted to the requester. It provides a self-service role-onboarding workflow.

The request form offers roles to request (anonymous/authenticated are excluded), and approval — gated by `administer role requests` — grants the requested roles via `$user->addRole()`. Keep privileged roles out of the requestable list and give `administer role requests` only to trusted administrators. Depends on core `user`; requires Drupal 11.

---

- Let users request roles.
- Configure an approver.
- Approve/deny requests.
- Grant roles on approval.
- Provide self-service role onboarding.
- Gate requesting with `request role`.
- Gate approval with `administer role requests`.
- Grant via `$user->addRole()`.
- Treat `administer role requests` as full-admin-equivalent.
- Depend on core `user`.
- Require Drupal 11.
- Manage role requests.
- Support onboarding.
- Restrict privileged roles from request
- Approve role grants
