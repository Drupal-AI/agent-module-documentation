# Configuration

Purge File is controlled from a single settings form. The choices here need to
match the purger you have configured in the Purge module, or nothing will be
invalidated.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Performance → Purge File**, or navigate
   directly to `/admin/config/development/performance/purge-file`.

## Workflow: immediate or queued

- **Immediate** — invalidations are executed the moment a file changes, using the
  module's own immediate processor. Best when edge freshness is time‑sensitive.
- **Queue** *(default)* — invalidations are added to the Purge queue to be
  processed later, for example on cron. Pair this with a queue processor such as
  Purge's cron processor. Best for high‑traffic sites where you want to batch the
  work.

## Invalidation type

Choose which kind of Purge invalidation to build. This **must** be a type your
enabled purger supports:

- **URL** *(default)* — invalidate the file's full URL.
- **Path** — invalidate by relative path (for purgers that work on paths).
- **Wildcard URL** — like URL, but appends `*` so every query‑string variant of
  the file URL (for example tracking parameters) is purged.
- **Wildcard path** — the path equivalent of wildcard URL.

## Base URLs

An optional comma‑separated list of base URLs to prepend to file URLs. Use this
when your public front‑end domain differs from the back‑office domain, or when the
same file is served from several domains — list each one and all are purged. Leave
it empty to use the current request's scheme, host, and base path. This setting is
ignored for the **Path** / **Wildcard path** types, which use relative paths.

## Debug logging

A checkbox that, when enabled, logs every file purge and the exact URLs sent to
Purge (to a `purge_file` log channel). Turn it on only while troubleshooting, then
switch it back off.

## Save and verify

Click **Save configuration**. Then check the site status report
(`/admin/reports/status`): Purge File adds a **"URL Purgers enabled"** check that
shows an error if no purger supports any of the URL/path invalidation types, and
otherwise lists the enabled ones. If it is green, replacing or deleting a file
will now invalidate it at the edge automatically.
