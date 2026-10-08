# Content Planner — manual setup guide

**Content Planner** (`content_planner`) gives editorial teams a place to plan, schedule, and
track content as it moves through its moderation workflow. It has three parts: a configurable
admin **Dashboard**, a **Content Calendar**, and a **Content Kanban** board. The dashboard
aggregates widgets — a team roster with each editor's moderation stats, any View you want to
embed (say "unpublished articles"), and free‑form Text/HTML notes — and you can reorder, retitle,
and role‑restrict each one. The calendar lays your content out month by month (drag a node to
reschedule it, colour‑code by content type, duplicate a node as a template), and the kanban board
shows nodes as cards grouped by moderation state that you drag between columns to transition them.

Because planning is built on Drupal's Content Moderation, the boards only show something useful
once you have a moderation **workflow** with at least one enabled content type — that's the key
prerequisite to get right. The module leans on a few dependencies: core's **Image** and **Content
Moderation** modules and the contrib **Scheduler** module (for publish scheduling). Installing the
base module automatically enables its two submodules, **Content Calendar** (`content_calendar`)
and **Content Kanban** (`content_kanban`), so you get the whole suite at once.

The base module works as soon as it's enabled — the dashboard is immediately available and a
toolbar shortcut links to it — but you'll want to configure which widgets appear, and set up a
moderation workflow so the calendar and kanban have content states to work with. Two permissions
gate the base module (view the dashboard; administer its settings). For developers, the dashboard
is extensible: widgets are a `dashboard_block` plugin type you can add to.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module (which brings
   in the calendar and kanban submodules), and note the dependencies.
2. [Configuration](configuration/index.md) — set up the dashboard widgets, permissions, the
   moderation‑workflow prerequisite, and where the calendar and kanban live.

## Where it lives in the admin menu

The dashboard is at **/admin/content-planner/dashboard** (there's a *Content Planner* toolbar
item too). Its widget settings are at
**/admin/content-planner/dashboard/settings**. The calendar and kanban add their own pages under
the same Content Planner area.

## How to use it

At a glance: make sure you have a Content Moderation workflow covering the content types you plan,
open the dashboard settings to add and arrange widgets, then use the calendar and kanban to
schedule and move content through its states. The full walkthrough is in
[Configuration](configuration/index.md).
