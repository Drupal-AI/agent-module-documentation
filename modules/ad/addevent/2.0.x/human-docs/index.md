# AddEvent — manual setup guide

**AddEvent** (`addevent`) connects your Drupal site to the third-party
[AddEvent](https://www.addevent.com/) service, which powers the familiar "Add to
Calendar" and "Subscribe to Calendar" buttons you see on event websites. Visitors
click a button and add your event to their Google, Outlook, or Apple calendar — or
subscribe to a calendar feed that stays up to date as your events change. AddEvent
does the heavy lifting of building the calendar entries; this module wires its
widgets into Drupal.

You give the module one thing to work with: an **AddEvent API token** from your
AddEvent account, entered on a single settings page. From there you can surface
the calendar widgets in three ways — as **blocks** you place through Block Layout
(*Add to Calendar* and *Subscribe to Calendar*), or as a dedicated **field** you
add to a content type and render with one of two formatters (a **button** or a
plain **link**).

The token and all configuration are locked behind an admin permission. There are
no public endpoints on your site — when a visitor interacts with a button, that
happens client-side against AddEvent's own service, not your Drupal backend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your AddEvent API token, then
   place blocks or add the AddEvent field to your content.

## Where it lives in the admin menu

The settings page sits at **Configuration → Web services → AddEvent settings**
(`/admin/config/services/addevent/settings`). You need the **Administer addevent
settings** permission to open it. Blocks are placed under **Structure → Block
layout**, and the AddEvent field is added per content type under **Structure →
Content types → Manage fields / Manage display**.
