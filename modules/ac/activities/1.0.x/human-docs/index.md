# Activities — manual setup guide

**Activities** (`activities`) is an audit‑trail module: it tracks and logs user
transactions — **create, update, delete, and view** operations on Drupal entities — into
a queryable log, so you can answer "who changed what, and when?". Each logged entry
records the acting user, the operation, a human‑readable description and link to the
affected entity, the entity's type/id/bundle, a timestamp, the IP address, and location.

You decide exactly what gets logged on the settings form: for every content entity type
you can enable any of the four operations, and optionally restrict logging to specific
bundles. Because logging **view** operations fires on *every* page request for that entity
type, the settings form also exposes security controls — a per‑user view throttle window
and an "exclude anonymous users from view tracking" toggle — so a public site's log isn't
flooded. To keep the log from growing without bound, a purge runs on cron with three
strategies: never, time‑based (delete entries older than N days), or count‑based (keep at
most N entries). A manual purge form is available too.

The log is exposed through **Views** (the `user_activities` entity, with custom
description/link fields and a bundle filter), and there are services and a hook for
logging or altering activity in code. Activities depends on core's **Views** module and
pulls in two contributed export libraries; a bundled **Activity Data Export** submodule
adds a Views page with CSV/XLS export. Three permissions gate viewing, administering, and
manually purging the log.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module, and
   the optional export submodule.
2. [Configuration](configuration/index.md) — choose what to log, the view‑tracking
   security controls, the purge settings, and the permissions.

## Where it lives in the admin menu

The main settings form is at **Configuration → Activities**
(`/admin/config/activities`), with a **Purge** sub‑form
(`/admin/config/activities/purge`) and a **manual purge** form beneath it. The activity
log itself is viewed through a Views listing of the `user_activities` entity.

## How to use it

1. Enable the module.
2. Open the settings form and enable the operations you want to log for the relevant
   entity types (Activities logs nothing until you do).
3. If you enable **view** logging, review the security throttle and anonymous‑exclusion
   options.
4. Choose a purge strategy so the log stays a manageable size, and make sure cron runs.

See [Configuration](configuration/index.md) for the full walkthrough.
