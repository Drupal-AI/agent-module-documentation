# Bulk Update Fields — manual setup guide

**Bulk Update Fields** (`bulk_update_fields`) adds a content‑listing action that
lets an administrator set the same field value across many entities at once. Tick
the content you want on **Content** (`/admin/content`), choose the "Bulk Update …
Fields" action, and a short guided form walks you through picking which fields to
change, entering the new value, and confirming — then a batch process writes the
change to every selected item.

This saves you from writing a one‑off update hook every time you need a mass edit.
Typical jobs: re‑tag hundreds of articles with a taxonomy term, flip a "featured"
or "archived" boolean on a batch of nodes, point a link field at a new corporate
URL, or reset a field to blank across a content set. Date and date‑range values
are converted to the right storage format for you, and paragraph fields are handled
specially.

Because a careless mass edit can overwrite important data, the module lets you
build an **exclude list** of fields that should never be offered for bulk editing.
Core base fields (title, status, author, created, and so on) are already kept off
the picker, and you can add your own sensitive fields on the exclude form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the exclude form that keeps chosen
   fields out of bulk edits, plus the permissions.

## Where it lives in the admin menu

The action itself appears on the **Content** listing (`/admin/content`) and on
other entities' admin listings. The exclude form — the module's dedicated settings
page — is at **Configuration → User interface → Bulk update exclude fields**
(`/admin/bulk_update_fields/exclude`).

## How to use it

1. Go to **Content** (`/admin/content`) and, if you like, filter the list down to
   the items you want to change.
2. Tick the checkboxes next to those items.
3. In the **Action** dropdown choose the "Bulk Update … Fields" action and click
   **Apply**.
4. **Step 1** — choose which field or fields to change. (Anything on the exclude
   list won't appear here.)
5. **Step 2** — enter the new value for each chosen field.
6. **Step 3** — confirm on the "Are you sure?" screen. A batch then writes the new
   values to every selected entity.

You can only bulk‑edit entities you already have permission to edit — the action
respects each item's normal update access. Note that you may pick a field that
only exists on some of the selected items; the module tolerates that and simply
updates the ones that have it.
