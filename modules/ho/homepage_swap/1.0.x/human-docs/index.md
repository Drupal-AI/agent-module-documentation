# Homepage Swap — manual setup guide

**Homepage Swap** (`homepage_swap`) lets you change which page your site uses as
its front page quickly and safely, straight from the admin content area — without
digging into **Configuration → System → Basic site settings** every time. Think
of a seasonal landing page, a campaign homepage, or a "we're back" page that you
want to flip on and off with a couple of clicks.

You choose up-front which content types are allowed to become the homepage, and
then swap between the eligible pages on demand. When you switch, the module can
publish and unpublish the relevant nodes for you, so the page you promote is live
and the one you retire steps back out of the way. Because the front page is one of
the most visible things on a site, the ability to swap it is gated by its own
permission — keep that permission with trusted administrators.

The module works on Drupal 9, 10, and 11 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick which content types can become
   the homepage, grant the permission, and swap the active homepage.

## Where it lives in the admin menu

There are two places you'll use:

- **Settings** — **Configuration → Homepage Swap → Settings**
  (`/admin/config/homepage_swap/settings`), where you choose which content types
  are eligible to become the homepage.
- **Swap the homepage** — **Content → Swap Homepage**
  (`/admin/content/swap_homepage`), where you pick which eligible page is the
  active front page right now.
