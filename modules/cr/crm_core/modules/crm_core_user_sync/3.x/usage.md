CRM Core User Synchronization pairs Drupal user accounts with CRM Core Individual contacts.

---

This submodule links a Drupal `user` to a `crm_core_individual` contact through a
`crm_core_user_sync_relation` content entity (one user ↔ one individual, enforced by a unique-
reference constraint). It reacts to user lifecycle hooks: on user insert (and update, when no
contact exists yet) it can auto-create a matching Individual; on user delete it removes the
relation; on individual delete it removes the relation. **Rules** map a user role to a contact
type so new users of that role get the right kind of contact, and an "auto relate" option can link
a new user to an existing contact by matching email. Settings (`/admin/config/crm-core/user-sync`)
toggle auto-create, auto-relate, loading the related contact onto the current user object per
request, and showing contact info on the user profile. A block lets a user edit their own linked
contact, and two optional Views provide user↔contact management screens.

---

- Automatically **create a contact** when a new user account is registered.
- **Link** a new user to an existing contact by matching email (auto-relate).
- Ensure every user has a corresponding contact on **user update**.
- Remove the relation automatically when a **user or contact is deleted**.
- Map a **user role → contact type** with ordered, enable-able synchronization rules.
- Manage relations as entities at `/admin/config/crm-core/user-sync/relation`.
- Enforce a **one-to-one** user/contact link via the `UniqueReference` constraint.
- Show a user's **related contact** on their profile (`contact_show` setting).
- Load the related contact onto the current user object each request (`contact_load` setting) for
  use by other code/tokens.
- Place an **"Edit own contact information"** block for self-service contact editing
  (perm `edit own contact information`).
- Provide **user-to-contact** and **contact-to-user** management Views (optional config).
- Add Views relationships/fields linking users and individuals to their relation.
- Migrate legacy relations with the `RelationLookup` migrate process plugin.
- Batch-relate existing users/contacts via `UserSyncBatch`.
- Gate all sync configuration behind `administer crm-core-user-sync`.
- Suppress auto-sync for a specific account with `$account->crm_core_no_auto_sync`.
