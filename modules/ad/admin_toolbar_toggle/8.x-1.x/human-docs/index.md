# Admin Toolbar Toggle — manual setup guide

**Admin Toolbar Toggle** (`admin_toolbar_toggle`) adds a small front-end
convenience: a keyboard shortcut that hides or shows the Drupal admin toolbar
while you are viewing the site. It lets an administrator or editor preview a page
without the toolbar taking up screen space at the top, then bring it back with the
same shortcut — without navigating away or reloading the page.

It is a UI-only enhancement layered on top of core's **Toolbar** module. It
carries no content or access role of its own; the only permission it adds is
`administer admin toolbar toggle settings`, which gates the module's own settings.
It is safe to grant to any role that already sees the toolbar. The module supports
Drupal 9.2 and up, including 10 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The toggle itself is used from the front end via its keyboard shortcut; there is
no admin page you need to visit for day-to-day use. The module does define an
`administer admin toolbar toggle settings` permission that governs its own
settings, so grant that on **People → Permissions** to the roles that should be
able to adjust it.

## How to use it

Once enabled, users who can see the admin toolbar can press the module's keyboard
shortcut while browsing the site to hide the toolbar, and press it again to bring
it back — the preference persists so the toolbar stays in the state you left it.
Use it to preview a clean layout without the toolbar's strip at the top of the
window. There is no required configuration; it works as soon as it is enabled.
