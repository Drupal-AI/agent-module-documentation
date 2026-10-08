# Atom — manual setup guide

**Atom** (`atom`) adds an **Atom feed display style for Views**. It lets any View
output an Atom syndication feed — an alternative to the RSS feed style that Drupal
core provides — so feed readers and other systems can subscribe to a listing of
your content.

The feed content comes entirely from the View, and it respects the View's access
rules, so only content a visitor is allowed to see appears in the feed. The module
depends on core **Views** and runs on Drupal 8 through 11. It has no settings page
of its own — you configure everything inside the View where you attach the feed.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Atom has no dedicated admin page. You work with it inside the Views UI at
**Structure → Views** (`/admin/structure/views`), where "Atom feed" becomes an
available feed display style.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit (or create) a View at **Structure → Views** and add a **Feed** display.
3. For that feed display, choose **Atom** as the feed format instead of the
   default RSS style, then configure the field/row mapping the feed should output.
4. Save the View. The feed is now served at the path you gave the display, as an
   Atom document that respects the View's access settings.
