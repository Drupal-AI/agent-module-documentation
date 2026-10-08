<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple CRM (decoupled_auth_crm) is a submodule of Decoupled User Authentication that wires up a basic CRM setup on top of login-less users.

---

`decoupled_auth_crm` ships no PHP logic of its own (its `.module` file is an empty stub). It is a
dependency-and-config bundle: enabling it pulls in `decoupled_auth` plus `profile`, `address`,
`datetime`, `options` and `image`, so that decoupled (login-less) Drupal users can hold rich contact
data through Profile entities and Address fields. It provides an optional `simple_crm_users` view
("Simple CRM Users", base table `users_field_data`, gated by the `access user profiles` permission)
for browsing contacts as a CRM-style people list. Use it as a quick starting point for treating Drupal
as a lightweight CRM, then extend the profile types, fields and view to fit your data model.

---

- Stand up a basic CRM on Drupal using decoupled (login-less) users as contacts.
- Pull in Profile, Address, Datetime, Options and Image as one dependency bundle.
- Store contact details on users via Profile entities without giving them logins.
- Browse contacts through the bundled "Simple CRM Users" view.
- Restrict the CRM contact list with the `access user profiles` permission.
- Use it as a scaffold to extend with custom profile types and fields.
- Capture addresses on contacts via the Address module.
- Manage leads or supporters as first-class user records.
- Combine CRM contacts with newsletter/subscriber workflows.
- Provide a config-only starting point (no custom code to maintain).
