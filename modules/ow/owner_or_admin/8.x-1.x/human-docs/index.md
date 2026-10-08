# Owner or Admin Filter — manual setup guide

**Owner or Admin Filter** (`owner_or_admin`) adds a single **Views filter** that
narrows a listing to the content owned by the person viewing it — while users who
hold the core **administer nodes** permission still see everything. It is modeled
on core's built‑in "Published status or admin user" filter, so it feels familiar
if you have used that one.

Under the hood it adds a WHERE clause using core Views' query substitutions, so
non‑administrators see rows where the author is themselves, and administrators see
all rows. It correctly adds a `user` cache context so one person's filtered
listing is never shown to another. The filter is not exposed and takes no
operator — you just drop it onto a View and it does its job.

The typical use is a "My content" listing that automatically falls back to full
visibility for administrators, without you having to build two separate Views.

One important distinction to understand before you rely on it: this is a
**display filter, not an access‑control boundary**. It shapes which rows a View
returns, but it does *not* restrict access to the underlying entities. The same
content is still reachable through its canonical URL, other Views, or the
JSON:API/REST endpoints. Use it for convenience listings; for genuine per‑user
confidentiality, use Drupal's node/entity access system instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it adds a Views filter you
use inside the Views UI, described in "How to use it" below.

## How to use it

1. Edit or create a **View** of content at **Structure → Views**
   (`/admin/structure/views`).
2. Add a **relationship** to the content author — **Content: Author** — so the
   View knows who owns each row.
3. Add a **filter criterion** and choose the Owner or Admin filter, using the
   author relationship you just added.
4. Save the View. Anonymous or regular users now see only their own content in
   that listing, while users with **administer nodes** see all of it.
