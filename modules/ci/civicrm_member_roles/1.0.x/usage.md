<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CiviMember Roles Sync keeps Drupal roles in step with CiviCRM membership: Association Rules map a membership type and a set of statuses to a Drupal role, and the module applies them automatically on login/logout, on cron, on membership update, and on demand.

---

Organisations running CiviCRM behind Drupal usually want "current members get the member role, lapsed members lose it" — and doing that by hand does not scale. The module models each mapping as a `civicrm_member_role_rule` config entity (labelled *Association Rule*), managed at `entity.civicrm_member_role_rule.collection` (`/admin/config/civicrm/civicrm-member-roles`) with a list builder, action links and menu entries. A rule ties a CiviCRM membership type plus the statuses that count as "add" and "removal" to a Drupal role; the `civicrm_member_roles` service then grants the role to contacts whose membership is in an add status and revokes it for removal statuses or when no membership remains. Which triggers run is chosen on the settings form (`civicrm_member_roles.settings`): synchronise on user login/logout (default), on Drupal cron (bounded by `cron_limit`), and/or when a CiviCRM membership is updated. A Manual Synchronize form and a legacy Drush command (`civicrm-member-role-sync`, alias `cmrs`) run a full batch sync on demand — handy after a bulk membership import or after adding a rule. A single permission, `access civicrm member role setting`, gates every rule and settings screen, and the whole thing depends on the `civicrm` module being installed and bootstrappable.

---

- Grant a member role to contacts with a current CiviCRM membership.
- Revoke the role automatically when a membership lapses.
- Map different membership types to different Drupal roles.
- Treat grace-period statuses as still "member" via the add-status list.
- Give lifetime members a distinct role.
- Sync on user login/logout so returning members get the right role.
- Run the sync from cron without manual work.
- Cap cron work with `cron_limit` to avoid timeouts on large member bases.
- Re-sync a contact automatically when their membership is updated in CiviCRM.
- Trigger a full sync from Drush after a membership import.
- Restrict site content to current members via a role.
- Keep discounted-pricing roles aligned with membership.
- Handle renewals without editor intervention.
- Give committee members an additional role by membership type.
- Audit which rules produce which roles on the collection page.
- Export Association Rules as configuration.
- Apply several rules (and roles) to one contact.
- Remove access promptly when a membership is cancelled or expired.
- Align Drupal permissions with CiviCRM's source of truth.
- Support multiple membership programmes on one site.
- Reduce support tickets about lost member access.
- Sync roles after migrating membership data.
- Schedule syncs at a specific time via Drush and system cron.
- Sync a single user or contact from the CLI with `--uid` / `--contact_id`.
