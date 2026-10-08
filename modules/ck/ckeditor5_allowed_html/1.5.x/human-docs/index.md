# CKEditor 5 Allowed HTML — manual setup guide

**CKEditor 5 Allowed HTML** (`ckeditor5_allowed_html`) restores a piece of
functionality that CKEditor 4 sites relied on but CKEditor 5 removed. In Drupal 10/11,
when you use the core *Limit allowed HTML tags and correct faulty HTML* filter, the
list of allowed HTML tags becomes read-only — core maintains it automatically based on
which editor buttons and filters are enabled. Sites that need extra, custom tags or
attributes normally have to write CKEditor plugins to support them.

This module offers an easier path: it provides a **new filter** that is a copy of the
core "Limit allowed HTML tags" filter in every way except one — its **Allowed HTML
tags list is editable**. You select it on a text format and then type in whatever
additional tags and attributes your content needs. This is especially handy when
migrating a CKEditor 4 site that had an extensive allow-list. The module has no
configuration page and no access-control role; it works across Drupal 8.8 through 11.

**This is a security-relevant module — use it deliberately.** Allowing more HTML widens
what content can contain, so any tag or attribute you permit is a potential XSS vector
if the text format is available to less-trusted authors. Add only what you actually
need, avoid enabling script or event-handler-bearing markup, and keep permissive
formats restricted to trusted roles. Also note that, unlike the core filter, this
filter does **not** maintain the list for you — once you switch to the editable filter,
keeping the allowed-tags list correct is your responsibility.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no standalone settings page. You select and configure the filter per text
format at **Administration → Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`).

## How to use it in a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit the
   format you want to extend.
2. In the list of filters, enable **Limit allowed HTML tags and correct faulty HTML —
   Editable tag list** *instead of* the original core "Limit allowed HTML tags and
   correct faulty HTML" filter.
3. Scroll down to that filter's settings tab (labelled the same way), where the
   **Allowed HTML tags** field is now editable.
4. Add the tags and attributes you need, then save.

> **Tip:** to get a good starting point, temporarily enable the *original* core filter
> to see the list it recommends for your current toolbar, copy that list, then switch
> to this editable filter and paste it in — adding only the extra tags you require on
> top.
