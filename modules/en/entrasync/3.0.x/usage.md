Imports and keeps in sync the users of a Microsoft Entra ID (Azure AD) tenant as Drupal users or nodes, via the MS Graph API.

---

EntraSync lets a site connect to one or more Microsoft Entra ID tenants through the Microsoft Graph API and provision the tenant's users into Drupal. Each import is a configuration entity ("sync") that pairs a Graph authentication key (a Key entity supplied by the Microsoft Graph API module) with a chosen set of Entra user properties, an optional post-fetch filter, and a storage plugin that decides whether each Entra user becomes a Drupal user or a Drupal node. Fetched users are reduced to the selected properties, optionally filtered, and pushed to a Queue API queue for background processing so large tenants do not block a request. A managed-entities table records the mapping between each Entra object GUID and the Drupal entity it produced, so subsequent syncs update rather than duplicate, and can block/unpublish an entity when its account is disabled in Entra. Delta queries make the first sync collect all users and later syncs collect only new or changed users; syncs run on cron or on demand. Field, label, status, role and bundle mappings are configured per sync, and two events (`entrasync.distilled_users_alter`, `entrasync.entity_pre_save`) let other modules customise the data or the entity before save. Two shipped submodules provide the user and node storage plugins; the plugin type is extensible so other entity types can be added.

---

- Provision Drupal user accounts automatically from a Microsoft Entra ID / Azure AD tenant.
- Keep an existing user base in step with Entra, updating profile fields when they change in the tenant.
- Block a Drupal account automatically when the matching Entra account is disabled.
- Sync users from several tenants by creating one sync configuration per tenant, each with its own Graph key.
- Run different imports side by side, e.g. one that maps users to accounts and one that maps them to nodes.
- Import only a subset of the tenant by filtering on any fetched property (department, e-mail domain, job title, etc.).
- Map Entra user properties (mail, displayName, department, jobTitle, phone numbers, and more) to custom Drupal fields.
- Assign one or more roles to imported user accounts as part of provisioning.
- Choose whether imported accounts are created active or blocked.
- Send the core "account created by administrator" welcome e-mail when an account is created active.
- Build a directory of people as nodes (e.g. a staff directory) from Entra data instead of user accounts.
- Choose the target node bundle and control published/unpublished state for node imports.
- Create a new node revision whenever synced data changes, for an audit trail of directory updates.
- Reduce sync time and Graph load on large tenants by using delta queries after the initial full import.
- Force a full re-fetch of every user (delta off) after changing which properties or mappings are used.
- Schedule automatic syncs on cron so the Drupal user list stays current without manual action.
- Trigger an immediate sync from the admin UI with the per-sync "Perform Sync" operation.
- Pair with the Queue UI module to inspect and process the import queue on demand rather than only on cron.
- Combine with OpenID Connect so imported Entra users can log in with their Entra identity.
- Pick exactly which Graph properties to fetch to stay within the tenant's least-privilege Graph permissions.
- Alter or drop fetched users programmatically (e.g. exclude contractors) with the distilled-users event.
- Set derived or computed fields on the Drupal entity just before it is saved with the pre-save event.
- Extend the storage plugin type to sync Entra users into other Drupal entity types beyond user and node.
- Migrate an on-prem or manual user list to Entra-managed provisioning without rebuilding accounts by hand.
- Onboard new employees into Drupal automatically as they are added to the corporate tenant.
- Maintain a self-cleaning contributor list where deactivating someone in Entra removes their Drupal access.
