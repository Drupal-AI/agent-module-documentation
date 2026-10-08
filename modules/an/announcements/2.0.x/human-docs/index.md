# Announcements — manual setup guide

**Announcements** (`announcements`) manages site announcements — configurable
notices you show to visitors as banners, alerts, or promotions. Two things make it
more than a static banner: each announcement can have **display conditions** (so it
appears only on the pages you choose), and it can be **dismissed** by the visitor,
with the dismissal remembered in a browser cookie so it does not keep reappearing.

Under the hood it uses the **Condition Field** module for the display rules and the
**JS Cookie** library module for the dismissal cookie. The announcement content is
written by an administrator, so treat the markup you enter as trusted — it is shown
to visitors as‑is. The module provides its own permissions and has no
access‑control role beyond them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its two
   dependencies) and enable the module.

## Where it lives in the admin menu

The module ships its own announcement management UI and permissions. After enabling
it, look under **Content** or **Configuration** for the Announcements admin screens,
and review **People → Permissions** for the announcement permissions it adds so the
right roles can manage notices.

## How to use it

1. Enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Create an announcement, entering the message to display.
3. Set the **display conditions** (via Condition Field) so the announcement shows
   only where you want it — for example on specific pages or content types.
4. Choose whether visitors can dismiss it; if so, a dismissal is stored in a
   cookie so the same visitor is not shown it again until the cookie expires.

Because it sets a dismissal cookie, keep that in mind for any cookie‑consent
requirements on your site.
