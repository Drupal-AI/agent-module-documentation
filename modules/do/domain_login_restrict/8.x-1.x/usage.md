<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Login Restrict lets a Domain-module multi-site limit which accounts may log in on which domain, based on each account's domain affiliation and, optionally, its roles.

---

The Domain module runs several sites from one Drupal installation with a single shared user table, and Drupal authentication is global — Domain governs *content* access, not *login*, so by default an account created for one site can sign in on every domain the installation serves. This module adds the missing check. You switch it on at **Configuration → Domain → Settings** (`/admin/config/domain/settings`) by ticking **Enable restriction** in the *Domain User: Login restrict* section; from then on a login succeeds only when the **active domain** is one of the domains listed in the account's **Domain Access** field (`field_domain_access`, shown on the user edit form). For finer control, edit an individual domain (`/admin/config/domain/edit/<id>`) and, under *Domain User: Login restrict using Role*, tick one or more roles — only accounts holding one of those roles may then log in on that domain. Two convenience options auto-populate new accounts: **Assign Domain to User** adds the current domain to a new account's Domain Access on registration, and per-domain **Assign Role to New User** grants chosen roles to accounts created on that domain. Grant the **`login to any domain`** permission (correctly marked *restrict access*) to administrator and support roles so they bypass every check; the super-user (uid 1) is never restricted. All settings are stored in Drupal **State** (not exported config), the module ships **no settings page of its own** (it borrows the Domain module's forms), and it adds one optional **Domain Login block** — a simple domain-switcher `<select>`.

---

- Stop cross-domain logins on a Domain multi-site.
- Keep brand sites' user logins separate.
- Restrict a client site's logins to its own users.
- Limit a partner-portal domain to affiliated accounts.
- Enforce domain affiliation at login time.
- Separate distinct audiences on one Drupal installation.
- Let administrators and support staff log in anywhere via `login to any domain`.
- Gate a domain's login to specific roles only.
- Auto-affiliate new registrations with the domain they signed up on.
- Auto-grant per-domain roles to new accounts.
- Support a group of country/brand sites from one install.
- Keep a staff-only domain closed to member accounts.
- Restrict logins per affiliate site.
- Enforce a tenant isolation boundary at login.
- Reduce a multi-site's login surface.
- Support a white-label / reseller deployment.
- Keep a staging or test domain closed to normal users.
- Enforce per-domain user separation.
- Meet a client-isolation requirement.
- Block password-reset requests from a domain the account is not affiliated with.
- Add a front-end domain-switcher block to a multi-site.
- Combine domain affiliation and role checks per domain.
