# Y Layout Builder — Webform — manual setup guide

**Y Layout Builder — Webform** (`lb_webform`) provides a block type that places an
existing **Webform** on a YMCA Layout Builder page. It is part of the YMCA Website
Services family of Layout Builder components (the `y_lb` package). Location pages
often end in a form — a membership enquiry, a programme registration, a contact
request — and placing it as a block keeps the page's structure while the form
stays a full Webform, with all its fields, validation, handlers, and access
intact.

Two things are worth checking on any placed webform. The form's **own access
settings still apply**, so a form restricted to authenticated users placed on a
public page simply will not render for anonymous visitors — and the symptom is an
empty region, not an error. And a form on a public page **will be found by bots**,
so whatever CAPTCHA or honeypot the site uses needs to apply to it; a location
page form collecting names and phone numbers is exactly what gets harvested.
Because such a form usually collects personal data, retention and
submission-access decisions are part of placing it, not an afterthought.

This module is designed to be used **with the YMCA's Website Services
distribution**. Its hard dependency on **Y Layout Builder (`y_lb`)** means it is
not a standalone install — see [Installation](installation/index.md) for the
important note about where `y_lb` actually comes from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer/Drush
   commands, and the `y_lb` dependency caveat.

This module has **no configuration page** of its own. You place the webform block
from within the Layout Builder interface, and the form's own behaviour is managed
in Webform.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). Everything happens in
**Layout Builder**: edit a page's layout, add the Webform block, and choose which
existing webform it should display. The form itself — its fields, handlers,
access, and spam protection — is managed in the **Webform** module as usual.

## How to use it

1. Enable the module (and the rest of the YMCA Website Services / `y_lb` stack it
   belongs to), and make sure the webform you want already exists.
2. Edit a page's **Layout** (Layout Builder) and **add** the Webform block to a
   section.
3. Select the existing webform to display.
4. Confirm the webform's own access settings allow your intended audience to see
   it, and that your site's CAPTCHA/honeypot applies. Save the layout.
