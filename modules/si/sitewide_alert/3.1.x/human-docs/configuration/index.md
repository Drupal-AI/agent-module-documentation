# Configuration

Sitewide Alert has two layers: a **global settings form** that applies to all
alerts, and the **individual alerts** themselves, which are content you add and
edit like any other. This page covers both, plus the permissions and the Drush
commands.

## Global settings

1. Log in as a user with the **Administer sitewide alert** permission.
2. Go to **Configuration → Sitewide Alerts**, or navigate directly to
   `/admin/config/sitewide_alerts`.

All values are stored in the `sitewide_alert.settings` config object. The form
offers:

- **Alert styles** — the list of color/severity styles offered by an alert's
  **Style** field, one per line in the form `machine_key|Human label`. The
  default is `primary|Default`. Add lines such as `info|Information` and
  `danger|Danger` to make those choices selectable on the alert form. A line
  with no `|` uses the text as both the key and the label. This is how you add a
  new style — no code required.
- **Show on admin pages** — off by default, so alerts only reach front-end
  visitors. Turn it on if you also want them on `/admin` pages.
- **Show count** — show an unread/updated-alert count to visitors.
- **Display order** — when several alerts are active at once, stack them
  **ascending** (default) or **descending**.
- **Refresh interval** — seconds between the client's background polls of the
  alert endpoint (default **15**).
- **Automatic refresh** — whether the client auto-refreshes alerts at all.
- **Cache max-age** — how long (in seconds) the alert JSON response may be cached
  (default **15**).
- **Server-side render** — render alerts server-side so they work without
  JavaScript, instead of injecting them client-side. Off by default.
- **Show untranslated** — on a multilingual site, show alerts that have no
  translation in the current language.

Click **Save configuration** when done.

## Creating and editing alerts

Individual alerts are content entities, managed at **Content → Sitewide alerts**
(`/admin/content/sitewide_alert`); use **Add** to create one
(`/admin/content/sitewide_alert/add`). Each alert has these fields:

- **Name** — a short administrative label (required, max 50 characters). Not
  shown to visitors; it just identifies the alert in the admin list.
- **Message** — the banner body, edited with a rich-text editor.
- **Active** — the published flag. An alert only shows when this is ticked.
- **Style** — one of the styles from the global settings above (color/severity).
- **Dismissible** — let visitors close the banner; the dismissal is remembered
  per browser, no login needed.
- **Ignore dismissals before** — a timestamp that forces the alert to reappear
  for people who dismissed it earlier. Bump it after an important edit.
- **Scheduling** — turn on the schedule and set a start and end date/time, and
  the alert automatically appears and disappears between them.
- **Limit to pages** — one path per line to target specific pages (use `*` as a
  wildcard and `/` for the front page). A **negate** option flips this to "show
  everywhere *except* these pages."

Save the alert and it goes live on the pages you targeted (subject to the
viewing permission below).

## Permissions

Set these at **People → Permissions** (`/admin/people/permissions`):

| Permission | What it allows |
|------------|----------------|
| **Administer sitewide alert** | Access the global settings form. *Restrict to administrators.* |
| **Administer sitewide alert entities** | Full admin over alert entities. *Restrict.* |
| **Add / Edit / Delete sitewide alert entities** | The everyday create/edit/delete actions — grant to an editor role. |
| **View published sitewide alert entities** | See active alerts. Grant to every role that should see banners (anonymous + authenticated). Also gates the `/sitewide_alert/load` endpoint. |
| **View unpublished sitewide alert entities** | See inactive alerts. |
| **View / Revert / Delete all sitewide alert revisions** | Work with the revision history. |

A typical setup: give anonymous and authenticated **view published sitewide
alert entities** so everyone sees banners, give an editor role the
**add/edit/delete** permissions to manage alerts without full site admin, and
keep the global settings permission for administrators only.

## Managing alerts from the command line (Drush)

Handy for scheduled or automated announcements:

| Command | Purpose |
|---------|---------|
| `drush sitewide-alert:create "<label>" "<message>"` | Create a new alert. |
| `drush sitewide-alert:enable "<label>"` | Activate matching alert(s). |
| `drush sitewide-alert:disable ["<label>"]` | Disable all active alerts, or only those matching a label. |
| `drush sitewide-alert:delete "<label>"` | Delete matching alert(s). |

The `create` command accepts options: `--style=<key>` (a style key from your
settings; unknown values fall back to `primary`), `--start=<when>` and
`--end=<when>` (any value PHP's `strtotime()` understands, e.g. `"today 09:00"`
or `"tomorrow 13:45"` — supplying either turns the alert into a scheduled one),
`--no-active` to create it inactive, and `--dismissible`.

```bash
drush sitewide-alert:create "Outage" "We are investigating an outage." --style=danger
drush sitewide-alert:create "Sale" "50% off today" --start="today 09:00" --end="today 17:00"
drush sitewide-alert:disable            # kill all active alerts instantly
```
