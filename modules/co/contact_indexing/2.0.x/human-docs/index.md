# Contact Form Indexing — manual setup guide

**Contact Form Indexing** (`contact_indexing`) gives you control over whether
search engines index your contact form pages. It adds a robots meta tag to
contact forms and, where you switch it on, sets the crawling parameters
`index,follow` — telling search engines to index that form's page and follow the
links on it.

Core Drupal doesn't expose per-form control over this, so this small SEO /
crawler-control add-on fills the gap. It's selective: indexing is turned on
form-by-form rather than site-wide, so you decide which contact forms should be
visible to crawlers. It has no module dependencies and supports Drupal 9, 10, and
11.

The module works through a simple checkbox that appears on each contact form once
it's enabled — there's no central settings page to configure. Setup is just
enabling the module and ticking the box on the forms you want indexed, as
described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central configuration page** — indexing is controlled by a checkbox
on each contact form, described below.

## Where it lives in the admin menu

Contact Form Indexing adds no settings page of its own. You control it per form at
**Structure → Contact forms → *(your form)* → Edit**
(`/admin/structure/contact`), where it adds an **Enable Form Indexing** checkbox.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Contact forms** (`/admin/structure/contact`) and edit the
   contact form you want search engines to index.
3. Tick the **Enable Form Indexing** checkbox that the module adds to the form.
4. Save the form.

With the box ticked, the module adds a robots meta tag (if one isn't already
present) with the `index,follow` parameters on that form's page, so crawlers will
index it and follow its links. Leave the box unticked on any form you'd rather
keep out of search results.
