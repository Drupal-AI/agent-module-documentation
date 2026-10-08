# Responsive views pager — manual setup guide

**Responsive views pager** (`responsive_views_pager`) lets a **View** show a
different number of items per page depending on the visitor's **device** —
Desktop, Tablet, or Mobile. It adds a new **"Dynamic" pager type** to Views, so
you can, for example, list twelve items per page on desktop but only four on
mobile, keeping listings light and tidy on small screens.

It identifies the device type using the **Mobile Detect** library (via the Mobile
Detect module), which reads the request's User‑Agent string and HTTP headers.
Everything is configured through the familiar Views UI — you pick the dynamic
pager on a View and enter the item counts for each device.

Two things to keep in mind. First, this affects **how many** items display per
device — it does **not** change which results a visitor may see; the View's own
access controls still apply. Second, because device detection reads the
User‑Agent, it's a **server‑side heuristic** that affects presentation only;
imperfect detection is a display nuance, not a security concern. If you run
Varnish, a CDN, or other external caching, test carefully — those layers can cache
one device's output and serve it to another unless configured to vary on device.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it and its Mobile Detect dependency.

There is **no standalone configuration page** for this module. You set it up per
View through the Views UI — see "How to use it" below.

## How to use it

1. Edit the **View** you want to make device‑aware (**Structure → Views →
   *(your view)***).
2. In the **Pager** section, click **Use pager** and choose **Paged output,
   dynamic pager**.
3. Click the pager **Settings** and enter the number of items to display for each
   device type — **Desktop**, **Tablet**, and **Mobile**.
4. **Apply** and **Save** the View.

The View now shows a device‑appropriate number of items per page. Test it on real
devices (or with browser device emulation) — and, if you use external caching,
verify the item counts vary correctly per device.
