# Configuration

Warmer stores every warmer's settings in a single configuration object. This page
covers the settings form (shared options plus the two submodule warmers), manual
warming, automatic warming on cron, and the Drush commands.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default). Warmer defines no permission of its own.
2. Go to **Configuration → Development → Cache warming → Settings**, or navigate
   directly to `/admin/config/development/warmer/settings`.

Only warmers whose submodules are enabled appear on the form. If you have not
enabled **Entity warmer** or **CDN warmer** yet, do that first (see
[Installation](../installation/index.md)).

## Shared options (every warmer)

Each warmer has these two settings:

- **Frequency** — the minimum number of seconds between automatic re‑warms on
  cron (default `300`). This is a *minimum interval*: the real cadence is also
  bounded by how often your cron actually runs. Increase it so a heavy warmer
  re‑runs less often.
- **Batch size** — how many items are enqueued and processed per batch (default
  `50`). Raise it for throughput, lower it to be gentler on the server.

## Entity warmer options

When the **Entity warmer** submodule is enabled, its warmer adds:

- **Entity types / bundles** — pick which entity type + bundle pairs to warm (for
  example `node:article`, `taxonomy_term:tags`). You can warm several in one
  Entity warmer.
- **Published only** — when on, only published entities of the chosen types are
  warmed.

## CDN warmer options

When the **CDN warmer** submodule is enabled, its warmer adds:

- **URLs** — a list of absolute or relative URLs to fetch (warming their page/edge
  cache). The Sitemap variant instead reads URLs from one or more XML sitemaps,
  and can filter them by a minimum sitemap `<priority>` so only important pages are
  fetched.
- **Headers** — custom HTTP headers to send with each warming request (auth
  tokens, cache‑buster headers, and so on).
- **Verify** — whether to verify the SSL certificate on warming requests.
- **Max concurrent requests** — how many HTTP requests the CDN warmer makes at
  once.

Click **Save configuration** when you're done. (The form always writes every
warmer's full settings at once.)

## Warm caches manually

To force an ad‑hoc warm without waiting for cron, go to **Configuration →
Development → Cache warming** (`/admin/config/development/warmer`), select the
warmers you want, and submit the **Warm caches** form. This enqueues the selected
warmers; the queue is then drained on the next cron run (or immediately via Drush,
below).

## Automatic warming on cron

On every cron run, Warmer re‑enqueues any warmer whose **frequency** window has
elapsed since its last enqueue. Enqueued batches sit in a reliable queue named
`warmer` and are drained by the queue worker on subsequent cron runs. So to warm
on a schedule, just set each warmer's frequency and make sure cron runs regularly
(ideally off‑peak).

## Drush commands

Warmer ships two Drush commands, handy for deploy scripts and CI/CD:

- **`drush warmer:enqueue <ids>`** — enqueue one or more warmers by comma‑separated
  plugin ID (e.g. `entity`, `cdn`). Unknown IDs abort the command. Add
  **`--run-queue`** to immediately drain the queue so items land in cache right
  away:

  ```bash
  drush warmer:enqueue entity            # schedule; drained on the next cron
  drush warmer:enqueue cdn,entity        # multiple warmers at once
  drush warmer:enqueue cdn --run-queue   # enqueue AND warm now
  ```

- **`drush warmer:list`** — a table of every registered warmer with its ID, label,
  description, current frequency, and batch size. Add `--format=json` for machine
  output.

The warming batches live in the queue named `warmer`; you can also drain it
manually with `drush queue:run warmer`.
