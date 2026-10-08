# Configuration

Setting up Library Management System is mostly about deciding **who can manage the
catalogue**, setting your **fine amounts**, and — if you have existing data —
using the **import** tools. There is no single settings page; the pieces live
across the module's admin screens.

## Permissions — who can manage what

Grant these under **People → Permissions** (`/admin/people/permissions`). Each
entity type is gated by its own **`administer …`** permission (for example
`administer lmsbooks`), and viewing, editing, and deleting individual records goes
through Drupal's standard entity access. Give the management permissions to your
library‑staff roles only.

- **`administer lmsbooks`** (and the sibling `administer …` permissions for
  publications, authors, requested books, and issued books) — control access to
  the admin list/add/edit/delete screens, the CSV import forms, the fine settings,
  and the reports. These are your staff‑only permissions.

> **Worth knowing about the request route:** a patron requests a book from the
> book's own page, and that route is gated only by the core **Access content**
> permission. In practice that means the request action is available to anyone who
> can view content on the site. Keep that in mind when deciding who can reach the
> catalogue, and treat requests as untrusted input that staff confirm before
> issuing.

## Fine amounts

The module provides a **fine settings** form (in the admin area, behind the
`administer lmsbooks` permission) where you set the fine charged for overdue
books. Set this to match your library's policy before you start issuing books, so
that overdue calculations use the right amount.

## Importing existing data

Rather than entering everything by hand, use the **import forms** to bulk‑load
authors, publications, books, and users from **CSV, JSON, or Excel** files.
Prepare a file in the expected column layout and upload it from the relevant import
screen. There are matching **export** options for the same data and for the report
data, which is useful for backups or moving data between sites.

## Reports

The module includes report pages covering authors, publications, books, requested
books, and issued books. These are read‑only overviews gated by the same
`administer …` permissions — use them to see the state of the collection and its
circulation at a glance.
