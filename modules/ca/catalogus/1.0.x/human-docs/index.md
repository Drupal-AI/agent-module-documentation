# Dominican Catalogus — manual setup guide

**Dominican Catalogus** (`catalogus`) is a packaged content solution for keeping
records of a religious order — specifically the friars of the Order of Preachers
(Dominicans). It builds a community catalogue: two main content types, **people**
and **communities**, where people are assigned to houses and ministries for fixed
periods, each record carrying start and end dates so a complete history of
assignments is preserved. Rather than a generic address book, it models the
order's own distinctions (clerical versus lay brothers, "simple assignation"
versus "assigned by way of office"), and it can export catalogue pages to PDF
through Entity Print.

Because it is a complete solution rather than a small utility, it pulls in a
large set of dependencies — Address, Node, Taxonomy, Menu UI, Text, Datetime,
Entity Print Views, Computed Field, Field Group, and Auto Entity Label — which
Composer installs alongside it. It ships a settings form where you record your
**Provincial community ID**, declares Entity Print mappings so nodes and views
can be exported as PDF at `catalogus/pdf`, and provides a custom
`AddressHideUSAFormatter` field formatter (for hiding "USA" from address output).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

A note on access: the module also registers a `/community/{cid}/back-on/{date}`
route that is gated only by the **access content** permission, which is granted to
anonymous users by default — so that path is effectively public. In this release
it only returns placeholder markup (a controller stub with no real content), so
there is nothing sensitive behind it today; just be aware of it if you extend the
module. The project is **not covered by Drupal's security advisory policy**.

## Contents

1. [Installation](installation/index.md) — install with Composer (with its
   dependency set) and enable the module.
2. [Configuration](configuration/index.md) — set your Provincial community ID and
   build/export catalogue pages.

## Where it lives in the admin menu

The settings form lives at **Configuration → Content authoring → Catalogus**
(`/admin/config/content/catalogus`), gated by the **Administer site
configuration** permission. PDF export of catalogue content is served at
`catalogus/pdf` via Entity Print.
