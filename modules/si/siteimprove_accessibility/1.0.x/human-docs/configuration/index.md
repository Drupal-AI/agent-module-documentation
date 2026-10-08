# Configuration

Setup has three parts: grant the permissions to the right roles, set the scan
options on the settings form, and enable the REST resources that carry scan data.

## Grant the permissions

On the People → Permissions page, grant these to the appropriate roles:

| Permission | What it grants |
|---|---|
| **Run siteimprove_accessibility scan** (`run siteimprove_accessibility scan`) | Run scans, view the reports, and create scan entities. This is the everyday editor permission. |
| **Administer siteimprove_accessibility configuration** (`administer siteimprove_accessibility configuration`) | Access the settings form. Marked *restrict access* — give it only to trusted admins. |
| **Delete siteimprove_accessibility scan** (`delete siteimprove_accessibility scan`) | Delete scan entities. Also *restrict access*. |

## Set the scan options

Log in as a user with **`administer siteimprove_accessibility configuration`** and
go to **`/admin/config/siteimprove_accessibility/settings`**. Two toggles control
how scanning behaves:

- **Enable manual scans** (`enable_manual_scans`) — *default: enabled*. Shows or
  hides the manual scan button, so editors can trigger a scan on demand.
- **Preview auto‑scan** (`preview_auto_scan`) — *default: enabled*. Automatically
  runs a scan while a node is being previewed, so results appear without an
  explicit click.

## Enable the REST resources

The scan data flows through REST resources, which must be enabled and permissioned
before the front‑end can read or write scan data. The resources are:

- **Save scan** — `POST /siteimprove-accessibility/save-scan`, where the client
  posts Alfa's results back. It uses cookie authentication, so callers also need a
  valid `X-CSRF-Token`.
- **Issues**, **pages with issues**, **daily stats**, and **a node's latest
  scan** — read resources for building dashboards and reports.

Enable each resource (for example with the REST UI module or in configuration),
then grant the matching per‑resource REST permission — for the save‑scan resource
that is `restful post siteimprove_accessibility_alfa_scan_resource`.

## Using it day to day

Once configured, editors scan a page from its node edit form (or automatically on
preview), and review results in the reporting dashboards at
`/admin/reports/siteimprove_accessibility`. A cron job aggregates each day's scans
into the daily statistics that power the compliance‑history trend view.
