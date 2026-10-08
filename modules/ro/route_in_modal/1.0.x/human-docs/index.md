# Route In Modal — manual setup guide

**Route In Modal** (`route_in_modal`) lets you make chosen routes open inside a
Drupal **modal dialog** — the overlay window that floats above the current page —
and submit their forms over **AJAX** without a full page reload. It's a way to add
a modal workflow to existing pages without writing any JavaScript.

You simply list the routes you want "modal‑ised" on a settings form. From then on,
any link that points at one of those routes is automatically given the markup that
makes it open in a modal, and any form rendered inside that modal submits via
AJAX: validation errors appear inside the dialog, and on success the underlying
page can refresh so the visitor stays in context. A common use is turning an
"add" or "edit" route into an in‑place overlay so people never lose their place.

Under the hood it only alters link markup and form rendering for routes users can
already reach — it adds no new endpoints and does **not** bypass a target route's
own access checks. The single admin page it adds is the settings form, protected
by its own **administer route_in_modal** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — list the routes to modal‑ise and set
   the default dialog size.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Route In Modal**
(`/admin/config/user-interface/route-in-modal`), governed by the **administer
route_in_modal** permission.
