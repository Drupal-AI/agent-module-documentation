# Configuration

The module targets nothing until you configure it. Here you list the specific nodes,
Views pages, and themes that should be served jQuery 3 instead of Drupal 11's
jQuery 4.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → jQuery Downgrade**, or navigate directly to
   `/admin/config/development/jquery-downgrade`.

## The fields

- **Node IDs** — a textarea where you list node IDs, one per line. When one of these
  nodes is viewed, that page gets jQuery 3. Use this for a single landing page, a
  booking node with an old datepicker, or any content that embeds a jQuery-3-only
  plugin.

- **View Routes** — a set of checkboxes, one for every Views page display on your
  site (shown as *view - display (route)*). Tick a display to downgrade its page.
  Use this when a Views-provided script — a calendar, a slideshow — assumes jQuery 3.

- **Enable jQuery downgrade for specific themes** — a checkbox that turns on
  theme-based downgrading. Leave it off if you only want to target individual nodes or
  Views pages.

- **Themes that should use jQuery 3** — a set of checkboxes listing your installed
  themes. It only appears when the theme-downgrade checkbox above is ticked. Any theme
  you check here will serve jQuery 3 on every page it renders. Use this to keep an
  older public theme on jQuery 3 while editors' themes move to jQuery 4, or vice
  versa.

Click **Save configuration** to store your choices. You can combine all three
targeting methods; a page is downgraded if it matches any of them.

## How the downgrade is applied

On each page request the module checks the current route. It serves jQuery 3 when
**any** of these is true:

- the node being viewed is in your **Node IDs** list; or
- the current route is one of your ticked **View Routes**; or
- theme-based downgrade is on and the active theme is one of your checked themes.

When a page matches, the module removes core's jQuery (jQuery 4) from the page and
attaches its own legacy library, which loads jQuery 3.6.4 from
`https://code.jquery.com/jquery-3.6.4.min.js`. On every non-matching page, jQuery 4 is
served as normal.

## A migration tip

Treat the lists as a shrinking allowlist. As you verify each page works under
jQuery 4, remove it from the settings here — that drops the extra external CDN request
for that page and moves you closer to running fully on jQuery 4.

## Storing it as config

All of this lives in a single config object, `jquery_downgrade.settings`, so it
exports and deploys with the rest of your configuration. If you prefer the command
line, you can read and write it with Drush:

```bash
drush cget jquery_downgrade.settings
drush cset jquery_downgrade.settings node_ids.0 12 -y
```
