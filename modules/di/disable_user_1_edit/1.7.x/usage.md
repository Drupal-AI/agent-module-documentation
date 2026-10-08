<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Disable user 1 edit blocks access to Drupal's user 1 (the superuser) entity, so even accounts with "administer users" cannot edit — or otherwise access — user 1 through the entity access system.

---

The module is a single access hook. `hook_ENTITY_TYPE_access()` for the user entity
(`disable_user_1_edit_user_access`) checks whether the entity being accessed is user 1 (id `1`);
if so, and the module's protection is active, it returns `AccessResult::forbiddenIf()` guarded by a
permission that intentionally does not exist (a random `'Stare into the abyss <uniqid>'` string), so
the result is always **forbidden**. Protection is controlled by the config
`disable_user_1_edit.settings:disabled` (integer, default `0`). The semantics are inverted: when
`disabled` is empty/`0` the restriction is **active** (user 1 is locked); when `disabled` is `1` the
restriction is turned **off** (user 1 becomes editable again). This is toggled by a single "Disable
restriction" checkbox on the settings form (route `disable_user_1_edit.config_form` at
`/admin/config/people/disable_user_1_edit`, permission `administer disable user 1 edit`, which is
`restrict access: true`). Because the hook does not filter on `$operation`, the forbidden result
applies to all entity operations on user 1 (update, delete — and view), not only editing. The module
has no dependencies and ships a default config with the restriction on.

---

- Prevent any administrator from editing the superuser (user 1) account.
- Stop a compromised or over-privileged "administer users" account from changing user 1's password.
- Lock down user 1 on sites where multiple people hold the administer-users permission.
- Reduce the blast radius of a delegated admin role by protecting the root account.
- Keep user 1 immutable as a break-glass account controlled only by config/CLI.
- Block deletion of user 1 through the admin UI (the access hook covers delete too).
- Harden a multi-admin site against privilege escalation via the user 1 account.
- Enforce that user 1 changes only happen via Drush/deployment, not the UI.
- Temporarily allow editing user 1 by toggling the "Disable restriction" setting, then re-lock.
- Protect the superuser on client sites handed off to less-trusted editors.
- Satisfy a security requirement that the root account not be editable in the UI.
- Prevent accidental changes to user 1's email/roles by staff.
- Complement a policy of not using user 1 for day-to-day administration.
- Keep user 1 out of reach even for roles granted broad user administration.
- Audit-friendly: user 1 edits are impossible via UI while the module is active.
- Restore editability quickly (checkbox) when a legitimate user 1 change is needed.
- Deploy the "protected" state as config across environments.
- Guard the superuser account on a site exposed to many contributors.
- Ensure a rogue admin cannot take over the site by editing user 1.
- Gate who can even change the protection setting behind a restricted permission.
- Provide defense-in-depth alongside not granting user 1 to anyone.
- Lock the account whose id is hard-coded as the all-permissions superuser.
