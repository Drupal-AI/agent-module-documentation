# Configuration

Purge control has a small settings form plus a set of Drush commands. The form is
handy for a one-off manual pause; the Drush commands are what you reach for when a
deployment or migration script needs to pause and resume purging on its own.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Performance → Purge → Purge control**,
   or navigate directly to
   `/admin/config/development/performance/purge/purge-control`.

## The settings

The form has two checkboxes:

- **Disable purging** — when ticked, purging is turned off. Invalidations that
  would normally be queued and sent to your external cache are not processed while
  this is set. This is the manual pause switch. Untick it (and save) to resume.
- **Automate control of enabling and disabling of purge** — when ticked, a cron
  run will **automatically re-enable purging if it has been disabled**. This is a
  safety net: it stops a forgotten manual pause from silently leaving your CDN
  stale forever. Leave it **off** while you are deliberately paused for a long
  operation (otherwise the next cron run turns purging back on underneath you),
  and use it as a fallback the rest of the time.

Click **Save configuration** to apply.

## The Drush commands (the point of the module)

For deployments and migrations, drive the pause from Drush rather than the form:

```bash
drush pc --help   # help for the command
drush pc enp      # ENable Purging
drush pc disp     # DISable Purging
drush pc ena      # ENable Automation
drush pc disa     # DISable Automation
```

### Example: a production release with a CDN

Pause before the release so no invalidation traffic reaches the CDN, then resume
and flush everything afterward:

```bash
# Before the release — stop automation, then stop purging
drush pc disa
drush pc disp

# ... run the release ...

# After the release — turn purging (and automation) back on
drush pc ena
drush pc enp

# Then flush everything that may have changed while paused
drush pqe                 # empty the queue
drush pqa everything      # queue a single "everything" invalidation
drush pqw                 # process the queue
```

### Example: wrapping a long Drush process

For a long-running command that causes lots of invalidation (a migration, for
instance), you can pause and resume automatically from the command's pre- and
post-command hooks by calling the module's service:

```php
// In a pre-command hook: pause at the start.
\Drupal::service('purge_control.purge_control')->autoDisablePurge();

// In a post-command hook: resume at the end.
\Drupal::service('purge_control.purge_control')->autoEnablePurge();
```

Inject the `purge_control.purge_control` service properly rather than calling
`\Drupal::service()` in real code. The `autoDisablePurge()` / `autoEnablePurge()`
methods respect the automation flag, so they only act when automation is enabled.

## Remember: clear the cache after resuming

Anything that changed **while purging was paused was never invalidated**, so your
external cache is stale for those items — resuming does not backfill them. Always
follow a pause with a full "everything" invalidation (as shown above). The
companion **Purge Everything Queuer** module is built for exactly this and can
also restart a purge process that stalled because the queue filled up.
