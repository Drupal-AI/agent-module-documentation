# Menu Export CSV — manual setup guide

**Menu Export CSV** (`menu_export_csv`) adds a **Download CSV** link to each
menu's management page, so you can export a menu's link structure — titles, URLs,
and hierarchy — to a CSV file. It is handy for reviewing a menu outside Drupal,
documenting your navigation, or preparing to migrate a menu somewhere else.

The problem it solves is getting your menu's contents out of the admin UI and
into a spreadsheet-friendly format in one click, without writing an export script
or querying the database by hand.

It is an **administration/export feature** run by administrators. The exported
data reflects your menu configuration (administrative data), and the module adds
no access control of its own. Its only dependency is core's **Menu UI**
(`menu_ui`) module, and it sits in the Custom package.

There is no settings page — the export is simply a link on the menu management
screen, described under "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — Menu Export CSV has no settings form. The
export link appears on the menu management page once the module is enabled.

## Where it lives in the admin menu

It works from the standard menu system at **Structure → Menus**
(`/admin/structure/menu`).

## How to use it

1. Go to **Structure → Menus** (`/admin/structure/menu`).
2. Click into the menu you want to export, for example the **Administration** menu
   at `/admin/structure/menu/manage/admin`.
3. Click the **Download CSV** link at the bottom of the page (the download route
   is `/admin/structure/menu/manage/{menu}/download`).
4. Your browser downloads a CSV of that menu's links — their titles, URLs, and
   hierarchy — ready to open in a spreadsheet.
