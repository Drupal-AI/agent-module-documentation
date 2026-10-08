# OGCB Suite — manual setup guide

**OGCB Suite** (`ogcb_suite`) is the companion module suite for the **Open
Government Community Builder (OGCB)** — a Drupal recipe/starter kit for building
community platforms. It bundles the features and integrations that power an OGCB
site: the shared configuration, helpers, and glue code that tie the distribution's
components together.

The important thing to understand before installing is that **OGCB Suite is
designed to run as part of OGCB, not on a standalone Drupal site.** It assumes
OGCB's content model — its group types, node bundles, view modes, and configuration
— so on a site that doesn't have that model in place, its features have nothing to
attach to. In normal use you don't install this module by itself; it comes along
when you build a site from the OGCB recipe/starter kit.

The functionality is split into focused sub‑modules so each part of the platform can
be enabled independently. These include, among others:

- **OGCB Group** — the core group functionality: a group dashboard, group menu,
  mute/unmute blocks, group tokens, the locations map, wiki‑root handling, and Views
  integration such as deriving the current group from the node in the URL.
- **OGCB Notification** — the notification layer, built on DANSE and Push Framework:
  an in‑app notification channel and events for comments, likes, membership
  requests (request/approval/rejection), and new user registrations.
- **OGCB Search** — search features on top of Search API and Facets, including a
  header search block and processors that expose group status and enforce group
  access on indexed content.
- **OGCB User** — user profile enhancements: a user actions block, author block,
  header login button, and user menu block.
- **OGCB Private Messages** — a chat‑style messaging interface built on the Private
  Message module.
- **OGCB Helpers** — project‑wide refinements: a hero block, a marketing block,
  comment access handling, Leaflet map adjustments, and theme tweaks.
- **OGCB German Languagepack** — a starting point for running OGCB in German.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (normally as part
   of the OGCB recipe) and enable the sub‑modules you need.

There is no single settings form for the suite; each sub‑module brings its own
features and configuration.

## How to use it

1. The intended path is to build a site from the **OGCB recipe/starter kit**, which
   installs this suite together with the content model it depends on.
2. Once OGCB is in place, enable only the sub‑modules you need — for example OGCB
   Group for the group dashboard and menu, OGCB Notification for in‑app
   notifications, or OGCB Search for the search block — since the suite is
   deliberately split so each part can be turned on independently.
3. Because each sub‑module targets a specific part of the OGCB platform, refer to
   OGCB's own documentation for how the pieces fit together on a finished site.
