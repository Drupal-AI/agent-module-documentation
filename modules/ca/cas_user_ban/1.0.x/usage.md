<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CAS User Ban prevents the creation of Drupal accounts for banned CAS usernames.

---

CAS User Ban maintains a deny-list of CAS (Central Authentication Service) usernames and blocks the automatic
provisioning of a Drupal account for any username on that list when it authenticates via CAS. It depends on the CAS
module and enforces the ban by subscribing to CAS's pre-register event: when a banned username attempts a first-time
CAS login, automatic registration is cancelled and a warning is logged. The module adds a ban checkbox to Drupal's
user-cancel forms (single and multiple), so an admin can delete and ban an account in one step, and it also validates
CAS's "bulk add users" form so banned usernames cannot be re-added. Banned usernames are stored in a dedicated
`cas_user_ban` database table and administered from a page under People. An optional submodule, cas_user_ban_vbo,
adds the same ban option to a Views Bulk Operations user-cancel action. Note: the ban only blocks account
(re-)creation — it does not block login for an already-existing account whose CAS username is banned.

---

- Prevent CAS single-sign-on from auto-creating a Drupal account for a specific CAS username.
- Delete a spam or abusive user account and, in the same step, ban its CAS username so it cannot be recreated.
- Maintain a curated deny-list of CAS usernames that must never receive a Drupal account.
- Ban several CAS usernames at once by pasting them (one per line) into the "CAS ban users" form.
- Ban multiple existing accounts at once from the "Cancel accounts" (user multiple cancel) confirm form.
- View all currently banned CAS usernames and the date each was banned, at /admin/people/cas/banned-users-list.
- Remove (unblock) a ban via a modal confirmation dialog from the banned-users list.
- Stop a previously deleted CAS user from regenerating their account on next login.
- Prevent re-adding a banned username through CAS's own "Bulk add CAS users" administrative form.
- Log an audit warning whenever a banned username attempts to register via CAS.
- Log a notice whenever a ban is added or removed.
- Keep abusive identities blocked at the identity-provider-username level rather than per Drupal account.
- Restrict all ban management (list, add, remove) to administrators holding the "administer users" permission.
- Integrate the ban option into a Views Bulk Operations user-cancel action via the cas_user_ban_vbo submodule.
- Choose which user-cancel methods expose the ban option (reassign / delete by default).
- Let other modules alter the allowed cancel methods for banning via the FilterUserCancelMethodEvent.
- Add ban support to a custom user-cancel form or action by reusing the UserCancelFormsTrait.
- Programmatically ban, unban, or test a CAS username via the CasUserBanManager service.
- Ensure a user cannot ban their own CAS account through the cancel forms or VBO action.
- Warn admins when a banned username still has a linked Drupal account (so login is not automatically blocked).
- Combine account deletion, content removal, and ban to fully retire an abusive CAS identity.
- Paginate through a long ban list (20 rows per page) on the administration page.
