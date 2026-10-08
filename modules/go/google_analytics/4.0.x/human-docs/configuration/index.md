# Configuration

The whole module is configured from one form. Here you enter your GA4
**Measurement ID** and then use the **Tracking scope** tabs to decide which pages,
roles, and users are tracked, and whether to track outbound links and downloads.

## Open the settings form

1. Go to **Configuration → Web Services → Google Analytics**
   (`/admin/config/services/google-analytics`).

![The Google Analytics settings form](../images/settings.png)

## Step 1 — Enter your Web Property (Measurement) ID

At the top of the form is the **Web Property ID(s)** section with a text field.

1. Paste your GA4 **Measurement ID** into the field. A GA4 ID looks like
   `G-XXXXXXX`. As the help text under the field notes, the module also accepts
   other ID formats (`UA-xxxxx-yy`, `AW-xxxxxxxxx`, `DC-xxxxxxxx`).
2. This ID is unique to each site you want to track. If you do not have one yet,
   use the **register your site with Google Analytics** link in the help text to
   create a property, then copy its Measurement ID.
3. To send data to more than one property, click **Add another ID** and enter an
   additional Measurement ID in the new row.

## Step 2 — Set the Tracking scope

Below the ID field is the **Tracking scope** area, a column of vertical tabs. Each
tab's subtitle shows its current setting at a glance. Click a tab to open its
options on the right.

### Domains

Controls how many domains the tracker spans. Under **What are you tracking?** you
choose one of:

- **A single domain (default)** — track just this site.
- **One domain with multiple subdomains** — for example `www.example.com`,
  `app.example.com`, `shop.example.com`.
- **Multiple top-level domains** — for example `www.example.com`,
  `www.example.net`, `www.example.org`. When you pick this, list the related
  domains (one per line) in the **List of top-level domains** box that appears.

### Pages

Controls *which* pages are tracked (its subtitle reads **All pages with
exceptions**). Use this tab to either:

- **Track every page except a list** (a deny-list) — the common choice. Admin and
  user paths are excluded by default so you are not logging back-end activity.
- **Track only a specific set of pages** (an allow-list) — enter the paths you
  *do* want tracked.

Enter one path per line to build the list.

### Roles

Controls which **user roles** are tracked (its subtitle reads **Not restricted**
until you change it). This is where you exclude your own staff — for example, tick
the **Administrator** role so admins' own visits are not counted in your reports.
You can either add tracking for or remove tracking from the roles you select.

### Users

Controls per-user tracking (subtitle **On by default with opt out**). You can:

- Track everyone with **no personal choice**,
- Track everyone **by default but let users opt out** on their profile, or
- Track **no one by default but let users opt in** on their profile.

When opt-in/opt-out is enabled, a toggle appears on each user's account edit form.

### Links and downloads

Turns on tracking of clicks that leave a normal page view (subtitle lists what is
enabled, e.g. **Outbound links, Mailto links, Tel links, Downloads, Colorbox**).
Tick the behaviours you want recorded as GA events:

- **Outbound links** — clicks to external sites.
- **Mailto links** — clicks on `mailto:` email links.
- **Tel links** — clicks on `tel:` phone links.
- **Downloads** — clicks on file links, filtered by a list of file extensions
  (for example `pdf`, `docx`, `zip`).
- **Colorbox** — clicks inside Colorbox lightbox popups.

### Messages

Controls whether Drupal status, warning, and error messages shown to visitors are
reported to Analytics (subtitle **Not tracked** by default).

## Step 3 — Save

Scroll to the bottom and click **Save configuration**. The tracking snippet is
added to matching pages immediately, and data begins flowing to your GA4 property
on the next visits. You can return to this form at any time to adjust the ID or
the tracking scope.
