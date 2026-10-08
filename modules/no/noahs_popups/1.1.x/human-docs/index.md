# Noahs Popups — manual setup guide

**Noahs Popups** (`noahs_popups`) is an add-on for the
[Noahs Page Builder](../../../noahs_page_builder/3.0.x/human-docs/index.md) that
lets editors build popups and modals visually — using the same drag-and-drop
builder — and show them to site visitors. Whether you want to highlight a
promotion, post an announcement, or nudge users with a targeted message, you
compose the popup in the builder and control when and where it appears, without
writing any code.

Popups support smart **display conditions** (site-wide, on selected pages, or by
content type, with include/exclude rules), flexible **triggers** (on page load
with an optional delay, or after the visitor scrolls a set distance), and
**close/reappearance rules** (what happens after a popup is dismissed, and how
long before it can show again — in seconds, minutes, hours, or days). Popups load
asynchronously and the manager decides in real time which one to display, so
multiple popups coexist without conflicts.

Because it builds on Noahs Page Builder, it **requires that module** and shares
its **Administer Noahs** permission (`administer noahs_page_builder`) for all the
create/build/toggle/delete actions. The saved popup markup is served to visitors
through a lightweight public render route. There's no separate settings form —
you work entirely from the popup admin pages, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Noahs Page Builder) and enable the module.

There is **no standalone settings form** — popups are created and managed from
the admin pages listed under "How to use it" below, and each popup's conditions,
triggers, and reappearance rules are set as you build it.

## Where it lives in the admin menu

The popup admin pages live alongside Noahs Page Builder under **Structure →
Noahs**: create a popup at `/admin/structure/noahs/create-popup` and see the list
at `/admin/structure/noahs/popup-list`. All builder routes require the
**Administer Noahs** permission.

## How to use it

1. Make sure you have the **Administer Noahs** permission
   (`administer noahs_page_builder`), which this module shares with Noahs Page
   Builder.
2. Go to `/admin/structure/noahs/create-popup` to create a popup, then build its
   content in the drag-and-drop editor.
3. Set the popup's **display conditions** (site-wide, specific pages, or content
   types, with include/exclude rules), its **trigger** (on load with an optional
   delay, or on scroll), and its **close/reappearance** rules.
4. Manage existing popups from `/admin/structure/noahs/popup-list` — you can
   toggle a popup's active status or delete it.
5. Active popups are served to visitors automatically; the module decides in real
   time which one to show based on your conditions and triggers.
