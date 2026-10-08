Synchronizes Drupal users with Bitrix24 contacts, live on user CRUD plus batch export and import.

---

`b24_user` extends the base `b24` module to keep Drupal users and Bitrix24 contacts in sync. When
live export is enabled, creating, updating or deleting a Drupal user of a selected role creates,
updates or deletes the matching Bitrix24 contact, with field values mapped from user/profile tokens.
Two batch forms complement this: one exports existing Drupal users to Bitrix24 contacts, the other
imports Bitrix24 contacts into Drupal user accounts (matched by email or a prior reference, assigning
chosen roles). All state is tracked in the shared `b24_reference` table so records are not
duplicated. Configuration lives under `/admin/config/b24/user/*` and requires
`administer b24 configuration` (import additionally requires `administer users`).

---

- Create a Bitrix24 contact automatically when a Drupal user is created (live export).
- Update the linked Bitrix24 contact when the user changes (only when mapped values change).
- Delete the Bitrix24 contact when the Drupal user is deleted.
- Restrict live sync to users of specific roles.
- Toggle live export on/off globally.
- Map Drupal user/profile fields to Bitrix24 contact fields with tokens and custom values.
- Batch-export all (or role-filtered) existing Drupal users to Bitrix24 contacts.
- Batch-import Bitrix24 contacts into Drupal user accounts.
- Assign chosen Drupal roles to users imported from Bitrix24.
- Match imported contacts to existing users by email or a prior reference to avoid duplicates.
- Automatically pause live export during a bulk import and restore it afterwards.
- Link a contact created by b24_commerce (lead→contact conversion) back to its Drupal user (event subscriber).
- Skip re-pushing unchanged users via the `b24_reference` hash comparison.
- Keep a persistent Drupal-user ↔ Bitrix24-contact mapping for later updates.
