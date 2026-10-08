User Created By Field records who created each user account. On install it adds a single-value entity-reference field, `field_user_created_by_field`, to the User entity (referencing another user), and on every new account it stores the acting user's id. It also defines two permissions that hide or expose the field for viewing and editing, so the "created by" information can be shown to some roles without letting them change it.

---

The module installs one configurable Field API field via `config/install`: a field storage and field instance named `field_user_created_by_field`, an `entity_reference` to the `user` entity type, cardinality 1, on the `user` bundle. It is populated automatically in `hook_user_presave` — but only when the account is new — by setting the field to the current user's id (`\Drupal::currentUser()->id()`), so an admin who creates an account is recorded as its creator, while self-registration records the acting (typically anonymous, uid 0) user. Existing values are never rewritten on later saves. Access is controlled entirely by `hook_entity_field_access`: for the `view` operation the field is allowed only with the `view user created by field` permission and otherwise forbidden, and for `edit` only with `edit user created by field` — this overrides the field's normal visibility, so without the view permission the field does not appear on the profile or in forms. The module ships no admin/config route, no Drush commands, no config schema, and no plugin types; there is only the field, the two permissions, and the presave/access hooks. To surface the value you add the field to a user view mode (Manage display) or to a View such as the People listing. On uninstall, `hook_uninstall` deletes the field storage and instance, removing the stored data.

---

- Record which administrator created each user account.
- Show the account creator on the People admin listing by adding the field to that View.
- Display "created by" on a user's profile for roles that need it.
- Let support staff view the creator without being able to change it.
- Grant a specific role permission to correct an incorrect creator value.
- Attribute bulk-imported or provisioned accounts to the operator who ran the import.
- Distinguish self-registered accounts (anonymous/uid 0) from admin-created ones.
- Build an ownership report of accounts grouped by their creator.
- Filter a user View to accounts created by a given staff member.
- Support an access review by evidencing who provisioned each account.
- Keep an ownership trail for accounts created through a custom onboarding flow.
- Reassign responsibility by editing the creator field on affected accounts.
- Hide the creator field from ordinary users while exposing it to auditors.
- Populate a creator relationship usable by Views entity-reference relationships.
- Identify the operator behind accounts created during a migration.
- Add a "Created by" column to a custom staff-management dashboard.
- Notify or route account issues to whoever created the account.
- Track delegated user creation across multiple administrators.
- Provide a queryable link from each account back to its creator user.
- Remove the field and its data cleanly by uninstalling the module.
- Expose account ownership to a downstream integration via the reference field.
- Audit who created accounts flagged during a compliance review.
- Let a manager role view but not edit the creator of accounts in their team.
- Seed a default creator on programmatically created accounts by setting current user context.
