<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User bundle adds configurable account types (bundles) for user entities, letting a site define distinct user types with their own fields and form/display configuration.

---

User bundle brings entity bundles to user accounts. Core Drupal users are a single-bundle entity;
this module lets you define multiple user account types (bundles), each of which can carry its own
fields, form modes and display modes — so, for example, "Member", "Vendor" and "Staff" accounts can
have different field sets while remaining Drupal users. It depends on core User.

Use it when different classes of user need genuinely different data structures rather than one
flattened set of fields. Note the important boundary: bundles organise *fields and display*, not
permissions — access control for users still comes from roles and permissions, not from the bundle.
Adding a bundle does not by itself restrict what those users can do. Treat user bundles as a
content-modelling tool for user data, and keep using roles for access.

---

- Define configurable user account types.
- Give user accounts distinct bundles.
- Add per-bundle fields to users.
- Configure form/display modes per user type.
- Model Member/Vendor/Staff account types.
- Depend on core User.
- Structure different user data sets.
- Keep roles for access, bundles for fields.
- Separate user types by data model.
- Add bundle-specific fields.
- Organise user fields by type.
- Avoid one flat field set for all users.
- Understand bundles are not permissions.
- Use roles for access control.
- Configure user displays per bundle.
- Create typed user accounts.
- Attach fields to a user bundle.
- Manage user form modes per type.
- Extend the user entity with bundles.
- Treat as user content modelling.
