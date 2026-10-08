# Configuration

Configuring CiviMember Roles Sync means creating **association rules** and then
letting the sync run (on cron, or on demand). Each rule is a small configuration
entity that you can export and import with the rest of your site config.

## Create an association rule

1. Open the **Association Rules** listing from the module's configuration link
   (the `civicrm_member_role_rule` collection).
2. Add a rule and set:
   - the **CiviCRM membership type** it applies to,
   - the **membership statuses** that count as "current" for this rule (for
     example *New*, *Current*, *Grace* — include grace-period statuses if you want
     members in grace to keep their role),
   - the **Drupal role** to grant to matching contacts.
3. Save. You can create several rules — different membership types mapping to
   different roles, a distinct role for lifetime members, an extra role for
   committee members, and so on. Multiple rules can apply to a single contact.

## How the sync behaves

- For each rule, contacts whose membership **matches** (right type, a status in
  your "current" list) are **granted** the role; contacts who no longer match
  have it **revoked**.
- The sync is **authoritative**: it both grants and takes away the roles it
  manages. Do **not** hand-assign a role that a rule controls, because the next
  sync will remove it from anyone who doesn't qualify under the rule.

## Running the sync

- **Automatically on cron** — the module syncs whenever Drupal cron runs, so once
  your rules are in place membership changes flow through to roles without manual
  work.
- **On demand / from the command line** — the module ships a Drush integration
  (a legacy `civicrm_member_roles.drush.inc` include), so you can trigger a sync
  from the CLI. This is the recommended step right after a bulk membership import
  rather than waiting for cron. Because it uses the older Drush include style, the
  exact command name can vary with your Drush version — find it with:

  ```bash
  drush list | grep civicrm
  ```

  (with DDEV: `ddev drush list | grep civicrm`). Then run the command it lists,
  optionally on a schedule via your system cron.

## Troubleshooting

If the sync doesn't run, the cause is usually CiviCRM rather than this module:
CiviCRM must be bootstrappable from Drupal for membership data to load. Confirm
CiviCRM itself is healthy first, then re-run the sync.
