# Configuration

Frontend Asset Debugger works the moment it's enabled — the reports read your site's
declared libraries with no setup. Configuration is about two optional things:
adjusting the settings, and running a **page scan** to enrich the reports with
real‑page data.

## Open the settings

1. Log in as a user with the **Administer frontend asset debugger** permission (a
   restricted, administrator‑level permission).
2. Go to **Configuration → Development → Frontend assets**
   (`/admin/config/development/frontend-assets`, route
   `frontend_asset_debugger.settings`).

Here you configure the options that govern the scans and reports.

## Run a page scan (optional but recommended)

The declared‑library reports tell you what *could* load; a page scan tells you what
*actually* loads. The scan fetches a set of front‑end URLs with Drupal's HTTP client
and records which libraries appear on real pages, storing the results so the reports
can compare declared versus actually‑loaded assets.

- Trigger a scan from the settings/scan actions (the module exposes a run‑scan action
  and a scan‑pages endpoint).
- Running scans requires the **Administer frontend asset debugger** permission.

> **Good to know:** the page‑scan HTTP client fetches your own site's public pages for
> an admin‑only report and sends no credentials, so although it does not verify TLS on
> those same‑site requests, there's no practical security impact for this use.

## The reports and their locations

All reports live under **Reports → Frontend assets** and are gated by the
**Access frontend asset debugger** permission (read‑only, fine for developers):

- **Overview** — `/admin/reports/frontend-assets`
- **Duplicates** — `/admin/reports/frontend-assets/duplicates` — the same CSS/JS
  shipped by more than one library.
- **Unused** — `/admin/reports/frontend-assets/unused` — libraries declared but never
  used.
- **Render‑blocking** — `/admin/reports/frontend-assets/render-blocking` — assets that
  block rendering, with async/defer recommendations.
- **Per‑component** — `/admin/reports/frontend-assets/per-component` — which
  components (SDC, Layout Builder sections, blocks, paragraphs, themes, modules) pull
  in which assets.
- **Dependency graph** — `/admin/reports/frontend-assets/dependency-graph` — how
  libraries depend on one another.
- **All** — `/admin/reports/frontend-assets/all` — the full asset list.

## Export findings

Each report section has a CSV/JSON export at
`/admin/reports/frontend-assets/export/{section}`, so you can pull the results out for
a build task, a ticket, or a spreadsheet.

## Permissions recap

- **Access frontend asset debugger** — view reports (read‑only; developer‑friendly).
- **Administer frontend asset debugger** — change settings and run scans
  (**restricted**; trusted admins only).
