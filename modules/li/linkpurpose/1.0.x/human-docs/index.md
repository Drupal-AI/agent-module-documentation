# Link Purpose Icons — manual setup guide

**Link Purpose Icons** (`linkpurpose`) adds small icons and screen-reader hints to
links whose behavior differs from a normal in-page link — external links, links
that open a new window, downloads, document links (PDF, DOCX), app links, email
(`mailto:`) links, and phone (`tel:`) links. The result tells users what will
happen *before* they click, and helps a site meet WCAG's requirement that a link's
purpose be programmatically determinable.

Under the hood it is a configuration-driven wrapper around a bundled "Link
Purpose" JavaScript library. On every non-admin page it scans your links and, for
each of seven "purposes," can add a visual icon, a visually-hidden message for
screen readers (for example "Link is external"), or both. It deliberately never
runs on admin routes, and it skips the admin toolbar by default.

Everything is optional and every category can be tuned: you can toggle each
purpose on or off, change its screen-reader message, restrict it with a CSS
selector, swap in your own icons, and choose whether the icon sits before or after
the link text. A few global options let you decide which page regions to scan,
which links to ignore, treat partner domains as "internal," and add behaviors like
forcing external links to open in a new window or adding `rel="noreferrer"`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the full list of
config keys — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Link Purpose Icons**
(`/admin/config/user-interface/linkpurpose`) and requires the *Administer
linkpurpose* permission. The module works as soon as it is enabled — every purpose
is on by default — so the form is about refining, not switching on, the behavior.

## How to use it

Enable the module and the icons and hints appear on non-admin pages right away.
Open the settings form to adjust things. The main controls are:

- **The seven link purposes** — *External*, *New window*, *Download*, *Document*,
  *App*, *Mail*, and *Tel*. Each is a simple on/off toggle (all on by default) with
  a default screen-reader message you can rewrite (useful for translation or
  house wording). For each purpose you can also set a custom selector, custom CSS
  classes, and your own icon and its position (before or after the link).
- **External-link behaviors** — optionally force external links to open in a new
  window, and/or add `rel="noreferrer"` to them for privacy.
- **Which regions to scan** — a *roots* selector limits marking to, say, the main
  content area, and an *ignore* selector excludes menus or widgets (the admin
  toolbar is ignored out of the box). You can also mark links inside shadow-DOM
  web components.
- **Conditional running** — skip marking entirely when a given element is present
  or absent on the page, suppress the visible icon on chosen links (keeping just
  the screen-reader hint), and avoid double-marking links that wrap an image.
- **Treating extra domains as internal** — list additional domains so links to
  partner sites are not flagged as external.

Click **Save configuration** to apply. Because the settings are stored as ordinary
configuration (`linkpurpose.settings`), you can also manage them with
`drush cget` / `drush cset` and deploy them between environments. Clearing a value
restores the library's own built-in default.
