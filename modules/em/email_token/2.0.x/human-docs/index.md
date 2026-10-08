# Email Token — manual setup guide

**Email Token** (`email_token`) gives you a small "share this page by email"
affordance without pulling in a full social‑sharing module. It provides three
tokens under the `etf` namespace and a matching **text‑format filter** that turns
those placeholders into live values wherever your text format is used:

- **`[etf:gin-title]`** — the current page's title (blank on the front page).
- **`[etf:gin-url]`** — the absolute URL of the current page.
- **`[etf:gin-email]`** — a rendered "mail me" link (`<a href="mailto:…">`)
  wrapped in a `<div class="gin-email-token">`. Clicking it opens the visitor's
  mail application with the page title as the subject and a short message plus the
  page URL in the body.

The tokens resolve at render time from the current request, so the same block or
piece of body text produces the right title and URL on every page it appears on.
Because the values are emitted through a text filter, only users who can use the
chosen text format can insert the placeholders. There is no settings form, no
routes, and no permissions of its own — you enable the filter on a text format and
then place the tokens.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Set
it up by enabling its filter on a text format, described in "How to use it" below.

## Where it lives in the admin menu

Email Token adds no admin page. You turn it on from **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`), where
you enable its filter on the format(s) you want.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Click **Configure** next to the text format you want to use (for example
   *Basic HTML* or *Full HTML*).
3. In the **Enabled filters** list, tick **Email Token Filter**.
4. Click **Save configuration**.

Now, anywhere that format is available — a block body, a node body, a View's
header or footer text area — you can type `[etf:gin-email]` to output the "mail
me" share link, or `[etf:gin-title]` / `[etf:gin-url]` to print the current page's
title or URL inline. Just remember to select the same text format (the one you
enabled the filter on) when you enter the text.

> **Tip:** To add an email icon to the share link, style the `.gin-email-token`
> class in your theme's CSS — for example by giving it a background image.
