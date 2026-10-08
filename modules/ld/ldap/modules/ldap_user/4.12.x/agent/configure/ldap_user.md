# Configure LDAP user sync & provisioning

Config object: **`ldap_user.settings`** (schema in `config/schema`). Forms (all under
`/admin/config/people/ldap/user`, permission `administer ldap`):

| Route | Path | Purpose |
|---|---|---|
| `ldap_user.admin_form` | `/user` | Main settings (**the `configure` route**) |
| `ldap_user.drupal_admin_form` | `/user/drupal` | Map LDAP → Drupal (provision to Drupal) |
| `ldap_user.ldap_admin_form` | `/user/ldap` | Map Drupal → LDAP (provision to LDAP) |
| `ldap_user.test_form` | `/user/test` | Preview provisioning for one user |

## Key settings (defaults from `config/install`)

| Key | Default | Meaning |
|---|---|---|
| `drupalAcctProvisionServer` | `'0'` | Server used to provision Drupal accounts from LDAP (`0` = none) |
| `ldapEntryProvisionServer` | `'0'` | Server used to provision LDAP entries from Drupal |
| `drupalAcctProvisionTriggers` | `drupal_on_login`, `drupal_on_update_create` (off) | When to create/update Drupal accounts |
| `ldapEntryProvisionTriggers` | `ldap_on_update_create`, `ldap_on_login`, `ldap_on_delete`, `drupal_on_manual_creation` (off) | When to create/update/delete LDAP entries |
| `ldapUserSyncMappings` | `{}` | The per-field, per-direction, per-event map |
| `userConflictResolve` | `resolve` | How to handle an existing account with the same name/email |
| `manualAccountConflict` | `conflict_reject` | Behaviour when an admin manually creates a conflicting account |
| `acctCreation` | `ldap_behavior` | Account-creation policy (follow LDAP vs Drupal defaults) |
| `orphanedDrupalAcctBehavior` | `ldap_user_orphan_email` | What to do with accounts whose LDAP entry is gone |
| `orphanedCheckQty` | `100` | How many accounts the orphan check processes per run |
| `orphanedAccountCheckInterval` | `weekly` | How often to run the orphan check |
| `orphanedIncludeDisabledUsers` | `false` | Include already-disabled users in the orphan check |
| `userUpdateCronQuery` | `none` | Stored LDAP query used to bulk-update users on cron |
| `userUpdateCronInterval` | `daily` | How often the cron update query runs |

Field mappings are edited on the two mapping forms; `ldap_user.field_provider`
(`FieldProvider`) enumerates the available Drupal targets (extendable via
`hook_ldap_user_attributes_alter()`). Everything is config, so it exports with
`drush config:export`.
