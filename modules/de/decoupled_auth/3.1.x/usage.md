<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Decoupled User Authentication lets Drupal `user` entities exist without a username or password ("decoupled" users), so you can store people as first-class users without giving them a login.

---

The module swaps the core `user` entity class for `DecoupledAuthUser`, makes the `name` (username) column nullable, and relaxes the username/password/email required and unique constraints so a user can exist in a "decoupled" state — no `name`, no `pass`, and therefore no ability to authenticate. Coupled users behave exactly like normal Drupal accounts; decoupled users are records you can attach profiles, roles, newsletter subscriptions and other user-keyed data to. An `AcquisitionService` (service `decoupled_auth.acquisition`) finds an existing user by arbitrary field values and either returns it or creates a new one, with configurable behaviour flags and `decoupled_auth.pre_acquire`/`decoupled_auth.post_acquire` events for altering the match. On the registration form it can optionally "acquire" (link the registrant to) a matching decoupled user by email, copying that record's fields and roles onto the new account. A settings form at `admin/config/people/decoupled-auth` controls acquisition behaviour, protected roles (excluded from acquisition; default `administrator`), and per-role email-uniqueness modes. It integrates with the Profile module (exposing each profile type as a user base field), Simplenews, Email Registration and User Registration Password. A bundled `decoupled_auth_crm` submodule wires up a simple CRM setup. Views ships a "Has web account?" field/filter for the people list.

---

- Store site visitors, contacts or leads as Drupal users without creating login accounts.
- Use Drupal as a lightweight CRM by attaching Profile entities to login-less users.
- Let Commerce/checkout capture an email as a user record without forcing registration.
- Keep Simplenews newsletter subscribers as real users without giving them logins.
- Create a user via the API in a decoupled state (`$user->decouple()`), then couple it later.
- Promote a decoupled record to a real account by setting a username/password (`->couple()`).
- Look up or create a user by email (or any field) with the `decoupled_auth.acquisition` service.
- Deduplicate incoming contacts by acquiring the first match instead of creating duplicates.
- On registration, link a new account to a pre-existing decoupled contact by email address.
- Copy a matched contact's roles and profile data onto a newly registered account automatically.
- Alter or veto an acquisition attempt via the `decoupled_auth.pre_acquire` event.
- React to acquisition success/failure via the `decoupled_auth.post_acquire` event.
- Protect privileged roles (default `administrator`) from being acquired during registration.
- Allow decoupled users to share an email address with each other or with coupled users.
- Require unique emails only for coupled users, or only for decoupled users of chosen roles.
- Filter the admin People list by "Has web account?" to separate coupled from decoupled users.
- Display a decoupled user's name field gracefully (the replacement user_name formatter).
- Let admins toggle a user's "has login details" state on the user edit form.
- Show a status-report error when registration acquisitions run without email verification.
- Expose every Profile type as an unlimited-cardinality base field on the user entity.
- Support login and password-reset by email (integrates with Email Registration) for coupled users.
- Bootstrap a ready-made CRM configuration with the `decoupled_auth_crm` submodule.
- Build custom import routines that match-or-create users from external data sources.
- Migrate legacy contact databases into Drupal users without inventing fake credentials.
