# Views Serialization Pager — manual setup guide

**Views Serialization Pager** (`views_serialization_pager`) solves a small but
common annoyance with Drupal's REST Export views: the standard serializer returns
just a bare array of rows, with no information about paging. This module adds a
Views format — **Serialization with Pager** — that wraps the serialized rows
together with pager metadata, so a decoupled or JavaScript front end knows which
page it is on and how many there are.

Where the core serializer outputs `[ …rows… ]`, this style returns a structured
envelope:

```json
{
  "rows": [ /* your serialized rows */ ],
  "pager": {
    "current_page":   0,
    "total_items":    42,
    "total_pages":    5,
    "items_per_page": 10
  }
}
```

That extra `pager` block is exactly what a single‑page app needs to build "Page X
of Y" controls, drive a "load more" / infinite‑scroll button, or fetch the next
page — without issuing a separate count query. The rows are serialized to whatever
format the request negotiates (JSON, XML, or any registered format), so the same
endpoint can serve several clients.

It is a developer / site‑builder tool: one Views style plugin, no settings of its
own, no permissions, no config. You use it by switching an existing REST Export
view's format to this style. It builds on Drupal core's **Serialization** and
**Views** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. You use it inside the Views UI at **Structure → Views**
(`/admin/structure/views`), by choosing **Serialization with Pager** as the
**Format** on a REST Export display.

## How to use it

1. Go to **Structure → Views → Add view** and enable **Provide a REST export**
   (or add a **REST Export** display to an existing view).
2. Set the display's **Path** — this is the URL your front end will request.
3. Under **Format**, choose **Serialization with Pager** in place of the default
   Serializer.
4. In the format settings, tick the accepted request formats you want to serve
   (for example **json** and **xml**).
5. Set the **Pager** to **Full** (a "paged, full pager"). This matters: the pager
   metadata — especially `total_pages` — is only computed for a full pager. With
   the "Display all items" or "Display a specified number of items" pagers you
   still get your `rows`, but `total_pages` will be `0`.
6. Save the view. Request the path (optionally with `?page=1`) and you get the
   `{ rows, pager }` envelope back.

Tip: pick the row plugin that suits you — **Data (entity)** runs whole entities
through the normalizers, while **Data (field)** outputs field values directly.
