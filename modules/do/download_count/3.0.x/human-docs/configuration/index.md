# Configuration

Download Count works as soon as it is enabled and your file fields are private, but
there are a few things to set up to get the most from it: confirm the private‑file
prerequisite, add the display surfaces (formatter and blocks), set permissions
carefully, and know where the reports live.

## Prerequisite: private file fields

Counting only happens for files in **private** file fields (see
[Installation](../installation/index.md) for why). Before anything else, make sure
the fields you care about use the **Private files** upload destination in their
field settings. This is the most common cause of counts staying at zero.

## Open the settings form

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → Media → Download Count**
   (`/admin/config/media/download-count`).

From here you can adjust the module's settings and clear the download data if you
ever need a clean slate (the "clear" action lives under this settings area at
`…/download-count/clear`).

## Show download counts next to a file

On a content type's **Manage display** (**Structure → Content types → *(type)* →
Manage display**), set your private file field's format to Download Count's field
formatter. It renders the file with its download count and a small Peity‑based
**sparkline** showing downloads over time.

## Place the reporting blocks

Under **Structure → Block layout**, the module provides blocks you can place in any
region:

- **Top downloads** — the most‑downloaded files.
- **Recent downloads** — the files downloaded most recently.

## Read the reports

The main report is at **Reports → Download count**
(`/admin/reports/download-count`). From there you can drill into per‑entry detail,
reset an individual file's counter, and export data. The module also provides full
**Views** integration (fields, filters, and sort handlers, plus sample views) if
you want to build your own reports, and basic **Rules** integration for triggering
actions on download activity.

## Permissions — read these carefully

Download Count declares four permissions on **People → Permissions**:

- **View download counts** (`view download counts`)
- **Reset download counts** (`reset download counts`)
- **Export download counts** (`export download counts`)
- **Skip download counts** (`skip download counts`)

Two important caveats:

- **Only `view download counts` is actually enforced.** The reset and export
  routes both require `view download counts`, and the `reset download counts` and
  `export download counts` permissions are not checked anywhere. In practice this
  means a role you grant `view download counts` to can *also* reset counters and
  export the full per‑download log (which includes user id, IP address, and
  referrer). Treat `view download counts` as a privileged, trusted‑staff
  permission — do not hand it out as a harmless read‑only role.
- **`skip download counts` stops counting but not logging.** Granting it to a role
  exempts that role from the statistics, but each of their downloads still writes a
  log notice naming the user, the file, and the IP address. Assign it to
  staff/admin roles to keep internal traffic out of the figures, but be aware of
  this logging behavior.

## Privacy and retention

Each recorded download stores user id, IP address, and referrer — identifiable
data. If you operate under GDPR or similar rules, decide on a retention period and
mention this logging in your privacy notice. Uninstalling the module drops its
tables, but nothing prunes the data automatically while the module remains enabled.
