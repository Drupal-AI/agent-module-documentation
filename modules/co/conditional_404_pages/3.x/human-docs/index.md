# Conditional 404 Pages — manual setup guide

**Conditional 404 Pages** (`conditional_404_pages`) lets you serve **different
"page not found" pages depending on which path a visitor tried to reach**. Drupal
core only lets you set a single site-wide 404 page; this module lets you tailor
the 404 experience per site section — so a docs area, a shop, a language section,
or a particular brand can each have its own not-found page.

You create conditional 404 pages by referencing an existing content item and then
configuring which path pattern(s) should trigger it. For example, configure a
conditional 404 page for the path pattern `/brand-a-site-section/*`, and a request
to a non-existent `/brand-a-site-section/does-not-exist` will display your chosen
content item instead of the generic 404. The referenced content can also be
**translated**, so a Spanish request under that section shows the Spanish
translation.

The module depends only on Drupal core, provides its own permissions, and is aimed
at site builders and content authors. One good habit for any error page: keep 404
pages free of diagnostic detail so they don't disclose information about your
site's internals.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create and manage conditional 404
   pages and the paths that trigger them.

## Where it lives in the admin menu

Conditional 404 pages are managed from an admin listing where you create each
page, choose the content item it displays, and set the path pattern(s) that
govern it. Access is restricted by the module's own permissions — grant them to
trusted site builders/administrators. See [Configuration](configuration/index.md).
