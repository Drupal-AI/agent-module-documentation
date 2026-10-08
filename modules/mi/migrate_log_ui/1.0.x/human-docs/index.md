# Migrate log UI — manual setup guide

**Migrate log UI** (`migrate_log_ui`) gives you a proper admin screen for reading
the messages a migration produces, instead of scrolling back through Drush
output. Every migration records notices, warnings, and errors as it runs; this
module surfaces them in a filterable, paged, sortable table so you can actually
find out *why* certain rows failed — without re‑running the migration.

It adds two pages. An **overview** lists every non‑disabled migration, grouped by
migration group, with counts for total, processed, imported, failed, ignored,
unprocessed, to‑update, and messages. From there you open a **message log
viewer** for a single migration, which shows that migration's messages joined to
its map data. You can filter by severity level, by source key (to zero in on one
record's problems), and by up to two message substrings using "contains" /
"does not contain" logic, and you can group identical messages to count how often
each occurs. Results are paged (500 per page) and sortable by column, and because
the filters live in the URL you can share a filtered view with a colleague just
by copying the link.

It depends only on core **Migrate** (`migrate`) and supports **Drupal 8, 9, and
10**. Both of its pages are gated by a dedicated **`view migrate log messages`**
permission, so access is restricted to the users you grant it to. The module
works as soon as it is enabled — there is nothing to configure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the log‑viewing permission.

There is **no configuration page** for this module — it ships no settings form.
Its value is the two viewing pages described below.

## Where it lives in the admin menu

Once enabled, the module adds two routes:

- **Migration overview** — `/admin/migrate/log_ui/migration` — lists all
  migrations with their counts.
- **Message log viewer** — `/admin/migrate/log_ui/migration/{migration}/messages`
  — the filterable message table for one migration, reachable by clicking through
  from the overview.

Both require the **`view migrate log messages`** permission.

## How to use it

1. Grant **`view migrate log messages`** at **People → Permissions**
   (`/admin/people/permissions`) to the developers and site builders who run
   migrations.
2. Run your migrations as usual.
3. Open the **overview** page to see counts across all migrations, then click a
   migration to open its **message log viewer**.
4. In the viewer, narrow the list with the filters — pick one or more severity
   levels, enter a source key, and/or type message substrings (with "contains"
   or "does not contain") to find the failures you care about. Turn on the
   group‑by‑message option to collapse duplicates and count occurrences.
5. Copy the page URL to share the exact filtered view with a teammate.
