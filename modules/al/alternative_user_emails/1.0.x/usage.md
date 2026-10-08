Store one or more alternative email addresses on each user account alongside the primary mail field, and make user lookups by email match those alternatives too.

---

Alternative User Emails adds a single unlimited-cardinality base field, `alternative_user_emails`, to the core user entity. Its purpose is to stop the same real person from ending up with several accounts just because they use several email addresses. Three behaviours make this work together: when an account's primary email is changed, the previous primary is automatically stored as an alternative (`hook_user_presave`); user entity queries that filter on the `mail` field are transparently expanded to also match the `alternative_user_emails` field (`hook_entity_query_user_alter`), so anything that resolves an account from an email address — for example a "sign in / reset password by email" flow — will find the account by an alternative address as well; and a uniqueness validator (which also replaces core's `UserMailUnique` constraint) guarantees that no email — primary or alternative — is ever shared by two accounts. There is no configuration UI, no permission, no route, and no service of its own; the module is purely a base field plus hooks plus a validation constraint. The field is hidden on the user form and view by default, so you decide whether and how it is exposed (the README suggests the Read-only Field Widget module to display it without allowing edits).

---

- Prevent duplicate user accounts for people who sign up with more than one email address.
- Keep a historical record of every email address an account has ever used as its primary.
- Let helpdesk staff find "the same person" when they contact you from a different address than the one on file.
- Automatically retain a user's old email as an alternative when they update their primary address, with no manual step.
- Make `user_load_by_mail()` and equivalent entity queries resolve an account from any of its addresses, not just the current primary.
- Support "log in with email" or "reset password by email" contrib flows against a user's older/secondary addresses.
- Enforce site-wide email uniqueness across both primary and alternative addresses so two accounts can never claim the same address.
- Replace core's single-field `UserMailUnique` check with one that considers the extra field, closing the gap that would otherwise let an alternative collide with someone's primary.
- Merge-and-consolidate migrations: park a decommissioned account's address on the surviving account as an alternative.
- Import legacy CRM/mailing-list data that carries several email addresses per contact into a single Drupal account.
- Give an admin a place to record a user's work and personal addresses on one account.
- Display (read-only) the list of alternative addresses on the account form using the Read-only Field Widget module.
- Query the People admin listing or a custom entity query by email and match users by any address they hold.
- Build Views or reports that filter users by email and transparently include alternatives (via the altered user query).
- Deduplicate at registration time: block a new signup whose email already exists as another account's alternative.
- Keep contact continuity when staff change employer email domains but keep the same Drupal account.
- Let a single household or shared account be reachable at multiple addresses without cloning accounts.
- Programmatically append an alternative with `$user->get('alternative_user_emails')->appendItem($email)` and save.
- Store archived addresses for audit/compliance while presenting only the current primary in the UI.
- Provide the data layer that a custom "manage my email addresses" feature can build a form on top of.
- Avoid orphaned password-reset failures when a user has forgotten which address is currently primary.
