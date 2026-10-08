# Configuration

Digital Asset Inventory's settings are split across three sub‑forms under
**Configuration → Accessibility → Digital Asset Inventory**, all reachable only by
users with the **Administer digital assets** permission:

- **Settings** (`/admin/config/accessibility/digital-asset-inventory`) — the
  scanner and title‑resolution options.
- **Archive** (`…/archive`) — turn the archiving system on or off and label it.
- **Registry** (`…/registry`) — the content of the public archive registry page
  (only available once archiving is enabled).

## Scanner settings

These control how a scan runs, which matters most on large sites:

- **Excluded directories** and **Excluded filenames** — paths and filenames to
  skip during a scan.
- **Scan batch time budget** (default 10 seconds) — how long each batch step is
  allowed to run before yielding.
- **Stale scan lock threshold** (default 300 seconds) — after this long, a held
  scan lock is treated as stale and can be broken (also forced with
  `drush dai:scan --force`).

## Title‑resolution settings

The module can fetch remote page titles for external links (safely — private and
reserved IPs are rejected). Tune it here:

- **Title resolution enabled** (default on).
- **Timeout** (default 3 seconds) — how long to wait for each external fetch.
- **Max per cron** (default 50) — how many external titles to fetch on each cron
  run, so cron stays responsive.
- **Retry after days** (default 7) — how long before re‑attempting an item whose
  title couldn't be resolved.

## Archive feature flags

The Archival Management System is **off by default**. Turn it on with these flags
(on the Archive sub‑form):

- **Enable archive** — turns on the whole archiving system and its routes.
- **Enable manual archive** — lets editors add archive entries by hand for assets
  the scanner didn't discover.
- **Allow archive in use** — permit archiving assets that are still referenced.

These flags don't just show or hide UI — they back access checks, so archive
routes are denied when the corresponding feature is off, on top of the permission
checks below.

## Archive label and registry display

- **Show archived label** (default on) and **Archived label text** (default
  "Archived").
- **Archive registry heading** options and **styled box** toggle.
- **Archive registry intro** — the HTML shown on the public `/archive-registry`
  page. It ships with ADA Title II boilerplate you can replace.

## Asset type map

An advanced **asset types** map defines how each kind of asset is recognized —
local types by file extension and MIME type, external providers by URL pattern
(Google Workspace, YouTube, Vimeo, SharePoint, OneDrive, Dropbox, Box, DocuSign,
Qualtrics, SurveyMonkey, Typeform, Canvas, Panopto, Kaltura, Zoom, and many more).
If you use a provider that isn't recognized, add or adjust an entry here.

## Permissions

Grant these on **People → Permissions** (none are marked security‑restricted, so
scope them deliberately):

| Permission | What it allows |
|---|---|
| **Administer digital assets** | Full management and all three settings sub‑forms. |
| **View digital asset inventory** | The inventory and dashboard pages. |
| **Scan digital assets** | Run scans and the Resolve External Titles form. |
| **Delete digital assets** | Delete an asset from the inventory. |
| **Archive digital assets** | Queue, execute, cancel, and unarchive; manual archive entries; toggle visibility; attestations; archive CSV export; add notes. Bundles many state‑changing operations — grant only to records‑management roles. |
| **View digital asset archives** | Read‑only archive management and notes. |
| **View digital asset orphan references** | View orphan reference details. |

The module also ships an optional **Digital Asset Manager** role
(`digital_asset_manager`) as a ready‑made bundle of view/manage access.

A note on the public archive registry: the page at
`/archive-registry/{id}` is publicly reachable **by design** (it's a public
reference registry), but the controller enforces visibility per archive status —
public archives show full details, admin‑only archives hide the file from
anonymous users, and deleted/queued ones return 404 to the public.

## Running scans

Once configured, run a scan from the **Scan** form (needs *Scan digital assets*)
or from the command line:

```bash
drush dai:scan            # full scan, or resume from a checkpoint
drush dai:scan --force    # clear a stuck lock and start fresh
drush dai:status                 # show inventory status and last-scan results
drush dai:status --format=json   # machine-readable, for monitoring
```
