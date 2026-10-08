# Childfocus (notfound.org) — manual setup guide

**Childfocus (notfound.org)** (`childfocus_notfound`) turns your site's 404 "page
not found" screen into something useful: a block that shows a **missing-child
appeal** from the [notfound.org](https://notfound.org/) initiative. notfound.org is
a Belgian Child Focus project built on a simple observation — every website has a
404 page that nobody designs and everybody occasionally lands on, and that unused
space can carry a missing-child appeal instead of a dead end. The block shows a
case relevant to the visitor's region, so a lost page points the visitor toward a
lost child.

The module provides a **block plugin** you place in your theme, plus a **block
visibility condition** ("Childfocus (notfound.org)") so the appeal shows only on
404 responses rather than on every page. To display real cases you need a **key**
from notfound.org: you sign up on their site, copy the key out of the embed code
they give you, and paste it into this module's settings form. Its only dependency
is core's **Block** module.

Two things worth knowing before you deploy it. First, this release targets
**Drupal 11 only** (`core_version_requirement: ^11`), an unusually narrow range.
Second, the block renders content served from a third party, so it adds an external
request to your 404 response — treat it like any other embedded widget in your
privacy/consent review, and remember that 404 pages are hit frequently by crawlers
and scanners, not just people, so the widget is requested far more often than a
page-view count would suggest.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — get your notfound.org key, enter it,
   and place the block on the 404 page.

## Where it lives in the admin menu

The module's settings form sits at **Configuration → Childfocus (notfound.org)**
(`/admin/config/childfocus_notfound`), reachable by users with the **Administer
site configuration** permission. Block placement happens at **Structure → Block
layout** (`/admin/structure/block`).
