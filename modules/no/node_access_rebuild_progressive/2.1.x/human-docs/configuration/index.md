# Configuration

There are two things to set up: the **settings form** (how big each chunk is, and
whether cron does the work), and the **Drush command** you use to actually run a
rebuild.

## The settings form

Go to **Configuration → Development → Node Access Rebuild Progressive**
(`/admin/config/development/node-access-rebuild-progressive`). It has two options:

- **Chunk** — the number of nodes processed per pass (per cron run, or per loop of
  the Drush command). The default is **500**.
  - A **smaller** chunk uses less memory per pass but needs more passes — safer on
    memory-constrained hosting.
  - A **larger** chunk finishes in fewer passes but uses more memory and time per
    pass — fine on powerful hosts.
- **Cron** — when ticked, each cron run processes one chunk of a pending rebuild.
  This is how you spread a long rebuild across many cron runs without running the
  Drush command at all. It's best used on sites whose cron is triggered by a real
  scheduler (e.g. Drush cron), not the occasional web-triggered cron.

The form validates that the chunk value is a positive integer. Click **Save
configuration**.

You can also read or set these from the command line:

```bash
drush cget node_access_rebuild_progressive.settings
drush cset node_access_rebuild_progressive.settings chunk 100 -y
drush cset node_access_rebuild_progressive.settings cron true -y
```

## Running a rebuild with Drush

The main way to rebuild is the Drush command:

```bash
# Rebuild all node access grants (only acts if a rebuild is actually needed):
drush node-access-rebuild-progressive
```

Its options:

| Option | What it does |
|--------|--------------|
| `--force` | Run even when Drupal doesn't currently flag a rebuild as needed. |
| `--resume` | Continue an interrupted rebuild from where it stopped, rather than starting fresh. |
| `--bundle` | Restrict the rebuild to specific content types (comma-separated machine names), e.g. `--bundle=article,page`. |

Examples:

```bash
# Force a rebuild even if Drupal doesn't think one is needed:
drush node-access-rebuild-progressive --force

# Resume an interrupted rebuild:
drush node-access-rebuild-progressive --resume

# Rebuild only certain content types:
drush node-access-rebuild-progressive --bundle=article,page,event
```

Good to know:

- Without `--force` or `--resume`, the command does nothing unless a rebuild is
  genuinely needed — so it is safe to run in a deploy script.
- It takes a one-hour lock so it cannot run at the same time as the cron processor;
  if the lock is already held it logs an error and exits.
- Bundle-restricted rebuilds do **not** clear Drupal's global "needs rebuild" flag
  (the expectation is that you rebuild every needed bundle).

## Cron-based rebuilds

If you turned **Cron** on in the settings form, you don't need to run the Drush
command manually — each cron run processes one chunk whenever a rebuild is pending,
until it finishes. This keeps a production site responsive during a very large
rebuild.

## Core's "Rebuild permissions" button is disabled

This module deliberately **disables Drupal core's built-in "Rebuild permissions"
form** (the one linked from the status report). If you open it, it is greyed out and
its text is replaced with instructions to run
`drush node-access-rebuild-progressive` (and `--resume` for an interrupted run). This
is intentional — it stops anyone from triggering the risky all-at-once rebuild on a
large site.

## Recovering a stuck rebuild

If a rebuild crashes and its lock is left behind, you can clear the lock and resume:

```bash
# Release a crashed lock:
drush sqlq "DELETE FROM semaphore WHERE name='node_access_rebuild_progressive_process'"
# Then resume:
drush node-access-rebuild-progressive --resume
```

The module keeps its progress in Drupal's state system; a completed or cleared
rebuild simply has its position reset to zero. The
[`agent/`](../agent/api/trigger.md) docs describe the exact state keys if you ever
need to inspect or reset them by hand.
