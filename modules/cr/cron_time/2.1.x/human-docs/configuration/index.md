# Configuration

Cron Time adds its control to Drupal's own **Cron settings** page rather than
having a separate form of its own.

## Open the Cron settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Cron**, or navigate directly to
   `/admin/config/system/cron`.

## Set the cron interval

On this page, Cron Time lets you set the custom interval at which Drupal's
automated cron runs — the frequency of the background cron that fires on regular
site traffic.

- Choose a **shorter interval** when you need cron-driven work to happen promptly:
  processing queues, updating the search index, running scheduled publishing.
  Remember that automated cron only fires when there is a page request, so on a
  quiet site it may still lag behind the interval you set.
- Choose a **longer interval** to reduce how often cron work runs in the background.
  Setting it too high, though, will delay scheduled tasks like indexing and cleanup.
- If you **disable automatic cron** here, Drupal will no longer run cron on its own.
  You then have to trigger it externally — a server cron job calling the site's cron
  URL, or `drush cron` on a schedule — otherwise cron work never runs.

## Save

Click **Save configuration**. The new interval takes effect immediately for
automated cron.
