# Configuration

Configuration is a single toggle.

## Turn logging on

1. Log in as a user who can administer site configuration.
2. Go to **Configuration → Log Cache Tags**, or navigate directly to
   `/admin/config/log_cache_tags`.
3. Check the box to **log cache tag invalidations** and save.

From that point, cache-tag invalidations are written to the database log as you use
the site.

## Read the log

Open **Reports → Recent log messages** (`/admin/reports/dblog`) and look for
entries on the **`log_cache_tags`** channel. These show you which cache tags were
invalidated, which is exactly what you want when troubleshooting invalidation
problems, origin hits, or general cache-tag behavior.

## Turn it off when you're done

Logging every invalidation is **noisy and adds overhead**, and it can quickly fill
dblog with enormous amounts of cache-tag data. When you've finished investigating,
go back to `/admin/config/log_cache_tags` and **uncheck** the box. Don't leave this
switched on — and don't run it on production at all. It's a development aid, best
kept to dev and staging environments.
