# Events Log Track — manual setup guide

**Events Log Track** (project `events_log_track`, module machine name **`event_log_track`**)
records create, update, and delete (CUD) actions that users perform through forms on
your site, and stores them as an audit trail. You can then review them at **Reports →
Events Log Track** (`/admin/reports/events-track`) — for example to see how many times
a particular operation was performed, and by whom.

> **Heads up on names.** The Drupal project is called **events_log_track** (that is what
> you `composer require`), but the module you enable and its submodules are named
> **event_log_track** (singular "event"). Both names are correct — they just apply to
> different steps, and this guide points out which is which.

The module is deliberately modular. The base module provides the log storage and the
review UI; you then enable **opt-in submodules** for exactly the areas you want to
audit — nodes, users, configuration, files, taxonomy, media, menus, comments,
webforms, workflows, groups, group membership, masquerade, TFA, block content, and
cache clears. Additional submodules let you send logs to **syslog** or **stdout**
instead of (or in addition to) the database. This "choose what to track" design keeps
the log focused and the volume manageable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and turn on the submodules for the areas you want to audit.
2. [Configuration](configuration/index.md) — the settings form: log deletion/retention,
   database vs. syslog output, and related options.

## Where it lives in the admin menu

- **Logs:** **Reports → Events Log Track** (`/admin/reports/events-track`) — the audit
  trail itself (provided by the `event_log_track_ui` UI submodule).
- **Settings:** **Configuration → System → Event log track**
  (`/admin/config/system/events-log-track`) — where you control log retention, output
  destination, and related options.

## How to use it

1. Enable the base module and the submodules for the areas you care about (see
   [Installation](installation/index.md)). Logging begins from the moment a submodule
   is enabled.
2. Perform some operations (create a node, change config, etc.), then open **Reports →
   Events Log Track** to see the recorded entries.
3. Restrict who may read the log by granting the **access event log track** permission
   only to trusted roles — audit logs can reveal who did what and when.
4. Tune retention and output on the settings form — see
   [Configuration](configuration/index.md).

> **Privacy and retention.** Audit logs record user activity and can accumulate
> personal data over time. Grant the log-viewing permission narrowly, and use the
> built-in log-deletion setting to keep entries only as long as your retention policy
> requires. If a tracked area may log especially sensitive details, consider pairing
> this with the companion
> [Event Log Track Encrypt](https://www.drupal.org/project/event_log_track_encrypt)
> module.
