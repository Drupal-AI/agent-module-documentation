# Admin Audit Trail Config Sync — manual setup guide

**Admin Audit Trail Config Sync** (`admin_audit_trail_config_sync`) fills a gap in
the [Admin Audit Trail](https://www.drupal.org/project/admin_audit_trail) module.
Admin Audit Trail logs administrative activity, but it skips its own logging for
command-line requests because it expects a normal web request — which means a
`drush config:import` (a configuration synchronization run) leaves **no audit
entry**. On sites that deploy configuration through CI/CD or Drush, those changes
would go unrecorded.

This module closes that gap. It listens for Drupal's configuration-import event and
writes an audit-trail entry directly to the database, so config-sync operations are
captured whether they were triggered through the web UI or from the command line.
Each completed import is logged as an `import_success` entry that includes a summary
of what was created, updated, and deleted, and — when available — the SSH user who
ran it. It also registers a **"Config Sync"** event type so you can filter for
these entries in the audit overview.

There is nothing to configure: no settings page, no permission, and no routes of
its own. Enable it alongside Admin Audit Trail and it just works. Because it only
subscribes to an internal event and reads no request data, it adds no attack
surface beyond the parent module. It works on Drupal 10, 11, and 12.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to set up beyond enabling the module. Once it and Admin Audit
Trail are both on:

1. Deploy configuration as you normally would — for example run
   `drush config:import` (locally, or from your CI/CD pipeline).
2. Go to the Admin Audit Trail overview and filter by the **Config Sync** event
   type.
3. You will see an entry for each completed import, with a summary of the created,
   updated, and deleted config items and the SSH user who ran it where that
   information is available.

This gives you an audit record of who deployed configuration and when — useful for
compliance, change control, and correlating config drift with a specific
deployment.
