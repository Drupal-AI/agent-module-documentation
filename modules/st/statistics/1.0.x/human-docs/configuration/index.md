# Configuration

Statistics does nothing until you turn counting on. This page covers the one
setting on the form, the extra setting you tune from config, placing the
"Popular content" block, and the two permissions.

## Turn on view counting

1. Log in as a user with the **Administer statistics** permission (an
   administrator by default).
2. Go to **Configuration → System → Statistics**, or navigate directly to
   `/admin/config/system/statistics`.
3. Tick **Count content views** and click **Save configuration**.

That single checkbox is the master switch. With it **on**, every full‑page node
view by a real browser is recorded. With it **off** (the default), nothing is
counted, and both the "N views" link and the "Popular content" block disappear.

### Display cache (`display_max_age`)

There is a second setting, **`display_max_age`**, which controls how long (in
seconds) the displayed counter — the "N views" link — may be cached before it
refreshes. It defaults to **3600** (one hour). It has **no field on the form**,
so change it from the command line if you need to:

```bash
drush cset statistics.settings display_max_age 600 -y   # refresh every 10 minutes
```

A shorter value makes the counter feel more live at the cost of more work per
request; a longer value reduces load.

## Grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`). Statistics adds two:

| Permission | Machine name | Lets a user… |
|------------|--------------|--------------|
| **Administer statistics** | `administer statistics` | Reach the settings form and toggle counting. |
| **View content hits** | `view post access counter` | See the "N views" counter link that appears under content. |

Neither permission is needed to *record* a view — counting happens for anonymous
visitors automatically once it's switched on. These permissions only control who
can *administer* and who can *see* the numbers. If you want the view counter
visible to everyone, grant **View content hits** to the *Anonymous user* and
*Authenticated user* roles.

## Place the "Popular content" block

Statistics ships a **Popular content** block that lists the most‑viewed and
most‑recent content. Add it at **Structure → Block layout**
(`/admin/structure/block`): find *Popular content*, place it in a region, and
configure its three numbers:

- **Number of top viewed content** — how many of *today's* most‑viewed items to
  list (based on the daily count).
- **Number of most viewed content** — how many *all‑time* most‑viewed items to
  list.
- **Number of last viewed content** — how many *most recently* viewed items to
  list.

Set any of these to zero to hide that section. The block only renders while
counting is switched on.

## Add view counts to a listing (Views)

Statistics provides three Views fields — **Total views**, **Today's views**, and
**Most recent view** — that you can add as columns to any View of content, and
sort or filter by. Use them to build a "trending today" list or a most‑popular
report. It also provides the tokens `[node:total-count]`, `[node:day-count]`, and
`[node:last-view]` for use in Views rewrites, messages, or templates.

## Daily reset

The daily count is a rolling figure: Drupal's cron zeroes every node's day count
once every 24 hours, so "today's views" always reflects the current day. Cron
also recomputes the popularity scale used to boost search‑result ranking for
frequently viewed content. Make sure cron runs regularly for these to work.
