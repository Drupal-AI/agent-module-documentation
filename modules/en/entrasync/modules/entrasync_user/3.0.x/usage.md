Adds the "user" storage option to EntraSync, provisioning each Microsoft Entra user as a Drupal user account.

---

EntraSync User Storage is a submodule of EntraSync that ships the `user` storage plugin. When a sync configuration selects "User" as its storage type, each Entra user fetched from the tenant is turned into (or matched to) a Drupal user account. Accounts are matched by e-mail; new ones are created with a generated password, the username taken from a chosen Entra property, and the active/blocked state, mapped custom fields and roles set from the sync configuration. Roles are added additively (never stripped on later syncs), admin roles are only assignable by editors who hold the core "administer permissions" permission, and previously stored admin roles are preserved when a lesser editor edits the sync. If the Entra account is disabled, the Drupal account is blocked. Optionally the core "account created by an administrator" welcome e-mail is sent when a new active account is created. This submodule only provides the plugin and its form; all fetching, queueing and scheduling belong to the base module.

---

- Turn a Microsoft Entra ID / Azure AD tenant's users into Drupal user accounts automatically.
- Match imported users to existing Drupal accounts by e-mail address to avoid duplicates.
- Create new accounts with a securely generated password and a username from a chosen Entra property.
- Map Entra properties (department, job title, phone, etc.) onto custom user fields.
- Assign one or more roles to imported accounts as part of provisioning.
- Restrict who can grant admin roles by requiring the core "administer permissions" permission.
- Preserve admin roles already configured when a non-privileged editor edits the sync.
- Create accounts active or blocked depending on the sync's default state setting.
- Automatically block the Drupal account when the matching Entra account is disabled.
- Send the core welcome e-mail to new users created in an active state.
- Onboard new employees as Drupal accounts as they are added to the corporate tenant.
- Combine with OpenID Connect so provisioned users can sign in with their Entra identity.
- Keep account profile fields in step with the tenant on each scheduled sync.
- Skip Entra users who have no e-mail address (logged and reported) rather than creating broken accounts.
- Build a role-segmented user base by pairing per-department filters with different role assignments.
- Manage several tenants' user accounts by giving each sync its own Graph key and user mapping.
