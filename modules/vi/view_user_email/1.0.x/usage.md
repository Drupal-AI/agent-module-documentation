<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View User Email adds a single permission that lets chosen roles see other users' email addresses, filling the gap between "cannot see any address" and the heavyweight `administer users` grant.

---

By default Drupal shows a user's `mail` field only to that user and to holders of `administer users`. This module supplies the missing middle: the whole implementation is `view_user_email_entity_field_access()` in `view_user_email.module`, which returns `AccessResult::allowed()` for the `view` operation on the `mail` field when the account holds the `access email field` permission, and `AccessResult::neutral()` otherwise. The permission is declared with `restrict access: TRUE`. Because the grant is enforced at the entity field-access layer, it applies uniformly across the profile display, Views, and REST / JSON:API output rather than in one place. It has no routes, no configuration, and no dependencies beyond core (`^8 || ^9 || ^10 || ^11`). The permission is all-or-nothing: it covers every account's address, with no scoping to a role, group, or subset. Note that Drupal 9.2 added an equivalent `view user email addresses` permission to core, so the module is intended only for 8.x, 9.0, and 9.1 sites.

---

- Let a membership secretary see member email addresses.
- Give support staff contact details without user-admin rights.
- Show the email field on user profiles to a specific role.
- Avoid granting `administer users` just to read an address.
- Let event organisers contact registrants.
- Expose the mail field in a Views listing to a chosen role.
- Reduce the number of full user administrators.
- Support a volunteer coordinator role.
- Give a moderator contact details for follow-up.
- Meet an operational need without over-granting.
- Show email addresses on a members directory.
- Let a sales role see registered users' emails.
- Keep account editing separate from contact access.
- Delegate outreach without delegating account control.
- Provide addresses for a mailing export to one role.
- Track which roles hold the email-view permission.
- Support a small team with split responsibilities.
- Replace a custom `hook_entity_field_access()` implementation.
- Include the mail field in a REST or JSON:API response for a chosen role.
- Grant contact visibility on Drupal 8.x / 9.0 / 9.1 where core lacks the permission.
