LDAP Users maps LDAP directory entries to Drupal user accounts and fields in both directions, provisioning Drupal accounts from LDAP (and optionally LDAP entries from Drupal) on login, update, cron, or manual creation, and handling accounts whose LDAP entry has disappeared.

---

The submodule adds a mapping UI at **Admin → Config → People → LDAP → User settings**
(`/admin/config/people/ldap/user`) where you pick a provisioning server for each direction and
configure per-field mappings (LDAP attribute → Drupal property/field, or the reverse). The
`ldap_user.settings` config object stores the provisioning servers
(`drupalAcctProvisionServer`, `ldapEntryProvisionServer`), the trigger events
(`drupalAcctProvisionTriggers`: on login, on update/create; `ldapEntryProvisionTriggers`: on
update/create, on login, on delete, on manual creation), conflict resolution
(`userConflictResolve`, `manualAccountConflict`), account-creation policy (`acctCreation`), the
field map (`ldapUserSyncMappings`), and orphan handling. The workhorse service
`ldap.drupal_user_processor` (`DrupalUserProcessor`) associates, creates, updates, and excludes
Drupal accounts from LDAP data; `ldap_user.field_provider` (`FieldProvider`) enumerates the
mappable Drupal targets; `ldap.orphan_processor` (`OrphanProcessor`) finds accounts whose LDAP
entry is gone and can email or disable them; `ldap.group_user_update_processor` refreshes users
in bulk from a stored LDAP query on cron. Reverse provisioning is driven by event subscribers
(`LdapEntryProvisionSubscriber`, `LdapEntryDeletionSubscriber`). The module fires
`LdapUserLoginEvent`, `LdapNewUserCreatedEvent`, `LdapUserUpdatedEvent` and
`LdapUserDeletedEvent`, and invites `hook_ldap_user_attributes_alter()` and
`hook_ldap_user_edit_user_alter()`. It requires `ldap_servers` and `ldap_query`. A Test form
lets you preview provisioning for a single user before enabling triggers.

---

- Auto-create a Drupal account from an LDAP entry when a user first logs in.
- Refresh Drupal user fields (name, email, title, department) from LDAP on every login.
- Sync selected LDAP attributes into custom Drupal user fields.
- Provision an LDAP entry from a new or updated Drupal account (reverse sync).
- Delete or disable the LDAP entry when a Drupal account is removed.
- Map fields both directions with per-field, per-event control.
- Trigger provisioning on login, on account update/create, on manual creation, or on delete.
- Associate an existing Drupal account with its LDAP identity (by PUID).
- Choose how username/email conflicts are resolved when creating accounts.
- Set the account-creation policy (follow LDAP behaviour vs. Drupal defaults).
- Detect orphaned Drupal accounts whose LDAP entry no longer exists.
- Email an administrator (or the user) about orphaned accounts.
- Optionally disable rather than delete orphaned accounts.
- Bulk-update all LDAP users periodically from a stored LDAP query on cron.
- Tune how many accounts the orphan check processes per run and how often.
- Preview what provisioning would do for one user via the Test form.
- Exclude specific accounts from LDAP processing.
- Add or alter the list of mappable Drupal user targets from custom code (hook).
- Alter the Drupal account during sync from a custom module (hook).
- React to LDAP login/create/update/delete events with an event subscriber.
- Protect sensitive user fields from being overwritten by LDAP (field constraint).
- Keep the entire mapping and provisioning policy in exportable Drupal config.
- Generate a password for provisioned accounts automatically.
- Apply an email template when the directory lacks a mail attribute.
- Support both "LDAP authenticated" and "LDAP authorization / feed" identified users.
