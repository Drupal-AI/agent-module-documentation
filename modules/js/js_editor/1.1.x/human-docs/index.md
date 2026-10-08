# Javascript Editor — manual setup guide

**Javascript Editor** (`js_editor`) lets administrators add custom JavaScript to a
theme straight from the browser, using a rich text editor with syntax
highlighting — no need to touch theme files or deploy code. It attaches itself to
each theme's settings page: turn it on for a theme, paste in your JavaScript, save,
and that code runs on the front end for that theme. You can enable it on more than
one theme on the same site.

It's the JavaScript counterpart to the CSS Editor module, and it overlaps with
Asset Injector — the distinguishing feature here is that the configuration lives
right inside the theme's own settings form.

> **Important — this is a highly privileged, dangerous feature.** Any JavaScript
> you save here runs in *every visitor's browser*. That means the permission to
> use it is, in practice, equivalent to full control of the site: someone with it
> could steal sessions and credentials, deface pages, or exfiltrate data. Treat
> the **Execute arbitrary js_editor scripts** permission exactly like
> "Administer filters" or PHP execution — grant it **only** to fully trusted
> administrators, never to content editors.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enabling the editor per theme and
   entering your custom JavaScript.

## Where it lives in the admin menu

There's no standalone settings page. The custom‑JS controls appear at the bottom
of each theme's settings form, under **Appearance → *(theme)* → Settings**
(reachable from `/admin/appearance`).
