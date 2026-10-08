# Configuration

Drupical has no settings form. Setting it up is three small jobs: **place the block**,
**grant the permission**, and (optionally) **tune the three settings** from the command
line.

## Place the Events Feed block

Place the **Events Feed** block like any other block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the events to appear, click **Place block**.
3. Find **Events Feed** in the list, place it, and save the block settings (you can
   change its title — it defaults to "Drupal Events and User Groups").

If you use the **Dashboard** module (for example on a Drupal CMS site), you can add the
same block to the administrative dashboard instead, so admins see upcoming events when
they log in.

## Grant the "Access events" permission

The block — and its Load More action — are only visible to users with the **Access
events** permission. Grant it on **People → Permissions**
(`/admin/people/permissions`) to whichever roles should see the feed. For a public
events block, grant it to the **Anonymous** and **Authenticated** roles:

```bash
drush role:perm:add anonymous 'access events'
drush role:perm:add authenticated 'access events'
```

## Tune the three settings (optional)

The settings live in the `drupical.settings` configuration object. There is no form,
so edit them with Drush. All three are whole numbers:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Limit** (`limit`) | `5` | How many events to display, and the page size for Load More. |
| **Max age** (`max_age`) | `86400` (1 day) | How many **seconds** fetched events are cached before the feed is queried again. |
| **Cron interval** (`cron_interval`) | `21600` (6 hours) | The minimum number of **seconds** between automatic event re‑fetches on cron. |

```bash
drush config:set drupical.settings limit 10 -y
drush config:set drupical.settings max_age 3600 -y
drush config:set drupical.settings cron_interval 3600 -y
```

## How refreshing works

Drupical caches the fetched events so it does not hit the Drupal.org API on every page
view. Cron re‑fetches the events once more than **cron interval** seconds have passed
since the last fetch. Clearing Drupal's caches does not clear the stored events — they
refresh on their own once the **max age** window expires. To force an immediate
refresh:

```bash
drush php:eval '\Drupal::service("drupical.fetcher")->fetch(TRUE);'
```
