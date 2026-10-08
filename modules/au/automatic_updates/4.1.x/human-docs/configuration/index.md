# Configuration

Automatic Updates has **no settings page of its own**. It adds its options to core's
existing **Update settings** form and the core update report. Everything below
requires core's **Administer software updates** permission (an administrator by
default).

## Running a push-button ("attended") update

This is the manual, one-click flow — you decide when to update.

1. Go to **Reports → Available updates** (`/admin/reports/updates/update`). When a
   supported Drupal core release is available, an **Update now** option appears.
2. Choosing it **stages** the update in a sandbox copy of your site — the live site
   stays online throughout.
3. On the **Ready to update** page you review and confirm the staged change.
4. Confirming **finalizes** the update, syncing the sandbox into your live codebase.
   The site enters maintenance mode only briefly, during this final step.

## Turning on unattended (cron) updates

Unattended updates run in the background during cron, with no clicks at all. Open the
altered **Update settings** form at **Reports → Available updates → Settings** and
choose how aggressive they should be. The two key options map to the
`automatic_updates.settings` config object:

**Update level** (`unattended.level`):

- **Disabled** (default) — no unattended updates; the push-button flow still works.
- **Security only** — apply only security releases automatically.
- **All patch releases** — apply every patch-level core release automatically.

**Update method** (`unattended.method`):

- **Web** (default) — updates run through Automated Cron / `/system/cron`.
- **Console** — updates run via the `auto-update` command-line tool, which you invoke
  from a system scheduler. Choose this if you prefer to run updates outside the web
  request.

When unattended updates are enabled, cron launches the update as a detached
background process after its normal tasks finish, so the update outlives the web
request. As with the push-button flow, the site is put into maintenance mode only for
the brief final sync.

### Other settings

| Setting | Default | What it does |
|---------|---------|--------------|
| **Allow minor core updates** (`allow_core_minor_updates`) | Off | Permit minor-level core updates, not just patch releases. |
| **Status check email** (`status_check_mail`) | Errors only | Whether cron-time readiness-check failures are emailed to admins. |
| **Cron port** (`cron_port`) | Unset | The port used for the update's finalization sub-request (advanced; usually leave blank). |

You can also set any of these from the command line, e.g.
`drush config:set automatic_updates.settings unattended.level security`.

## Update readiness checks

Whether or not you use unattended updates, the module runs **readiness checks** — the
same safety validators, but outside of an actual update — so you can spot problems
early. Their results appear:

- on the **Status report** (**Reports → Status report**),
- as admin warning messages, and
- optionally by **email** during cron (controlled by the status-check email setting
  above).

Results are cached for 24 hours. To force a fresh run, visit
`/admin/automatic_updates/status`.

## What the safety validators protect against

Before any update commits, a set of validators can block it. You don't configure
these — they run automatically — but it helps to know what they guard against:

- downgrades, dev snapshots, and non-security or pre-release targets;
- updates on an unsupported branch or a Windows environment;
- updates that bring **database schema changes** (these are refused so they don't run
  unattended);
- changes to anything other than Drupal core in the sandbox;
- cron running too infrequently for reliable unattended updates;
- missing required PHP extensions.

If a validator fails, the update is stopped and the reason is reported, so you can
fix the underlying issue and try again.
