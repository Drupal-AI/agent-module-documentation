# Canvas Palette — manual setup guide

**Canvas Palette** (`canvas_palette`) adds a set of pre‑built, styled components
to **Canvas**, Drupal's Experience Builder page builder. Think of it as a palette
of ready‑made "fancy" building blocks that go beyond the basics — components that
integrate with core **Image** and **Views** and with the **Webform** module — so
editors have richer pieces to assemble pages from.

It is a component library for site building and theming. The components carry no
content or access role of their own; access to what a component displays follows
the referenced content (for example, a Views‑ or Webform‑backed component shows
only what the viewer is allowed to see). It depends on **Canvas**, core **Image**
and **Views**, and **Webform**, and supports Drupal 10.3+ and 11. The module
declares its own permission.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Canvas, Image, Views, and Webform are required).

## Where it lives in the admin menu

Canvas Palette adds no settings form of its own. Its components appear in the
Canvas page builder. It does declare a permission, so review it at **People →
Permissions** (`/admin/people/permissions`) and grant it to the roles that should
use these components.

## How to use it

While building a page in Canvas, choose from the extra styled components this
module adds — including ones that pull in images, Views listings, or webforms —
and place them into your layout. Because component output follows the underlying
content's access rules, each viewer only sees what they are permitted to see.
