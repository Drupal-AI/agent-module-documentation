# CKEditor 5 Bootstrap Accordion — manual setup guide

**CKEditor 5 Bootstrap Accordion** (`ckeditor5_bootstrap_accordion`) lets editors
insert and edit a **Bootstrap 5 accordion** — collapsible panels, great for FAQs
or documentation sections — directly inside the CKEditor 5 rich‑text editor,
without writing any HTML. Editors get an **Accordion** toolbar button to add the
widget, add or remove panels, and toggle options like "open the first item" or
"let all items stay open." Nested (accordion‑in‑accordion) content is supported.

There are two moving parts, and you need both for accordions to actually work on
the page. First, a **CKEditor 5 plugin** provides the toolbar button and the
editing experience. Second, a companion **text‑format filter** called *Accordion
enabler* adds the runtime Bootstrap attributes (like `data-bs-toggle`,
`aria-expanded`, and so on) at render time. The stored markup stays clean —
structural classes only — and the filter wires in the Bootstrap behaviour when the
content is displayed. If you enable the button but forget the filter, the
accordions will look like plain stacked content and won't expand or collapse.

One more requirement: your **front‑end theme must load Bootstrap 5's CSS and
JavaScript**. The module ships no front‑end assets of its own — it relies on your
theme's Bootstrap for the styling and the expand/collapse animation. (The editor
UI itself works without Bootstrap.) There's no settings form, no permissions, and
no Drush — setup is entirely per text format. The only dependency is core's
**CKEditor 5** module, and it runs on Drupal 10.6+ / 11.3+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

(There's no separate configuration page — this module has no settings form. You
set it up per text format, described below.)

## Where it lives in the admin menu

There is no admin settings page. You configure everything per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to set it up

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors** and edit
   a format that uses **CKEditor 5**.
3. Drag the **Accordion** button from *Available buttons* into the **Active
   toolbar**.
4. In the same format's **Enabled filters** section, tick **Accordion enabler**.
   This is required — without it the accordion markup won't get its Bootstrap
   attributes and won't expand or collapse on the rendered page.
5. Save the format.
6. Make sure your front‑end **theme loads Bootstrap 5 CSS and JavaScript**, so the
   accordions display and animate for visitors.

## How editors use it

With the button in place, editors click **Accordion** to drop an accordion into
the content, then add/remove panels and type into each. They can set an accordion
to open its first item by default, or to let all items stay open at once. Because
the panels are built from standard Bootstrap markup, you can style them by
overriding Bootstrap 5's CSS variables in your theme. Developers can also extend
the toolbar with a custom CKEditor 5 plugin — see the
[`agent/`](../agent/start.md) docs for the `toolbarItems` config key.
