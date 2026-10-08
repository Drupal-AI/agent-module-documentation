# Configuration

Using Markdown Index is a two‑step routine: pick the folders to scan on the
settings form, then read files on the report.

## Step 1 — Choose which folders to scan

1. Log in as a user with the **Administer Markdown Index configuration** permission
   (a restricted‑access admin permission — see below).
2. Go to **Configuration → System → Markdown Index Settings**, or navigate directly
   to `/admin/config/system/markdown-index`.

The form offers four checkboxes, one per scannable location. Each one's description
shows the actual resolved path on your site, so you can confirm exactly what will be
scanned:

- **Project root** (`files_root`) — the `.md` files at the top of your project (one
  level above the docroot).
- **`modules/contrib`** (`files_contrib`) — documentation shipped by contributed
  modules.
- **`modules/custom`** (`files_custom`) — your own custom modules' `README`s and
  docs.
- **`vendor`** (`files_vendor`) — Markdown inside Composer's `vendor` directory.
  This is **off by default**; leave it off unless you specifically need it, as it
  can surface a large volume of third‑party docs.

Tick the folders you want and **Save**.

## Step 2 — Read a file on the report

1. Go to **Reports → Markdown Index Report**, or navigate directly to
   `/admin/reports/markdown-index` (requires the **Access Markdown Index report**
   permission).
2. The report builds a sorted dropdown of every `.md` file found in the folders you
   enabled.
3. Pick a file from the dropdown to display its contents on the page.

## Permissions and security

The module provides two permissions, both marked **restricted access** because they
expose configuration and file contents:

- **Administer Markdown Index configuration** — change which folders are scanned.
- **Access Markdown Index report** — view the report and read file contents.

Two design choices keep this safe: the scannable folders are **fixed** to the four
locations above (you cannot point the tool at an arbitrary directory), and files are
chosen by their **numeric position** in the discovered list rather than by a path
you type, so there is no path‑traversal parameter.

Even so, the report is intended to **show on‑disk file contents** to anyone with the
report permission — including, if you enable it, documentation from `vendor`. Grant
**Access Markdown Index report** only to trusted maintainers, and leave the
`vendor` folder unchecked unless you have a specific reason to include it.
