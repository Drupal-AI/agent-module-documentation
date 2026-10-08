# Configuration

Page View Counter is configured in two places: you **place the Counter block** where
the figure should appear, and you set a handful of **block options** that control how
counting behaves and how the number is wrapped in markup. There is also a
**dashboard** and a restricted **settings** area.

## Place the Counter block

1. Log in as a user with the **Administer blocks** permission.
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Find the region where you want the counter to appear and click **Place block**.
4. Choose the **PVC** (Page View Counter) block from the list and click **Place
   block**.

The block's configuration form is where you set the options below. Each time a new
visitor loads a page that shows the block, the count increments; repeat views from
the same visitor are de‑duplicated using cookies.

## Counter block options

- **Max time** — the amount of time a visitor must spend on the page before the view
  is counted. Raising this filters out fleeting visits (someone who bounces
  immediately) so the figure better reflects genuine reads.
- **Class** — a CSS class name applied to the counter element, so you can target it
  from your theme's stylesheet and style the number to match your design.
- **Prefix** — custom HTML placed *before* the count (for example a label like
  "Views: " or an icon).
- **Suffix** — custom HTML placed *after* the count (for example the word "views").

Set the options and save the block. Visit a page carrying the block as an anonymous
user (or in a private window) to confirm the number appears and increments.

## The counter dashboard

To review the recorded counts across your site, go to **Content → Page View
Counters**. This built‑in dashboard lists the tracked pages and their current view
totals — handy for spotting your most popular content for editorial or merchandising
decisions.

## Counter settings and permissions

The dedicated settings screen lives at **Structure → Page View Counter**
(`/admin/structure/page-view-counter-entity`). Access to it is governed by the
**Administer page_view_counter_entity** permission, which is treated as a restricted
permission — grant it only to trusted roles. The public counting endpoint, by
contrast, runs under core's *access content* permission so that anonymous visitors can
be counted.

> **Tip:** Page View Counter can also be integrated with **Views**, so you can surface
> counts inside listings you build there.
