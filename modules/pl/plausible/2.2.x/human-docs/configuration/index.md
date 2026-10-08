# Configuration

## Open the settings form

1. Log in as a user with the **Administer Plausible configuration** permission.
2. Go to **Configuration → Web services → Plausible**, or navigate directly to
   `/admin/config/services/plausible`.

All values are stored in the `plausible.settings` config object. The form is
grouped into the sections below.

## The tracking snippet

These settings control the `<script>` that Plausible injects into every tracked
page's head.

- **Script version** — choose the **october‑2025** snippet (the current Plausible
  script, bootstrapped with `plausible.init()`) or the **legacy** snippet. If you
  pick the legacy snippet you must also set the **Script src** below.
- **Script src** — the URL of the Plausible JavaScript, for example
  `https://plausible.io/js/plausible.js`, or a self‑hosted / proxied path. Setting
  a proxied path is a common way to dodge ad blockers.
- **Domain** — the tracked domain. Used by the legacy snippet as `data-domain`;
  leave it empty to auto‑detect from your front‑page host. Set it explicitly if
  auto‑detection isn't right.
- **API endpoint** — an optional custom event/API endpoint. The new snippet passes
  it as `plausible.init({endpoint})`; the legacy snippet uses it as `data-api`.
  Point this at your proxy or self‑hosted collector when needed.

## Visibility — where the snippet loads

A global **Enable** switch turns all tracking on or off without uninstalling the
module. Below it, three rules decide which requests get the snippet. Drupal only
adds the matching cache context when a rule is active, so caching stays correct.

- **Pages (by path)** — choose one of: track *every page*; track every page
  **except** a listed set; or track **only** a listed set. The path list accepts
  one pattern per line (alias‑aware, with `/` for the front page) — for example
  `/blog/*` to track just the blog, or `/user/*` in the exclude list to skip user
  pages.
- **Roles** — choose one of: track *all roles*; track **only** selected roles; or
  track everyone **except** selected roles. Excluding your editor/admin roles keeps
  staff traffic out of your analytics.
- **Admin routes** — choose one of: leave admin tracking unchanged; **don't** track
  admin pages; or track **only** admin pages.

## Error‑page events

- **403 events** — when enabled, a Plausible custom event fires on access‑denied
  (403) responses, recording the path.
- **404 events** — when enabled, the same happens for not‑found (404) responses —
  a handy way to discover broken links.

Both are off by default.

## Dashboard — the embedded reports page

- **Shared link** — paste a Plausible **shared dashboard link** here. The
  **Reports → Plausible Dashboard** page (`/admin/reports/plausible`, behind the
  *View Plausible dashboard* permission) then embeds that link in an iframe. If the
  active admin theme is **Gin**, the embed follows Gin's light/dark/system setting
  automatically. If you leave the shared link empty, that reports page just shows a
  link back to this settings form.

## Save

Click **Save configuration**. Tracking changes take effect on the next page load
of any page that matches your visibility rules. You can confirm the snippet is
present by viewing a tracked page's HTML source and looking for the Plausible
`<script>` in the head.
