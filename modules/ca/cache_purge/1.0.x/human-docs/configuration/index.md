# Configuration

Cache Purge needs one thing from you: the size limit at which a cache table should
be purged.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Cache Purge**, or navigate directly to
   `/admin/config/system/cache-purge`.

## Set the size limit

The form takes a **size threshold in megabytes**. On each cron run, the module
measures every database cache table and truncates any table whose size is over this
limit. Set it high enough that normal caching is left alone, but low enough to keep
the tables within the space you can afford — for example on a database with a tight
quota, or where large cache tables are bloating your backups.

Save the form. From then on the trimming happens automatically on cron; there is no
manual purge button and nothing else to configure.

## A note on permissions

The module also declares an **Administer cache purge** permission
(`administer cache purge`). Note that the settings form itself is gated by the core
**Administer site configuration** permission rather than that dedicated permission,
so an administrator can reach it out of the box.
