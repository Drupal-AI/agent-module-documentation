# LocalGov Irish Planning Notices — manual setup guide

**LocalGov Irish Planning Notices** (`localgov_irish_planning_notices`) sets up the
content structure an Irish council needs to publish its statutory **weekly planning
notices**. When enabled it provides a dedicated content type for planning notices,
plus a listing so visitors can browse the notices published each week. File handling
for the notice documents is managed through the Filefield Paths module.

This is a content-and-publishing feature rather than an access-control or integration
tool: the notices are ordinary published content, public by intent, and follow
Drupal's normal content-access rules. Once the module is on, editors create planning
notices as they would any other content, and the accompanying listing surfaces them
for the public.

Because it is part of the **LocalGov Drupal** distribution, it is designed to fit the
LocalGov content model and themes, and is aimed specifically at councils in Ireland.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and pull in its Filefield Paths dependency.

There is **no configuration page** for this module — it ships its content type and
listing ready to use. Day-to-day work happens in the content-authoring UI, described
under "How to use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own (`configure` is `null`). You work
with it through the standard content UI:

- **Content → Add content** (`/node/add`) — where the *planning notice* content type
  appears once the module is enabled.
- The planning-notices **listing** page, which presents the weekly notices to
  visitors.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Content → Add content** and choose the planning-notice content type.
3. Fill in the notice details and attach the relevant documents — Filefield Paths
   organises the uploaded files for you.
4. Publish. The notice appears in the weekly planning-notices listing for the public
   to browse.
