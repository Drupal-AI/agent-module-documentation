# D8: Bootstrap Tour — manual setup guide

**D8: Bootstrap Tour** (`bs_tour`) lets you build step-by-step, popover-based
guided tours of your site's interface without writing any JavaScript. It wraps
the Bootstrap Tour JavaScript plugin: you define the tour steps in an admin form,
anchor each step to an element on the page, and the module walks the visitor
through them with next/previous popovers.

It is handy for onboarding new users, introducing a redesigned interface,
highlighting a newly released feature, or walking editors through a
content-creation workflow. Each step points at a CSS selector on the page, so the
popover appears right next to the element it describes.

The tour is rendered through a **block**, so you decide exactly where it runs by
placing the "BS Tour" block in the regions and on the pages you choose — which
also lets you effectively limit it to certain roles through normal block
visibility settings.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define the tour steps and place the
   tour block.

## Where it lives in the admin menu

The tour configuration form is at **Configuration → User interface → BS Tour**
(`/admin/config/user-interface/bs-tour`), behind the module's own
`administer bs tour` permission. The tour itself appears wherever you place the
**BS Tour** block.
