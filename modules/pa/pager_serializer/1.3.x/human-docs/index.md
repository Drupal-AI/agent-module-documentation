# Pager Serializer — manual setup guide

**Pager Serializer** (`pager_serializer`) solves a common headache for decoupled
Drupal sites: a standard Views **REST export** returns a bare array of rows with
no pagination information. A React, Vue, or Next.js front-end that wants to render
"Page 3 of 12" or an infinite-scroll "load more" button has no idea how many
records exist or which page it is on. Pager Serializer fixes that by wrapping the
serialized rows alongside a **pager object** carrying the current page, total
items, total pages, and items per page.

It works by providing a new Views style plugin — **"Pager serializer"** — that you
select on a REST export display instead of the default "Serializer". The endpoint
then returns something like `{ "rows": [...], "pager": { "current_page": 0,
"total_items": 42, "total_pages": 5, "items_per_page": 10 } }` instead of a plain
list. Every one of those JSON keys is configurable, so you can match whatever
contract your front-end expects, rename or drop individual pager fields, and
choose whether the pager sits in its own nested object or is flattened onto the
top-level response.

The module depends only on core's **REST** module, adds no permissions of its own,
and ships sensible defaults so it works as soon as you pick the style. For
advanced cases, each output row can be enriched or modified in a custom module via
`hook_pager_serializer_row_alter()`.

This guide is written for a **human** building and configuring a View. If you want
terse, token-cheap references for an AI coding agent — the exact plugin id, output
shapes, and config keys — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and the required REST module).

Because this is a Views/developer module rather than a click-through feature, its
usage and its settings form are both described below rather than on a separate
page.

## Where it lives in the admin menu

You apply the style inside the Views UI at **Structure → Views**
(`/admin/structure/views`). The module's own settings — which control the JSON key
names and which pager fields are included — live at **Configuration → Web services
→ Pager Serializer** (`/admin/config/pager_serializer`), available to users with
the **Administer site configuration** permission.

## How to use it

1. Enable the module (and core's **REST** module, which it depends on).
2. Create or edit a View that has a **REST export** display.
3. In the display's **Format** settings, change the style from **Serializer** to
   **Pager serializer**. Choose your accepted formats (JSON, XML, and so on) as
   usual.
4. Add a **pager** to the display — Full, Mini, "Display a specified number", or
   "Display all items". The pager object in the output is built from whichever you
   choose, and the module normalises the counts sensibly for the "specified
   number" and "all items" cases.
5. Save the View and visit the REST export path. The response now includes both
   the rows and the pager metadata.

## Customising the JSON output

Open **Configuration → Web services → Pager Serializer**
(`/admin/config/pager_serializer`) to tailor the shape of the response. The
settings are:

- **Rows label** (`rows_label`, default `rows`) — the property name the serialized
  rows are returned under.
- **Pager object enabled** (`pager_object_enabled`, default on) — when on, the
  pager fields are grouped inside their own object; when off, they are flattened
  onto the top level of the response alongside the rows.
- **Pager label** (`pager_label`, default `pager`) — the name of that nested pager
  object (used only when the pager object is enabled).
- **Current page** — enable/disable (`current_page_enabled`, default on) and rename
  (`current_page_label`, default `current_page`).
- **Total items** — enable/disable (`total_items_enabled`, default on) and rename
  (`total_items_label`, default `total_items`).
- **Total pages** — enable/disable (`total_pages_enabled`, default on) and rename
  (`total_pages_label`, default `total_pages`).
- **Items per page** — enable/disable (`items_per_page_enabled`, default on) and
  rename (`items_per_page_label`, default `items_per_page`).

Label fields are required (they cannot be left blank). With the defaults you get:

```json
{ "rows": [ ... ], "pager": { "current_page": 0, "total_items": 42, "total_pages": 5, "items_per_page": 10 } }
```

Turning **Pager object enabled** off flattens it:

```json
{ "current_page": 0, "total_items": 42, "total_pages": 5, "items_per_page": 10, "rows": [ ... ] }
```

Click **Save configuration** when done. If you ever want to start over, a reset
form at `/admin/config/pager_serializer/reset` restores all of the shipped
defaults. The settings live in the exportable `pager_serializer.settings` config
object, so they can be deployed across environments; the [`agent/`](../agent/start.md)
docs list the Drush commands for setting them from the CLI.
