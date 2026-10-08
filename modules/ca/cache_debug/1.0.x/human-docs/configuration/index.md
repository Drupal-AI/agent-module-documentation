# Configuration

## Open the settings form

1. Log in as a user with the **Configure cache debug** permission.
2. Go to **Configuration → Development → Cache Debug**, or navigate directly to
   `/admin/config/development/cache-debug`.

## The settings

- **Response logger** — the sink that records the cache tags of each cacheable response.
  This is what tells you which tags a given page is cached under.
- **Invalidated logger** — the sink that records cache tags as they are invalidated. This
  is what tells you which tag cleared a page, and it also captures invalidations triggered
  from Drush/CLI runs.
- **File log path** — where the **File** logger writes, defaulting to
  `private://cache_debug`. Keep this in the **private** scheme so the log is not web‑
  accessible.

For each logger you choose one of the built‑in sinks:

| Sink | What it does | Needs |
|------|--------------|-------|
| **File** | Appends tags to a file under the configured log path. | A working private file system. |
| **Logger channel** | Writes tags to the Drupal log (watchdog). | — |
| **Sentry** | Sends tags to Sentry. | The **Raven** module. |

Set either logger to **none** to turn that half off. Setting both to none effectively
disables the module — which is what you want on production or whenever you are not actively
debugging.

## Save

Save the form, then browse the site (or run the Drush command you want to trace) and read
the chosen sink to see the cache tags being set and cleared.
